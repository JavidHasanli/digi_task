import 'package:equatable/equatable.dart';

import '../../data/model/performance_model.dart';

abstract class PerformanceState extends Equatable {
  @override
  List<Object?> get props => [];
}

class PerformanceInitial extends PerformanceState {}

class PerformanceLoading extends PerformanceState {}

class PerformanceSuccess extends PerformanceState {
  final List<PerformanceModel>? performanceList;

  PerformanceSuccess({required this.performanceList});

  @override
  List<Object?> get props => [performanceList];
}

class PerformanceError extends PerformanceState {}
