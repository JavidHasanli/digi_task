import 'package:digi_task/data/repository/home_repository.dart';
import 'package:digi_task/data/services/local/secure_service.dart';
import 'package:digi_task/data/services/local/shared_service.dart';
import 'package:digi_task/data/services/network/auth_service.dart';
import 'package:digi_task/data/services/network/home_service.dart';
import 'package:digi_task/features/anbar/data/service/anbar_network_service.dart';
import 'package:digi_task/features/anbar/domain/repository/anbar_item_repository.dart';
import 'package:digi_task/features/anbar/presentation/notifier/anbar_notifier.dart';
import 'package:digi_task/features/performance/data/service/performance_network_service.dart';
import 'package:digi_task/features/performance/domain/repository/performance_repository.dart';
import 'package:digi_task/features/performance/presentation/notifier/performance_notifier.dart';
import 'package:digi_task/features/profile/data/repository/profile_repository_impl.dart';
import 'package:digi_task/features/profile/data/service/profile_network_service.dart';
import 'package:digi_task/features/profile/domain/repository/profile_repository.dart';
import 'package:digi_task/features/profile/presentation/notifier/profile_notifier.dart';
import 'package:digi_task/features/tasks/presentation/notifier/task_notifier.dart';
import 'package:digi_task/notifier/home/main/main_notifier.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';

import 'app_router.dart';
import 'data/repository/auth_repository.dart';
import 'features/anbar/data/repository/anbar_item_repository_impl.dart';
import 'features/performance/data/repository/performance_repository_impl.dart';
import 'features/tasks/data/repository/task_repository_impl.dart';
import 'features/tasks/data/service/task_network_service.dart';
import 'features/tasks/domain/repository/task_repository.dart';
import 'notifier/auth/auth_notifier.dart';
import 'notifier/auth/login/login_notifier.dart';

final getIt = GetIt.instance;

Future<void> init() async {
  getIt.registerFactory(() => SharedPreferenceService());
  getIt.registerFactory(
      () => SecureService(secureStorage: const FlutterSecureStorage()));

  getIt.registerLazySingleton(() => AuthService());
  getIt.registerLazySingleton(() => AnbarNetworkServiceImpl());
  getIt.registerLazySingleton(() => ProfileNetworkService());
  getIt.registerLazySingleton(() => PerformanceNetworkService());
  getIt.registerLazySingleton(() => TaskNetworkServiceImpl());
  getIt.registerLazySingleton(() => HomeService());

  getIt.registerSingleton<IAuthRepository>(
    AuthRepository(
      authDataSource: getIt(),
      secureStorage: getIt(),
      preferenceService: getIt(),
    ),
  );

  getIt.registerSingleton<IHomeRepository>(
    HomeRepository(homeDataSource: getIt()),
  );

  getIt.registerSingleton<ProfileRepository>(
    ProfileRepositoryImpl(profileService: getIt()),
  );
  getIt.registerSingleton<PerformanceRepository>(
    PerformanceRepositoryImpl(performanceService: getIt()),
  );

  getIt.registerSingleton<ITaskRepository>(
    TaskRepositoryImpl(taskService: getIt()),
  );
  getIt.registerSingleton<AnbarItemRepository>(
    AnbarItemRepositoryImpl(anbarNetworkService: getIt()),
  );

  DateTime defaultStartDate = DateTime.now().subtract(const Duration(days: 30));
  DateTime defaultEndDate = DateTime.now();

  getIt.registerFactory(() => LoginNotifier(getIt()));
  getIt.registerFactory(() => PerformanceNotifier(
        getIt(),
        defaultStartDate,
        defaultEndDate,
      ));
  getIt.registerFactory(() => TaskNotifier(getIt()));
  getIt.registerFactory(() => ProfileNotifier(getIt()));
  getIt.registerFactory(() => AnbarNotifier(getIt()));
  getIt.registerFactory(() => MainNotifier(getIt()));

  getIt.registerSingleton(AuthNotifier(getIt())..checkAuth());

  getIt.registerSingleton(AppRouter(
    authNotifier: getIt(),
    startDate: defaultStartDate,
    endDate: defaultEndDate,
  ));
}
