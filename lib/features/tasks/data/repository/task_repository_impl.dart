import 'package:digi_task/data/model/failure/empty_task_model.dart';
import 'package:digi_task/features/tasks/data/model/create_task_model.dart';
import 'package:digi_task/features/tasks/data/model/task_model.dart';
import 'package:digi_task/features/tasks/data/service/task_network_service.dart';
import 'package:multiple_result/multiple_result.dart';

import '../../domain/repository/task_repository.dart';

final class TaskRepositoryImpl implements ITaskRepository {
  TaskRepositoryImpl({required this.taskService});
  final TaskNetworkServiceImpl taskService;
  @override
  Future<Result<List<TaskModel>?, EmptyTaskModel>> getTasks({String? queryStatus, String? queryType}) async {
    try {
      final result = await taskService.getTasks(queryStatus: queryStatus, queryType: queryType);
      return Result.success(result);
    } catch (e) {
      return Result.error(EmptyTaskModel(message: e.toString()));
    }
  }

  @override
  Future<Result<CreateTaskModel, Exception>> createTask({required CreateTaskModel model}) async {
    try {
      final result = await taskService.createTask(model: model);
      return Result.success(result);
    } catch (e) {
      return Result.error(Exception(e.toString()));
    }
  }
}
