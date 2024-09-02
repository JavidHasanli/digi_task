import 'package:digi_task/features/tasks/data/model/task_model.dart';
import 'package:dio/dio.dart';

class TaskService {
  final Dio _dio = Dio();

  Future<TaskModel> fetchTask(int taskId) async {
    final response = await _dio.get('http://135.181.42.192/services/task/$taskId/');
    return TaskModel.fromJson(response.data);
  }
}
