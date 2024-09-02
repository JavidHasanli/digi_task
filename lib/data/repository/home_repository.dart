import 'package:digi_task/data/model/failure/user_task_failure.dart';
import 'package:digi_task/data/model/response/user_task_model.dart';
import 'package:digi_task/data/services/network/home_service.dart';
import 'package:multiple_result/multiple_result.dart';

abstract interface class IHomeRepository {
  Future<Result<UserTaskModel, UserTaskFailure>> fetchUserTaskData();
}

final class HomeRepository implements IHomeRepository {
  HomeRepository({required this.homeDataSource});
  final HomeService homeDataSource;

  @override
  Future<Result<UserTaskModel, UserTaskFailure>> fetchUserTaskData() async {
    try {
      final result = await homeDataSource.fetcUserTaskData();
      return Result.success(result!);
    } catch (e) {
      return Result.error(UserTaskFailure());
    }
  }
}
