import 'package:multiple_result/multiple_result.dart';
import '../../data/model/performance_model.dart';

abstract interface class PerformanceRepository {
  Future<Result<List<PerformanceModel>?, Exception>> getPerformance(DateTime startDate, DateTime endDate);
}
