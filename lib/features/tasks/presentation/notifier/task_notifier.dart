import 'package:digi_task/features/tasks/presentation/notifier/task_create_state.dart';
import 'package:flutter/material.dart';

import '../../data/model/create_task_model.dart';
import '../../domain/repository/task_repository.dart';
import 'task_state.dart';

class TaskNotifier extends ChangeNotifier {
  TaskNotifier(this.taskRepository);
  final ITaskRepository taskRepository;

  TaskState state = TaskInitial();
  TaskCreateState createState = TaskCreateInitial();

  Future<void> fetchTasks({String? queryStatus, String? queryType}) async {
    state = TaskProgress();
    notifyListeners();
    final result = await taskRepository.getTasks(queryStatus: queryStatus, queryType: queryType);
    if (result.isSuccess()) {
      final tasks = result.tryGetSuccess();
      state = TaskSuccess(tasks: tasks);
      notifyListeners();
    } else if (result.isError()) {
      state = TaskFailure();
      notifyListeners();
    } else {
      state = TaskFailure();
      notifyListeners();
    }
  }

  Future<void> createTask(CreateTaskModel model) async {
    createState = TaskCreateProgress();
    notifyListeners();
    await Future.delayed(const Duration(seconds: 1));
    final result = await taskRepository.createTask(model: model);
    if (result.isSuccess()) {
      createState = TaskCreateSuccess();
      notifyListeners();
    } else if (result.isError()) {
      createState = TaskCreateFailure();
      notifyListeners();
    } else {
      createState = TaskCreateFailure();
      notifyListeners();
    }
  }
}
