import 'package:digi_task/core/constants/path/icon_path.dart';
import 'package:digi_task/core/constants/routes.dart';
import 'package:digi_task/core/constants/theme/theme_ext.dart';
import 'package:digi_task/core/utility/extension/icon_path_ext.dart';
import 'package:digi_task/notifier/home/main/main_notifier.dart';
import 'package:digi_task/notifier/home/main/main_state.dart';
import 'package:digi_task/presentation/pages/home/widgets/tasks_card.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../../features/performance/presentation/notifier/performance_notifier.dart';
import '../../../../features/performance/presentation/notifier/performance_state.dart';
import '../../../../shared/widgets/performance_table.dart';
import '../../../../shared/widgets/user_task_card.dart';
import '../../../components/custom_progress_indicator.dart';
import '../../../components/service_type.dart';
import '../widgets/component_title.dart';
import '../widgets/organizations_card.dart';

class HomeTabView extends StatelessWidget {
  const HomeTabView(
      {super.key, required this.state, required this.tabController});
  final TabController tabController;

  final MainState state;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16),
      child: switch (state) {
        MainLoading() => const Center(child: CustomProgressIndicator()),
        MainError() => const Center(
            child: Text("Error"),
          ),
        MainSuccess() => Builder(builder: (_) {
            final successState = state as MainSuccess;
            return RefreshIndicator(
              onRefresh: () async {
                await context.read<MainNotifier>().fetchUserTask();
              },
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 24,
                    ),
                    Text(
                      "12 May",
                      style: context.typography.subtitle2SemiBold,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    TasksCard(
                      taskDetails: successState.taskDetails,
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    ComponentTitle(
                      title: 'Davam edən tasklar',
                      onPressed: () {
                        tabController.index = 2;
                      },
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Consumer<MainNotifier>(
                      builder: (context, notifier, child) {
                        if (notifier.userTaskModel?.ongoingTasks?.isNotEmpty ??
                            false) {
                          final nowDateTime = DateTime.now();
                          final dateTime = DateTime.parse(notifier
                                  .userTaskModel?.ongoingTasks?.first.date ??
                              '');
                          String formattedDate =
                              DateFormat('MMM d').format(dateTime);
                          String nowFormattedDate =
                              DateFormat('MMM d').format(nowDateTime);
                          return UserTaskCard(
                            iconRow: Row(
                              children: [
                                if (notifier.userTaskModel?.ongoingTasks?.first
                                        .isInternet ==
                                    true) ...[
                                  ServiceType(
                                      image: IconPath.internet.toPathSvg,
                                      title: "Internet"),
                                ],
                                if (notifier.userTaskModel?.ongoingTasks?.first
                                        .isTv ==
                                    true) ...[
                                  ServiceType(
                                    image: IconPath.tv.toPathSvg,
                                    title: "Tv",
                                  ),
                                ],
                                if (notifier.userTaskModel?.ongoingTasks?.first
                                        .isVoice ==
                                    true) ...[
                                  ServiceType(
                                    image: IconPath.voice.toPathSvg,
                                    title: "Voice",
                                  ),
                                ]
                              ],
                            ),
                            location: notifier.userTaskModel?.ongoingTasks
                                    ?.first.location ??
                                '',
                            name: notifier.userTaskModel?.ongoingTasks?.first
                                    .firstName ??
                                '',
                            number: notifier.userTaskModel?.ongoingTasks?.first
                                    .contactNumber ??
                                '',
                            status: notifier.userTaskModel?.ongoingTasks?.first
                                    .status ??
                                '',
                            time: formattedDate == nowFormattedDate
                                ? "Bu gün, ${notifier.userTaskModel?.ongoingTasks?.first.time ?? ''}"
                                : "$formattedDate, ${notifier.userTaskModel?.ongoingTasks?.first.time ?? ''}",
                            notifier: notifier,
                            group: (notifier.userTaskModel?.ongoingTasks?.first
                                        .group?.isNotEmpty ??
                                    false)
                                ? '${notifier.userTaskModel?.ongoingTasks?.first.group?.first.group}'
                                : "Empty group",
                          );
                        }
                        return const SizedBox.shrink();
                      },
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    ComponentTitle(
                      title: 'Tədbirlər',
                      onPressed: () {
                        context.goNamed(AppRoutes.events.name);
                      },
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    const OrganizationsCard(),
                    const SizedBox(
                      height: 24,
                    ),
                    if (context.watch<MainNotifier>().isAdmin) ...[
                      ComponentTitle(
                        title: 'Texniklərin performansı',
                        onPressed: () {
                          tabController.index = 1;
                        },
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Consumer<PerformanceNotifier>(
                        builder: (context, notifier, child) {
                          if (notifier.state is PerformanceLoading) {
                            return const Center(
                                child: CircularProgressIndicator());
                          } else if (notifier.state is PerformanceSuccess) {
                            final performance =
                                (notifier.state as PerformanceSuccess)
                                    .performanceList;
                            return PerformanceTable(performance: performance);
                          }
                          return const SizedBox.shrink();
                        },
                      )
                    ]
                  ],
                ),
              ),
            );
          }),
        _ => const SizedBox.shrink()
      },
    );
  }
}
