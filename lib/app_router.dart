import 'package:digi_task/core/constants/routes.dart';
import 'package:digi_task/features/anbar/presentation/notifier/anbar_notifier.dart';
import 'package:digi_task/features/anbar/presentation/view/anbar_main.dart';
import 'package:digi_task/features/events/events_page.dart';
import 'package:digi_task/features/isciler/isciler_view.dart';
import 'package:digi_task/features/performance/domain/repository/performance_repository.dart';
import 'package:digi_task/features/performance/presentation/notifier/performance_notifier.dart';
import 'package:digi_task/features/profile/presentation/notifier/profile_notifier.dart';
import 'package:digi_task/features/profile/presentation/view/profile_edit_view.dart';
import 'package:digi_task/features/tasks/presentation/notifier/task_notifier.dart';
import 'package:digi_task/features/tasks/presentation/view/create_task_view.dart';
import 'package:digi_task/location/location_service.dart';
import 'package:digi_task/presentation/pages/chat/chat_details_page.dart';
import 'package:digi_task/presentation/pages/chat/chat_page.dart';
import 'package:digi_task/presentation/pages/login/login_page.dart';
import 'package:digi_task/presentation/pages/notification/notification_page.dart';
import 'package:digi_task/presentation/pages/splash/splash_page.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'features/profile/presentation/view/profile_tab.dart';
import 'notifier/auth/auth_notifier.dart';
import 'notifier/auth/login/login_notifier.dart';
import 'notifier/home/main/main_notifier.dart';
import 'presentation/pages/home/home_page.dart';
import 'presentation/pages/onboarding/onboarding_page.dart';

final _appRouterKey = GlobalKey<NavigatorState>();

final class AppRouter {
  GoRouter get instance => _appRouter;

  late final GoRouter _appRouter;
  AppRouter({
    required AuthNotifier authNotifier,
    required DateTime startDate,
    required DateTime endDate,
  }) {
    _appRouter = GoRouter(
      initialLocation: AppRoutes.splash.path,
      navigatorKey: _appRouterKey,
      refreshListenable: authNotifier,
      redirect: (context, state) {
        final authState = authNotifier.authState;

        if (authState == AuthState.unauthenticated) {
          if (state.matchedLocation == AppRoutes.login.path) {
            return null;
          }
          return AppRoutes.onboarding.path;
        } else if (authState == AuthState.authenticated) {
          final isOnLoginPage = state.matchedLocation == AppRoutes.login.path;
          final isOnSplashPage = state.matchedLocation == AppRoutes.splash.path;

          if (isOnLoginPage || isOnSplashPage) {
            return AppRoutes.home.path;
          }
        }
        return state.matchedLocation;
      },
      routes: [
        GoRoute(
          path: AppRoutes.splash.path,
          name: AppRoutes.splash.name,
          builder: (context, state) => const SplashPage(),
        ),
        GoRoute(
          path: AppRoutes.onboarding.path,
          name: AppRoutes.onboarding.name,
          builder: (context, state) => const OnboardingPage(),
        ),
        GoRoute(
          path: AppRoutes.login.path,
          name: AppRoutes.login.name,
          builder: (context, state) => ChangeNotifierProvider(
            create: (context) => GetIt.instance<LoginNotifier>(),
            child: const LoginPage(),
          ),
        ),
        GoRoute(
          path: AppRoutes.home.path,
          name: AppRoutes.home.name,
          builder: (context, state) => MultiProvider(
            providers: [
              ChangeNotifierProvider(
                create: (context) => GetIt.instance<MainNotifier>()
                  ..fetchUserTask()
                  ..checkAdmin(),
              ),
              ChangeNotifierProvider(
                create: (context) => PerformanceNotifier(
                  GetIt.instance<PerformanceRepository>(),
                  startDate,
                  endDate,
                )..fetchPerformance(startDate, endDate),
              ),
              ChangeNotifierProvider(
                create: (context) => GetIt.instance<TaskNotifier>()
                  ..fetchTasks(queryType: 'connection'),
              ),
              ChangeNotifierProvider(
                create: (context) =>
                    GetIt.instance<ProfileNotifier>()..getUserInformation(),
              ),
              ChangeNotifierProvider(
                create: (context) => LocationService()..startGettingLocation(),
              ),
            ],
            child: const HomePage(),
          ),
          routes: [
            GoRoute(
              path: AppRoutes.notification.path,
              name: AppRoutes.notification.name,
              builder: (context, state) => const NotificationPage(),
            ),
            GoRoute(
              path: AppRoutes.chat.path,
              name: AppRoutes.chat.name,
              builder: (context, state) => const ChatPage(),
            ),
            GoRoute(
              path: AppRoutes.chatDetails.path,
              name: AppRoutes.chatDetails.name,
              builder: (context, state) => const ChatDetailsPage(),
            ),
            GoRoute(
              path: AppRoutes.createTask.path,
              name: AppRoutes.createTask.name,
              builder: (context, state) => MultiProvider(
                providers: [
                  ChangeNotifierProvider(
                    create: (context) => GetIt.instance<TaskNotifier>(),
                  ),
                  ChangeNotifierProvider(
                    create: (context) => GetIt.instance<MainNotifier>(),
                  ),
                ],
                child: const CreateTaskView(),
              ),
            ),
            GoRoute(
              path: AppRoutes.profile.path,
              name: AppRoutes.profile.name,
              builder: (context, state) => ChangeNotifierProvider(
                create: (context) =>
                    GetIt.instance<ProfileNotifier>()..getUserInformation(),
                child: const ProfileTab(),
              ),
            ),
            GoRoute(
              path: AppRoutes.profileEdit.path,
              name: AppRoutes.profileEdit.name,
              builder: (context, state) => ChangeNotifierProvider(
                create: (context) => GetIt.instance<ProfileNotifier>(),
                child: const ProfileEditView(),
              ),
            ),
            GoRoute(
              path: AppRoutes.anbar.path,
              name: AppRoutes.anbar.name,
              builder: (context, state) => ChangeNotifierProvider(
                create: (context) =>
                    GetIt.instance<AnbarNotifier>()..getAnbarItemList(),
                child: const AnbarMain(),
              ),
            ),
            GoRoute(
              path: AppRoutes.isciler.path,
              name: AppRoutes.isciler.name,
              builder: (context, state) => const IscilerView(),
            ),
            GoRoute(
              path: AppRoutes.events.path,
              name: AppRoutes.events.name,
              builder: (context, state) => const EventsPage(),
            ),
          ],
        ),
      ],
    );
  }
}
