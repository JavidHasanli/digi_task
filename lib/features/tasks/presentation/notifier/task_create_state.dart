abstract class TaskCreateState {}

class TaskCreateInitial extends TaskCreateState {}

class TaskCreateProgress extends TaskCreateState {}

class TaskCreateSuccess extends TaskCreateState {}

class TaskCreateFailure extends TaskCreateState {}
