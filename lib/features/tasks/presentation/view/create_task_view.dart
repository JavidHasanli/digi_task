import 'package:digi_task/core/constants/theme/theme_ext.dart';
import 'package:digi_task/core/utility/extension/icon_path_ext.dart';
import 'package:digi_task/features/tasks/data/model/create_task_model.dart';
import 'package:digi_task/features/tasks/presentation/notifier/task_notifier.dart';
import 'package:digi_task/features/tasks/presentation/view/problem/widgets/select_service_card.dart';
import 'package:digi_task/presentation/components/button/login_button.dart';
import 'package:digi_task/presentation/components/flushbar.dart';
import 'package:digi_task/presentation/components/input/app_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';
import 'package:provider/provider.dart';

import '../../../../core/constants/path/icon_path.dart';
import '../notifier/task_create_state.dart';

class CreateTaskView extends StatefulWidget {
  const CreateTaskView({super.key});

  @override
  State<CreateTaskView> createState() => _CreateTaskViewState();
}

class _CreateTaskViewState extends State<CreateTaskView> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController registrationController = TextEditingController();
  final TextEditingController contactController = TextEditingController();
  final TextEditingController adressController = TextEditingController();
  final TextEditingController regionController = TextEditingController();
  final TextEditingController noteController = TextEditingController();
  final MultiSelectController _controller = MultiSelectController();

  List<int> selectGroupList = [];
  bool isInternet = false;
  bool isTv = false;
  bool isVoice = false;

  DateTime date = DateTime.now();
  late String formattedDate;
  late String startTimeFormatted;
  late String endTimeFormatted;

  @override
  void initState() {
    super.initState();
    formattedDate = DateFormat('yyyy-MM-dd').format(date);
    startTimeFormatted = DateFormat.Hm().format(DateTime.now());
    endTimeFormatted = DateFormat.Hm().format(DateTime.now());
  }

  @override
  Widget build(BuildContext context) {
    final taskType = (GoRouterState.of(context).extra as String?) ?? '';

    return Scaffold(
      backgroundColor: context.colors.neutralColor100,
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: Colors.white,
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              context.pop();
            },
            icon: SvgPicture.asset(IconPath.arrowleft.toPathSvg)),
        title: Text('Yeni Tapşırıq', style: context.typography.subtitle2Medium),
        actions: [
          IconButton(
              onPressed: () {}, icon: SvgPicture.asset(IconPath.menu.toPathSvg))
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
          child: Column(
            children: [
              AppField(
                title: 'Ad Soyad',
                controller: nameController,
                filledColor: context.colors.backgroundColor,
                isProfileView: false,
                hintText: 'Ad Soyad',
              ),  
              const SizedBox(
                height: 16,
              ),
              AppField(
                title: 'Qeydiyyat nömrəsi',
                controller: registrationController,
                filledColor: context.colors.backgroundColor,
                isProfileView: false,
                hintText: '0555555555',
                keyboardType: TextInputType.phone,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9]+'))
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              AppField(
                title: 'Əlaqə nömrəsi',
                controller: contactController,
                filledColor: context.colors.backgroundColor,
                isProfileView: false,
                hintText: '0555555555',
                keyboardType: TextInputType.phone,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9]+'))
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              AppField(
                title: 'Adres',
                controller: adressController,
                filledColor: context.colors.backgroundColor,
                isProfileView: false,
                hintText: 'Küçə',
              ),
              const SizedBox(
                height: 16,
              ),
              Row(
                children: [
                  Expanded(
                    child: AppField(
                      centerText: true,
                      onlyRead: true,
                      title: 'Tarix',
                      filledColor: context.colors.backgroundColor,
                      isProfileView: false,
                      hintText: formattedDate,
                      onTap: () {
                        showDatePicker(
                          context: context,
                          firstDate: DateTime(2020, 9, 7, 17, 30),
                          lastDate: DateTime(2040, 9, 7, 17, 30),
                        ).then((selectedDate) {
                          if (selectedDate != null) {
                            setState(() {
                              date = selectedDate;
                              formattedDate =
                                  DateFormat('yyyy-MM-dd').format(selectedDate);
                            });
                          }
                        });
                      },
                    ),
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  Expanded(
                    child: AppField(
                      centerText: true,
                      onlyRead: true,
                      title: 'Başlayır',
                      filledColor: context.colors.backgroundColor,
                      isProfileView: false,
                      hintText: startTimeFormatted,
                      onTap: () {
                        showTimePicker(
                            context: context,
                            initialEntryMode: TimePickerEntryMode.input,
                            initialTime: TimeOfDay.now(),
                            builder: (context, child) {
                              return MediaQuery(
                                  data: MediaQuery.of(context)
                                      .copyWith(alwaysUse24HourFormat: true),
                                  child: child!);
                            }).then(
                          (selectedTime) {
                            if (selectedTime != null) {
                              setState(() {
                                startTimeFormatted =
                                    selectedTime.format(context);
                              });
                            }
                          },
                        );
                      },
                    ),
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  Expanded(
                    child: AppField(
                      centerText: true,
                      onlyRead: true,
                      title: 'Bitir',
                      filledColor: context.colors.backgroundColor,
                      isProfileView: false,
                      hintText: endTimeFormatted,
                      onTap: () {
                        showTimePicker(
                            context: context,
                            initialEntryMode: TimePickerEntryMode.input,
                            initialTime: TimeOfDay.now(),
                            builder: (context, child) {
                              return MediaQuery(
                                  data: MediaQuery.of(context)
                                      .copyWith(alwaysUse24HourFormat: true),
                                  child: child!);
                            }).then((selectedTime) {
                          if (selectedTime != null) {
                            setState(() {
                              endTimeFormatted = selectedTime.format(context);
                            });
                          }
                        });
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Servis',
                    style: context.typography.body2Regular
                        .copyWith(color: context.colors.neutralColor10),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: SelectServiceCard(
                          isSelected: isTv,
                          onTap: () {
                            setState(() {
                              isTv = !isTv;
                            });
                          },
                          image: IconPath.tv.toPathSvg,
                          title: 'Tv',
                        ),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Expanded(
                        child: SelectServiceCard(
                          isSelected: isInternet,
                          onTap: () {
                            setState(() {
                              isInternet = !isInternet;
                            });
                          },
                          image: IconPath.internet.toPathSvg,
                          title: 'İnternet',
                        ),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Expanded(
                        child: SelectServiceCard(
                          isSelected: isVoice,
                          onTap: () {
                            setState(() {
                              isVoice = !isVoice;
                            });
                          },
                          image: IconPath.voice.toPathSvg,
                          title: 'Voice',
                        ),
                      ),
                    ],
                  )
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              Row(
                children: [
                  Text(
                    'Texniki Qrup',
                    style: context.typography.body2Regular
                        .copyWith(color: context.colors.neutralColor10),
                  ),
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              MultiSelectDropDown(
                selectedItemBuilder: (p0, p1) => Container(
                    decoration: BoxDecoration(
                        color: context.colors.primaryColor99,
                        borderRadius: BorderRadius.circular(8)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8.0, vertical: 4),
                      child: Text(p1.label,
                          style: context.typography.body2SemiBold),
                    )),
                animateSuffixIcon: false,
                dropdownBorderRadius: 8,
                controller: _controller,
                borderRadius: 8,
                borderColor: Colors.white,
                onOptionSelected: (options) {
                  selectGroupList =
                      options.map((e) => int.parse(e.value)).toList();
                },
                dropdownBackgroundColor: context.colors.backgroundColor,
                fieldBackgroundColor: context.colors.backgroundColor,
                focusedBorderColor: Colors.white,
                hint: "Qrup",
                hintStyle: context.typography.body2SemiBold
                    .copyWith(color: context.colors.neutralColor60),
                options: const <ValueItem>[
                  ValueItem(label: 'Qrup 1', value: '1'),
                  ValueItem(label: 'Qrup 2', value: '2'),
                ],
                maxItems: 2,
                selectionType: SelectionType.multi,
                chipConfig: const ChipConfig(wrapType: WrapType.wrap),
                dropdownHeight: 100,
                optionTextStyle: context.typography.body2SemiBold
                    .copyWith(color: context.colors.neutralColor60),
                selectedOptionIcon: const Icon(Icons.check),
              ),
              const SizedBox(
                height: 16,
              ),
              AppField(
                title: 'Qeyd',
                controller: noteController,
                filledColor: context.colors.backgroundColor,
                isProfileView: false,
                hintText: 'Qeydlər',
                minLine: 3,
                maxLine: 3,
              ),
              const SizedBox(
                height: 32,
              ),
              Consumer<TaskNotifier>(
                builder: (_, notifier, child) {
                  return ActionButton(
                    title: 'Əlavə et',
                    isLoading: notifier.createState is TaskCreateProgress
                        ? true
                        : false,
                    onPressed: () async {
                      if (nameController.text.trim().isNotEmpty &&
                          contactController.text.trim().isNotEmpty &&
                          registrationController.text.trim().isNotEmpty &&
                          adressController.text.trim().isNotEmpty &&
                          noteController.text.trim().isNotEmpty &&
                          selectGroupList.isNotEmpty) {
                        final model = CreateTaskModel(
                            fullName: nameController.text.trim(),
                            contactNumber: contactController.text.trim(),
                            registrationNumber:
                                registrationController.text.trim(),
                            isInternet: isInternet,
                            isTv: isTv,
                            isVoice: isVoice,
                            user: null,
                            date: formattedDate,
                            location: adressController.text.trim(),
                            note: noteController.text.trim(),
                            group: selectGroupList,
                            // time: "$startTimeFormatted-$endTimeFormatted",
                            startTime: startTimeFormatted,
                            endTime: endTimeFormatted,
                            taskType: taskType,
                            status: "waiting");
                        await notifier.createTask(model);
                        if (notifier.createState is TaskCreateSuccess &&
                            mounted) {
                          context.pop();
                          context.pop();
                        } else if (notifier.createState is TaskCreateFailure) {
                          openFlushbar(context,
                              title: 'Uğursuz əməliyyat',
                              color: context.colors.errorColor80);
                        }
                      } else {
                        openFlushbar(context,
                            title: 'Boşluqları doldurun', color: Colors.white);
                      }
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    contactController.dispose();
    noteController.dispose();
    registrationController.dispose();
    adressController.dispose();
  }
}
