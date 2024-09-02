import 'package:digi_task/features/tasks/data/model/create_task_model.dart';
import 'package:digi_task/features/tasks/data/model/task_model.dart';

import '../../../../data/services/jwt/dio_configuration.dart';

abstract class ITaskNetworkService {
  Future<List<TaskModel>> getTasks({String? queryStatus, String? queryType});
  Future<CreateTaskModel> createTask({required CreateTaskModel model});
}

final class TaskNetworkServiceImpl implements ITaskNetworkService {
  @override
  Future<List<TaskModel>> getTasks({
    String? queryStatus,
    String? queryType,
  }) async {
    try {
      final response = queryStatus != null
          ? await baseDio.get('services/status/', queryParameters: {'task_type': queryType, "status": queryStatus})
          : await baseDio.get('services/status/', queryParameters: {
              'task_type': queryType,
            });
      final tasks = response.data as List;
      print(tasks);

      final taskList = tasks.map((e) => TaskModel.fromJson(e)).toList();
      return taskList;
    } catch (e, s) {
      return Error.throwWithStackTrace(e, s);
    }
  }

  @override
  Future<CreateTaskModel> createTask({required CreateTaskModel model}) async {
    try {
      final taskModel = model.toJson();
      final response = await baseDio.post('services/create_task/', data: taskModel);
      print(response);

      return CreateTaskModel.fromJson(response.data);
    } catch (e, s) {
      return Error.throwWithStackTrace(e, s);
    }
  }
}
