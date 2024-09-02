import 'package:digi_task/data/services/local/secure_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class MessageService {
  final Dio _dio;
  final SecureService secureService = SecureService(
    secureStorage: const FlutterSecureStorage(),
  );

  MessageService({
    required Dio dio,
  }) : _dio = dio;

  Future<List<dynamic>> fetchMessages(int? groupId) async {
    try {
      final token = await secureService.accessToken;
      if (token == null) {
        throw Exception('Token is not available');
      }
      _dio.options.headers['Authorization'] = 'Bearer $token';
      final response = await _dio
          .get('http://135.181.42.192/accounts/messages/?page_size=40');

      final allMessages = (response.data['results'] as List)
          .where((message) => message['room'] == groupId)
          .toList()
        ..sort((a, b) => DateTime.parse(a['timestamp'])
            .compareTo(DateTime.parse(b['timestamp'])));

      return allMessages;
    } catch (e) {
      if (e is DioException) {
        if (e.response != null) {
          throw Exception('Error submitting export: ${e.response?.data}');
        } else {
          throw Exception('Error submitting export: ${e.message}');
        }
      } else {
        throw Exception('Error: $e');
      }
    }
  }
}
