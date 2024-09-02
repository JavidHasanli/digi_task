import 'package:digi_task/features/performance/data/model/performance_model.dart';
import 'package:digi_task/features/performance/data/service/performance_network_service.dart';
import 'package:digi_task/features/performance/domain/repository/performance_repository.dart';
import 'package:multiple_result/multiple_result.dart';

class PerformanceRepositoryImpl implements PerformanceRepository {
  PerformanceRepositoryImpl({required this.performanceService});
  final PerformanceNetworkService performanceService;

  @override
  Future<Result<List<PerformanceModel>?, Exception>> getPerformance(DateTime startDate, DateTime endDate) async {
    try {
      final result = await performanceService.getPerformance(startDate, endDate);
      return Result.success(result!);
    } catch (e) {
      return Result.error(Exception(e));
    }
  }
}
