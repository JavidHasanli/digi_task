import 'dart:async';
import 'package:digi_task/features/tasks/presentation/view/problem/task_service.dart';
import 'package:digi_task/features/tasks/presentation/view/problem/widgets/problem_card.dart';
import 'package:digi_task/features/tasks/presentation/view/problem/widgets/problem_dropdown.dart';
import 'package:digi_task/features/tasks/presentation/view/problem/widgets/problem_multiselect.dart';
import 'package:digi_task/features/tasks/presentation/view/problem/widgets/problem_timefield.dart';
import 'package:digi_task/features/tasks/presentation/view/problem/widgets/task_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:digi_task/features/tasks/data/model/task_model.dart';
import 'package:digi_task/features/tasks/presentation/view/problem/widgets/service_detail.dart';
import 'package:digi_task/features/tasks/presentation/view/problem/widgets/service_dialog.dart';
import 'package:digi_task/notifier/home/main/main_notifier.dart';

class ProblemTask extends StatefulWidget {
  final String serviceType;
  final int taskId;
  final TaskModel taskData;

  const ProblemTask({
    super.key,
    required this.serviceType,
    required this.taskId,
    required this.taskData,
  });

  @override
  _ProblemTaskState createState() => _ProblemTaskState();
}

class _ProblemTaskState extends State<ProblemTask> {
  late Future<TaskModel> task;
  final _formKey = GlobalKey<FormState>();
  late TextEditingController fullNameController;
  late TextEditingController registrationNumberController;
  late TextEditingController contactNumberController;
  late TextEditingController locationController;
  late TextEditingController statusController;
  late TextEditingController groupController;
  late TextEditingController noteController;
  late TextEditingController dateController;
  late TextEditingController startTimeController;
  late TextEditingController endTimeController;

  String? selectedStatus;
  List<String> selectedServices = [];
  List<String> selectedTechnicalGroups = [];

  bool isEditing = false;
  final List<String> services = ['Tv', 'Internet', 'Voice'];
  final List<String> statusOptions = ['completed', 'inprogress', 'waiting'];
  final List<String> technicalGroupOptions = ['Qrup 1', 'Qrup 2'];

  final List<Map<String, dynamic>> mockData = [
    {'icon': Icons.person_2_outlined, 'title': 'Ad və soyad:'},
    {'icon': Icons.phone, 'title': 'Qeydiyyat nömrəsi'},
    {'icon': Icons.phone_callback_outlined, 'title': 'Əlaqə nömrəsi'},
    {'icon': Icons.location_on_outlined, 'title': 'Adres'},
    {'icon': Icons.date_range_outlined, 'title': 'Tarix'},
    {'icon': null, 'title': 'Qeyd'},
  ];

