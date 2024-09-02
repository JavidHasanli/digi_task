import 'package:digi_task/features/tasks/data/model/task_model.dart';
import 'package:multiple_result/multiple_result.dart';

import '../../../../data/model/failure/empty_task_model.dart';
import '../../data/model/create_task_model.dart';

abstract interface class ITaskRepository {
  Future<Result<List<TaskModel>?, EmptyTaskModel>> getTasks({String? queryStatus, String? queryType});

  Future<Result<CreateTaskModel, Exception>> createTask({required CreateTaskModel model});
}
