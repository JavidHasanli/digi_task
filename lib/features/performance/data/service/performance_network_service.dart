import 'package:digi_task/features/performance/data/model/performance_model.dart';
import '../../../../data/services/jwt/dio_configuration.dart';

abstract class IPerformanceNetworkService {
  Future<List<PerformanceModel>?> getPerformance(DateTime startDate, DateTime endDate);
}

class PerformanceNetworkService implements IPerformanceNetworkService {
  @override
  Future<List<PerformanceModel>?> getPerformance(DateTime startDate, DateTime endDate) async {
    try {
      final startDateStr = startDate.toIso8601String().split('T')[0];
      final endDateStr = endDate.toIso8601String().split('T')[0];
      final response = await baseDio.get(
        'services/performance/?start_date=$startDateStr&end_date=$endDateStr',
      );
      if (response.statusCode! >= 200 && response.statusCode! <= 299) {
        final performanceList = response.data;
        if (performanceList is List) {
          return performanceList
              .map((e) => PerformanceModel.fromJson(e))
              .toList();
        } else {
          print('Error: Unexpected response format');
        }
      } else {
        print('Error: ${response.statusCode} - ${response.statusMessage}');
      }
    } catch (e) {
      print('Exception: $e');
    }
    return null;
  }
}
