import 'package:digi_task/core/constants/path/icon_path.dart';
import 'package:digi_task/core/constants/theme/theme_ext.dart';
import 'package:digi_task/core/utility/extension/icon_path_ext.dart';
import 'package:digi_task/data/services/local/secure_service.dart';
import 'package:digi_task/features/tasks/presentation/notifier/task_notifier.dart';
import 'package:digi_task/features/tasks/presentation/notifier/task_state.dart';
import 'package:digi_task/features/tasks/presentation/view/problem/problem_task.dart';
import 'package:digi_task/shared/widgets/user_task_card.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../../../../presentation/components/custom_progress_indicator.dart';
import '../../../../../../presentation/components/service_type.dart';
import '../../../../../../notifier/home/main/main_notifier.dart';

class TasksTab extends StatefulWidget {
  const TasksTab({super.key});

  @override
  State<TasksTab> createState() => _TasksTabState();
}

class _TasksTabState extends State<TasksTab> with TickerProviderStateMixin {
  late final TabController tabController;
  final Map<String, String> buttonStates = {};

  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
    tabController.addListener(_onTabChanged);
  }

  void _onTabChanged() {
    _fetchTasksBasedOnTabAndIndex(selectedIndex);
  }

  @override
  Widget build(BuildContext context) {
    final isAdmin = context.watch<MainNotifier>().isAdmin;

    return Column(
      children: [
        Container(
          color: Colors.white,
          child: TabBar(
            controller: tabController,
            onTap: (value) {
              setState(() {
                selectedIndex = 0;
              });
              if (value == 1) {
                context.read<TaskNotifier>().fetchTasks(queryType: "problem");
              } else {
                context
                    .read<TaskNotifier>()
                    .fetchTasks(queryType: "connection");
              }
            },
            labelColor: context.colors.primaryColor50,
            labelStyle: context.typography.subtitle2Medium,
            indicatorSize: TabBarIndicatorSize.tab,
            dividerColor: context.colors.neutralColor80,
            indicatorColor: context.colors.primaryColor50,
            tabs: const [
              Tab(text: "Qoşulmalar"),
              Tab(text: "Problemlər"),
            ],
          ),
        ),
        const SizedBox(height: 20),
        SizedBox(
          height: 60,
          child: ListView.builder(
            padding: const EdgeInsets.only(left: 16),
            scrollDirection: Axis.horizontal,
            itemCount: 4,
            itemBuilder: (context, index) {
              final texts = [
                'Hamisi',
                'Gözləmədə olan',
                'Qəbul edilən',
                'Keçmiş'
              ];
              return Padding(
                padding: const EdgeInsets.only(right: 8),
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedIndex = index;
                    });
                    _fetchTasksBasedOnTabAndIndex(index);
                  },
                  child: RawChip(
                    onPressed: () {
                      setState(() {
                        selectedIndex = index;
                      });
                      _fetchTasksBasedOnTabAndIndex(index);
                    },
                    showCheckmark: false,
                    label: Text(texts[index]),
                    labelStyle: context.typography.overlineSemiBold.copyWith(
                      color: selectedIndex == index
                          ? Colors.white
                          : context.colors.primaryColor50,
                    ),
                    labelPadding: const EdgeInsets.symmetric(
                      vertical: 8,
                      horizontal: 16,
                    ),
                    backgroundColor: Colors.white,
                    selectedColor: context.colors.primaryColor50,
                    selected: selectedIndex == index,
                    shape: const StadiumBorder(
                      side: BorderSide(color: Colors.transparent),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 20),
        Consumer<TaskNotifier>(
          builder: (context, notifier, child) {
            if (notifier.state is TaskProgress) {
              return const Center(
                child: CustomProgressIndicator(),
              );
            } else if (notifier.state is TaskSuccess) {
              final taskNotifier = notifier.state as TaskSuccess;
              return Expanded(
                child: ListView.builder(
                  itemCount: taskNotifier.tasks?.length,
                  itemBuilder: (context, index) {
                    final task = taskNotifier.tasks![index];
                    final nowDateTime = DateTime.now();
                    final dateTime = DateTime.parse(task.date ?? '');
                    String formattedDate = DateFormat('MMM d').format(dateTime);
                    String nowFormattedDate =
                        DateFormat('MMM d').format(nowDateTime);

                    return Padding(
                      padding: const EdgeInsets.only(
                          left: 16, right: 16, bottom: 24),
                      child: GestureDetector(
                        onTap: () {
                          List<String> serviceTypes = [];
                          if (task.isInternet == true) {
                            serviceTypes.add('Internet');
                          }
                          if (task.isTv == true) {
                            serviceTypes.add('Tv');
                          }
                          if (task.isVoice == true) {
                            serviceTypes.add('Voice');
                          }
                          String serviceType = serviceTypes.join(', ');

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProblemTask(
                                serviceType: serviceType,
                                taskId: task.id,
                                taskData: task,
                              ),
                            ),
                          );
                        },
                        child: UserTaskCard(
                          iconRow: Row(
                            children: [
                              if (task.isInternet == true)
                                ServiceType(
                                  image: IconPath.internet.toPathSvg,
                                  title: "Internet",
                                ),
                              if (task.isTv == true)
                                ServiceType(
                                  image: IconPath.tv.toPathSvg,
                                  title: "Tv",
                                ),
                              if (task.isVoice == true)
                                ServiceType(
                                  image: IconPath.voice.toPathSvg,
                                  title: "Voice",
                                ),
                            ],
                          ),
                          name: task.firstName ?? 'İstifadəçi tapılmadı',
                          time: formattedDate == nowFormattedDate
                              ? 'Bu gün, ${task.time}'
                              : '$formattedDate, ${task.time}',
                          location: task.location ?? '',
                          number: task.contactNumber ?? '',
                          status:
                              isAdmin ? _getStatusText(task.status ?? '') : '',
                          notifier: notifier,
                          group: (task.group?.isNotEmpty ?? false)
                              ? '${task.group?.first.group}'
                              : "Empty group",
                          button: !isAdmin
                              ? ElevatedButton(
                                  onPressed: () async {
                                    String currentButtonText =
                                        buttonStates[task.id.toString()] ??
                                            _getButtonText(task.status ?? '');
                                    String nextStatus = '';
                                    String nextButtonText = '';

                                    switch (currentButtonText) {
                                      case 'Başla':
                                        nextStatus = 'inprogress';
                                        nextButtonText = 'Tamamla';
                                        break;
                                      case 'Tamamla':
                                        nextStatus = 'completed';
                                        nextButtonText = 'Tamamlandı';
                                        break;
                                      case 'Tamamlandı':
                                        nextButtonText = 'Tamamlandı';
                                        break;
                                      default:
                                        nextStatus = 'waiting';
                                        nextButtonText = 'Başla';
                                        break;
                                    }

                                    if (currentButtonText != 'Tamamlandı') {
                                      await _updateTaskStatus(
                                          task.id.toString(), nextStatus);

                                      setState(() {
                                        buttonStates[task.id.toString()] =
                                            nextButtonText;
                                      });

                                      _fetchTasksBasedOnTabAndIndex(
                                          selectedIndex);
                                    }
                                  },
                                  style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Colors.white),
                                    foregroundColor:
                                        MaterialStateProperty.all<Color>(
                                            const Color(0xFF005ABF)),
                                    side: MaterialStateProperty.all<BorderSide>(
                                      const BorderSide(
                                          color: Color(0xFF005ABF), width: 1.0),
                                    ),
                                    shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                  ),
                                  child: Text(
                                    buttonStates[task.id.toString()] ??
                                        _getButtonText(task.status ?? ''),
                                  ),
                                )
                              : null,
                        ),
                      ),
                    );
                  },
                ),
              );
            }
            return const SizedBox.shrink();
          },
        )
      ],
    );
  }

  Future<void> _updateTaskStatus(String taskId, String newStatus) async {
    final dio = Dio();
    final String url = 'http://135.181.42.192/services/task/$taskId/update/';

    try {
      final secureService =
          SecureService(secureStorage: const FlutterSecureStorage());
      final accessToken = await secureService.accessToken;

      if (accessToken == null) {
        print('Access token not found. Please log in again.');
        return;
      }

      final response = await dio.patch(
        url,
        data: {'status': newStatus},
        options: Options(
          headers: {
            'Authorization': 'Bearer $accessToken',
          },
        ),
      );

      if (response.statusCode == 200) {
        print('Task status updated to $newStatus');
      } else {
        print('Failed to update task status: ${response.statusCode}');
      }
    } catch (e) {
      print('Error updating task status: $e');
    }
  }

  void _fetchTasksBasedOnTabAndIndex(int index) {
    final isAdmin = context.read<MainNotifier>().isAdmin;
    final tabIndex = tabController.index;

    if (isAdmin) {
      if (tabIndex == 0) {
        switch (index) {
          case 0:
            context.read<TaskNotifier>().fetchTasks(
                  queryType: "connection",
                );
            break;
          case 1:
            context.read<TaskNotifier>().fetchTasks(
                  queryType: "connection",
                  queryStatus: "waiting",
                );
            break;
          case 2:
            context.read<TaskNotifier>().fetchTasks(
                  queryType: "connection",
                  queryStatus: "inprogress",
                );
            break;
          case 3:
            context.read<TaskNotifier>().fetchTasks(
                  queryType: "connection",
                  queryStatus: "completed",
                );
            break;
          default:
            context.read<TaskNotifier>().fetchTasks(
                  queryType: "connection",
                );
            break;
        }
      } else if (tabIndex == 1) {
        switch (index) {
          case 0:
            context.read<TaskNotifier>().fetchTasks(
                  queryType: "problem",
                );
            break;
          case 1:
            context.read<TaskNotifier>().fetchTasks(
                  queryType: "problem",
                  queryStatus: "waiting",
                );
            break;
          case 2:
            context.read<TaskNotifier>().fetchTasks(
                  queryType: "problem",
                  queryStatus: "inprogress",
                );
            break;
          case 3:
            context.read<TaskNotifier>().fetchTasks(
                  queryType: "problem",
                  queryStatus: "completed",
                );
            break;
          default:
            context.read<TaskNotifier>().fetchTasks(
                  queryType: "problem",
                );
            break;
        }
      }
    } else {
      if (tabIndex == 0) {
        switch (index) {
          case 0:
            context.read<TaskNotifier>().fetchTasks(
                  queryType: "connection",
                );
            break;
          case 1:
            context.read<TaskNotifier>().fetchTasks(
                  queryType: "connection",
                  queryStatus: "waiting",
                );
            break;
          case 2:
            context.read<TaskNotifier>().fetchTasks(
                  queryType: "connection",
                  queryStatus: "inprogress",
                );
            break;
          case 3:
            context.read<TaskNotifier>().fetchTasks(
                  queryType: "connection",
                  queryStatus: "completed",
                );
            break;
          default:
            context.read<TaskNotifier>().fetchTasks(
                  queryType: "connection",
                );
            break;
        }
      } else if (tabIndex == 1) {
        switch (index) {
          case 0:
            context.read<TaskNotifier>().fetchTasks(
                  queryType: "problem",
                );
            break;
          case 1:
            context.read<TaskNotifier>().fetchTasks(
                  queryType: "problem",
                  queryStatus: "waiting",
                );
            break;
          case 2:
            context.read<TaskNotifier>().fetchTasks(
                  queryType: "problem",
                  queryStatus: "inprogress",
                );
            break;
          case 3:
            context.read<TaskNotifier>().fetchTasks(
                  queryType: "problem",
                  queryStatus: "completed",
                );
            break;
          default:
            context.read<TaskNotifier>().fetchTasks(
                  queryType: "problem",
                );
            break;
        }
      }
    }
  }

  String _getStatusText(String status) {
    switch (status) {
      case 'waiting':
        return 'Gözləmədə olan';
      case 'inprogress':
        return 'Qəbul edilən';
      case 'completed':
        return 'Tamamlanmış';
      default:
        return 'Gözləmədə olan';
    }
  }

  String _getButtonText(String status) {
    switch (status) {
      case 'waiting':
        return 'Başla';
      case 'inprogress':
        return 'Tamamla';
      case 'completed':
        return 'Tamamlandı';
      default:
        return 'Başla';
    }
  }
}