  @override
  void initState() {
    super.initState();
    _initializeTask();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<MainNotifier>().checkAdmin();
    });
  }

  void _initializeTask() {
    task = TaskService().fetchTask(widget.taskId);
    task.then((taskData) {
      if (taskData != null) {
        setState(() {
          selectedTechnicalGroups =
              taskData.group != null && taskData.group!.isNotEmpty
                  ? taskData.group!
                      .map((group) => group.group)
                      .toList()
                      .cast<String>()
                  : [];
          fullNameController =
              TextEditingController(text: taskData.fullName ?? '');
          registrationNumberController =
              TextEditingController(text: taskData.registrationNumber ?? '');
          contactNumberController =
              TextEditingController(text: taskData.contactNumber ?? '');
          locationController =
              TextEditingController(text: taskData.location ?? '');
          statusController = TextEditingController(text: taskData.status ?? '');
          noteController = TextEditingController(text: taskData.note ?? '');
          dateController = TextEditingController(text: taskData.date ?? '');
          startTimeController =
              TextEditingController(text: _formatTime(taskData.startTime));
          endTimeController =
              TextEditingController(text: _formatTime(taskData.endTime));

          groupController =
              TextEditingController(text: selectedTechnicalGroups.join(','));
          noteController =
              TextEditingController(text: widget.taskData.note ?? '');
          selectedServices = _getSelectedServices(taskData);
        });
      }
    });
  }

  String _formatTime(String? time) {
    if (time == null) return '';
    return DateFormat('HH:mm').format(DateFormat('HH:mm:ss').parse(time));
  }

  List<String> _getSelectedServices(TaskModel taskData) {
    List<String> services = [];
    if (taskData.isTv == true) services.add('Tv');
    if (taskData.isInternet == true) services.add('Internet');
    if (taskData.isVoice == true) services.add('Voice');
    return services;
  }

  Future<void> _selectTime(
      BuildContext context, TextEditingController controller) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
          child: child!,
        );
      },
    );

    if (pickedTime != null) {
      final now = DateTime.now();
      final selectedDateTime = DateTime(
          now.year, now.month, now.day, pickedTime.hour, pickedTime.minute);

      final fullTime = DateFormat('HH:mm:ss').format(selectedDateTime);
      final displayTime = DateFormat('HH:mm').format(selectedDateTime);

      setState(() {
        controller.text = displayTime;
        if (controller == startTimeController) {
          widget.taskData.startTime = fullTime;
        } else if (controller == endTimeController) {
          widget.taskData.endTime = fullTime;
        }
      });

      print(
          'Updated ${controller == startTimeController ? 'Start Time' : 'End Time'}: $displayTime');
    }
  }

  Future<void> _updateTask() async {
    try {
      final List<int> groupIds = selectedTechnicalGroups
          .map((group) {
            if (group == 'Qrup 1') return 1;
            if (group == 'Qrup 2') return 2;
            return null;
          })
          .whereType<int>()
          .toList();

      final startTime = startTimeController.text.isNotEmpty
          ? startTimeController.text
          : widget.taskData.startTime ?? '';
      final endTime = endTimeController.text.isNotEmpty
          ? endTimeController.text
          : widget.taskData.endTime ?? '';

      await TaskApi().updateTask(
        context: context,
        taskId: widget.taskId.toString(),
        fullName: fullNameController.text,
        startTime: startTime,
        endTime: endTime,
        registrationNumber: registrationNumberController.text,
        contactNumber: contactNumberController.text,
        location: locationController.text,
        status: statusController.text,
        note: noteController.text,
        date: dateController.text,
        groupData: groupIds,
        selectedServices: selectedServices,
        taskData: widget.taskData,
      );

      _initializeTask();
      setState(() {
        isEditing = false;
      });
    } catch (e) {
      print('Failed to update task: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final isAdmin = context.watch<MainNotifier>().isAdmin;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Problem'),
        backgroundColor: Colors.white,
        actions: [
          if (isAdmin)
            IconButton(
              icon: Icon(
                isEditing ? Icons.save : Icons.edit,
                color: Colors.blue,
              ),
              onPressed: () async {
                if (isEditing) {
                  if (_formKey.currentState?.validate() ?? false) {
                    await _updateTask();
                  }
                } else {
                  setState(() {
                    isEditing = true;
                  });
                }
              },
            ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: FutureBuilder<TaskModel>(
            future: task,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (!snapshot.hasData || snapshot.data == null) {
                return const Center(child: Text('Məlumat yoxdur'));
              } else {
                final taskData = snapshot.data!;
                fullNameController.text = taskData.fullName ?? '';
                registrationNumberController.text =
                    taskData.registrationNumber ?? '';
                contactNumberController.text = taskData.contactNumber ?? '';
                locationController.text = taskData.location ?? '';
                selectedStatus ??= taskData.status;
                statusController.text = selectedStatus ?? '';
                noteController.text = taskData.note ?? '';
                dateController.text = taskData.date ?? '';

                groupController.text = selectedTechnicalGroups.join(', ');
                final availableServiceTypes =
                    _getAvailableServiceTypes(taskData);
                final hasAvailableServices = availableServiceTypes.isNotEmpty;

                return Container(
                  color: Colors.white,
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        ...mockData
                            .where((data) => data['title'] != 'Saat')
                            .map((data) {
                          final controller =
                              _getControllerForTitle(data['title'] as String);
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                            child: TextFormField(
                              controller: controller,
                              textAlign: TextAlign.left,
                              decoration: InputDecoration(
                                labelText: data['title'] as String,
                                labelStyle: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  textBaseline: TextBaseline.alphabetic,
                                ),
                                prefixIcon: data['icon'] != null
                                    ? Icon(
                                        data['icon'] as IconData,
                                        color: Colors.blue,
                                      )
                                    : null,
                              ),
                              onTap: () {
                                if (data['title'] == 'Saat') {
                                  _selectTime(context, controller);
                                }
                              },
                              readOnly: !isAdmin || !isEditing,
                              validator: data['title'] == 'Tarix'
                                  ? (value) {
                                      final datePattern =
                                          RegExp(r'^\d{4}-\d{2}-\d{2}$');
                                      if (value == null ||
                                          !datePattern.hasMatch(value)) {
                                        return 'Tarix formatı yyyy-mm-dd olmalıdır';
                                      }
                                      return null;
                                    }
                                  : null,
                              inputFormatters:
                                  (data['title'] == 'Qeydiyyat nömrəsi' ||
                                          data['title'] == 'Əlaqə nömrəsi')
                                      ? [
                                          FilteringTextInputFormatter.allow(
                                              RegExp(r'[0-9]+')),
                                        ]
                                      : null,
                            ),
                          );
                        }),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            Expanded(
                              child: TimeSelectionField(
                                labelText: 'Başlangıç Saatı',
                                controller: startTimeController,
                                isAdmin: isAdmin && isEditing,
                                onTap: () async {
                                  await _selectTime(
                                      context, startTimeController);
                                },
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: TimeSelectionField(
                                labelText: 'Bitiş Saatı',
                                controller: endTimeController,
                                isAdmin: isAdmin && isEditing,
                                onTap: () async {
                                  await _selectTime(context, endTimeController);
                                },
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 8),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: DropdownWithIcon(
                                  labelText: 'Status',
                                  icon: Icons.comment_bank_outlined,
                                  value: statusOptions
                                          .contains(statusController.text)
                                      ? statusController.text
                                      : null,
                                  items: statusOptions,
                                  onChanged: isAdmin
                                      ? (String? newValue) {
                                          setState(() {
                                            selectedStatus = newValue;
                                            statusController.text =
                                                newValue ?? '';
                                          });
                                        }
                                      : null,
                                  isAdmin: isAdmin && isEditing,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Statusu seçin';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: MultiSelectWithIcon(
                                  labelText: 'Texniki qrup',
                                  icon: Icons.engineering_outlined,
                                  isAdmin: isAdmin && isEditing,
                                  emptyText: 'Qrup seçin zəhmət olmasa',
                                  options: technicalGroupOptions,
                                  items: selectedTechnicalGroups,
                                  onChanged: (List<String> value) {
                                    setState(() {
                                      selectedTechnicalGroups = value;
                                      groupController.text =
                                          selectedTechnicalGroups.join(', ');
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        MultiSelectWithIcon(
                          labelText: 'Servis',
                          icon: Icons.miscellaneous_services_outlined,
                          isAdmin: isAdmin && isEditing,
                          emptyText: 'Servis növü seçin zəhmət olmasa',
                          options: services,
                          items: selectedServices,
                          onChanged: (List<String> value) {
                            setState(() {
                              selectedServices = value;
                              print('Selected services: $selectedServices');
                              widget.taskData.isTv =
                                  selectedServices.contains('Tv');
                              widget.taskData.isInternet =
                                  selectedServices.contains('Internet');
                              widget.taskData.isVoice =
                                  selectedServices.contains('Voice');
                            });
                          },
                        ),
                        const SizedBox(height: 16),
                        if (widget.serviceType.isNotEmpty)
                          ServiceDetailsWidget(
                            serviceType: widget.serviceType,
                            taskId: widget.taskId,
                            taskData: taskData,
                          ),
                        const SizedBox(height: 16),
                        if (hasAvailableServices)
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                            child: GestureDetector(
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return ServiceDialog(
                                      serviceType: widget.serviceType,
                                      taskId: widget.taskId,
                                      taskData: widget.taskData,
                                    );
                                  },
                                );
                              },
                              child: const CardWithTitleAndIcon(
                                title: 'Problem anketi',
                                icon: Icons.add,
                              ),
                            ),
                          ),
                        const SizedBox(height: 16),
                      ],
                    ),
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }

  TextEditingController _getControllerForTitle(String title) {
    switch (title) {
      case 'Ad və soyad:':
        return fullNameController;
      case 'Qeydiyyat nömrəsi':
        return registrationNumberController;
      case 'Əlaqə nömrəsi':
        return contactNumberController;
      case 'Adres':
        return locationController;
      case 'Tarix':
        return dateController;
      case 'Status':
        return statusController;
      case 'Texniki qrup':
        return groupController;
      case 'Qeyd':
        return noteController;

      default:
        return TextEditingController();
    }
  }

  List<String> _getAvailableServiceTypes(TaskModel taskData) {
    List<String> availableServiceTypes = [];
    if (taskData.isInternet == true && taskData.internet == null) {
      availableServiceTypes.add('Internet');
    }
    if (taskData.isTv == true && taskData.tv == null) {
      availableServiceTypes.add('Tv');
    }
    if (taskData.isVoice == true && taskData.voice == null) {
      availableServiceTypes.add('Voice');
    }
    return availableServiceTypes;
  }

  @override
  void dispose() {
    fullNameController.dispose();
    registrationNumberController.dispose();
    contactNumberController.dispose();
    locationController.dispose();
    statusController.dispose();
    groupController.dispose();
    noteController.dispose();
    dateController.dispose();
    startTimeController.dispose();
    endTimeController.dispose();
    super.dispose();
  }
}
