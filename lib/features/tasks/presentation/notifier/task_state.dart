import 'package:equatable/equatable.dart';

import '../../data/model/task_model.dart';

abstract class TaskState extends Equatable {
  @override
  List<Object?> get props => [];
}

final class TaskInitial extends TaskState {}

final class TaskSuccess extends TaskState {
  final List<TaskModel>? tasks;
  TaskSuccess({this.tasks});
}

final class TaskFailure extends TaskState {}

final class TaskProgress extends TaskState {}

