import 'package:digi_task/core/constants/path/icon_path.dart';
import 'package:digi_task/core/constants/theme/theme_ext.dart';
import 'package:digi_task/core/utility/extension/icon_path_ext.dart';
import 'package:digi_task/features/profile/presentation/view/other_tab.dart';
import 'package:digi_task/features/tasks/presentation/view/problem/tasktab/tasks_tab.dart';
import 'package:digi_task/notifier/home/main/main_notifier.dart';
import 'package:digi_task/presentation/pages/home/widgets/bottom_navbar.dart';
import 'package:digi_task/presentation/pages/notification/services/websocket.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/routes.dart';
import '../../../features/performance/presentation/view/performance_tab.dart';
import '../../../features/profile/presentation/view/profile_tab.dart';
import 'view/home_tab.dart';
import 'widgets/notification_icon.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late final TabController tabController;
  late final WebSocketService _webSocketService;
  int notificationCount = 0;

  @override
  void initState() {
    super.initState();

    tabController = TabController(length: 4, vsync: this);
    tabController.addListener(() {
      setState(() {});
    });

    _webSocketService = WebSocketService();
    _webSocketService.connectWebSocket(
      onMessageReceived: (messages) {
        setState(() {
          notificationCount = messages.length;
        });
      },
    );
  }

  @override
  void dispose() {
    _webSocketService.dispose();
    tabController.dispose();
    super.dispose();
  }

  String currentSectionText() {
    switch (tabController.index) {
      case 0:
        return "Xoş gəlmisən, ${context.watch<MainNotifier>().userTaskModel?.firstName} !";
      case 1:
        return "Performans";
      case 2:
        return "Tapşırıq";
      case 3:
        return context.watch<MainNotifier>().isAdmin ? "Digər" : "Profil";
      default:
        return "Error";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colors.backgroundColor,
      floatingActionButton: context.watch<MainNotifier>().isAdmin
          ? Theme(
              data: ThemeData(useMaterial3: false),
              child: FloatingActionButton(
                backgroundColor: context.colors.primaryColor50,
                child: SvgPicture.asset(IconPath.add.toPathSvg),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return Dialog(
                        insetPadding:
                            const EdgeInsets.symmetric(horizontal: 16),
                        child: Material(
                          borderRadius: BorderRadius.circular(16),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 16.0, right: 16),
                                  child: Row(
                                    children: [
                                      const Icon(Icons.close,
                                          color: Colors.white),
                                      const Spacer(),
                                      Center(
                                        child: Text(
                                          "Tapşırıq növü seç",
                                          style: context
                                              .typography.subtitle1Medium,
                                        ),
                                      ),
                                      const Spacer(),
                                      InkWell(
                                          onTap: () {
                                            context.pop();
                                          },
                                          child: const Icon(Icons.close))
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 20),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 24.0, right: 24, bottom: 24),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: ElevatedButton(
                                          style: ButtonStyle(
                                            padding: WidgetStateProperty.all(
                                                const EdgeInsets.symmetric(
                                                    vertical: 14)),
                                            shape: WidgetStateProperty.all(
                                              RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                            ),
                                            backgroundColor:
                                                WidgetStateProperty.all(context
                                                    .colors.primaryColor50),
                                            side: WidgetStateProperty.all(
                                              BorderSide(
                                                  color: context
                                                      .colors.primaryColor50),
                                            ),
                                          ),
                                          onPressed: () {
                                            context.goNamed(
                                                AppRoutes.createTask.name,
                                                extra: 'connection');
                                          },
                                          child: Text(
                                            'Yeni qoşulma',
                                            style: context
                                                .typography.body1SemiBold
                                                .copyWith(
                                                    color: context.colors
                                                        .neutralColor100),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 12),
                                      Expanded(
                                        child: ElevatedButton(
                                          style: ButtonStyle(
                                            padding: WidgetStateProperty.all(
                                                const EdgeInsets.symmetric(
                                                    vertical: 14)),
                                            shape: WidgetStateProperty.all(
                                              RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                            ),
                                            backgroundColor:
                                                WidgetStateProperty.all(
                                                    Colors.white),
                                            side: WidgetStateProperty.all(
                                              BorderSide(
                                                  color: context
                                                      .colors.primaryColor50,
                                                  width: 2),
                                            ),
                                          ),
                                          onPressed: () {
                                            context.goNamed(
                                                AppRoutes.createTask.name,
                                                extra: 'problem');
                                          },
                                          child: Text(
                                            'Problem',
                                            style: context
                                                .typography.body1SemiBold
                                                .copyWith(
                                                    color: context
                                                        .colors.primaryColor50),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            )
          : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomNavBar(tabController: tabController),
      appBar: AppBar(
        backgroundColor: context.colors.neutralColor100,
        title: Text(
          currentSectionText(),
          style: context.typography.subtitle2Medium,
        ),
        actions: [
          AppBarIcon(
            iconPath: IconPath.message.toPathSvg,
            onTap: () => context.goNamed(AppRoutes.chat.name),
          ),
          const SizedBox(width: 14),
          Stack(
            children: [
              AppBarIcon(
                iconPath: IconPath.notification.toPathSvg,
                onTap: () => context.goNamed(AppRoutes.notification.name),
              ),
              if (notificationCount > 0)
                Positioned(
                  right: 0,
                  top: 0,
                  child: Container(
                    padding: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    constraints: const BoxConstraints(
                      minWidth: 16,
                      minHeight: 16,
                    ),
                    child: Center(
                      child: Text(
                        '$notificationCount',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(width: 16),
        ],
      ),
      body: Consumer<MainNotifier>(
        builder: (context, notifier, child) {
          return TabBarView(
            physics: const NeverScrollableScrollPhysics(),
            controller: tabController,
            children: [
              HomeTabView(
                state: notifier.homeState,
                tabController: tabController,
              ),
              const PerformanceTab(),
              const TasksTab(),
              context.watch<MainNotifier>().isAdmin
                  ? const OtherTab()
                  : const ProfileTab(),
            ],
          );
        },
      ),
    );
  }
}
