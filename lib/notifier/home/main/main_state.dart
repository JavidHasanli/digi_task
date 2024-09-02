import 'package:digi_task/data/model/response/user_task_model.dart';
import 'package:equatable/equatable.dart';

abstract class MainState extends Equatable {
  @override
  List<Object?> get props => [];
}

class MainInitial extends MainState {}

class MainLoading extends MainState {}

class MainSuccess extends MainState {
  final TaskDetails? taskDetails;

  MainSuccess({required this.taskDetails});
}

class MainError extends MainState {}
