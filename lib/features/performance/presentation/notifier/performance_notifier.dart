import 'package:digi_task/features/performance/domain/repository/performance_repository.dart';
import 'package:digi_task/features/performance/presentation/notifier/performance_state.dart';
import 'package:flutter/material.dart';

class PerformanceNotifier extends ChangeNotifier {
  PerformanceNotifier(this.performanceRepository, this.startDate, this.endDate);

  final PerformanceRepository performanceRepository;
  final DateTime startDate;
  final DateTime endDate;

  PerformanceState state = PerformanceInitial();

  Future<void> fetchPerformance(DateTime startDate, DateTime endDate) async {
    state = PerformanceLoading();
    notifyListeners();
    final result = await performanceRepository.getPerformance(startDate, endDate);
    if (result.isSuccess()) {
      final performanceModel = result.tryGetSuccess();
      state = PerformanceSuccess(performanceList: performanceModel);
      notifyListeners();
    } else if (result.isError()) {
      state = PerformanceError();
      notifyListeners();
    } else {
      state = PerformanceError();
      notifyListeners();
    }
  }
}

