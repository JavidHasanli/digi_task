import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:digi_task/data/services/local/secure_service.dart';
import 'package:digi_task/features/anbar/data/model/anbar_item_model.dart';

class ApiService {
  final Dio _dio = Dio();
  final SecureService secureService = SecureService(
    secureStorage: const FlutterSecureStorage(),
  );

  Future<void> postAnbarItem(AnbarItemModel item) async {
    try {
      final token = await secureService.accessToken;
      if (token == null) {
        throw Exception('Token is not available');
      }

      _dio.options.headers['Authorization'] = 'Bearer $token';

      final response = await _dio.post(
        'http://135.181.42.192/services/import/',
        data: item.toJson(),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        print('Item imported successfully');
      } else {
        print('Failed to import item: ${response.statusCode}');
        final responseData = response.data;

        if (responseData is Map<String, dynamic>) {
          final errorMessages = responseData['error_messages'] ?? {};
          if (errorMessages.isNotEmpty) {
            throw Exception('Validation errors: ${errorMessages.toString()}');
          }
        }
      }
    } catch (e) {
      if (e is DioException) {
        print('Dio error: ${e.message}');
        if (e.response != null) {
          print('Error response: ${e.response?.data}');
          print('Error response status: ${e.response?.statusCode}');
        }

        throw Exception(e.response?.data ?? 'An unknown error occurred');
      } else {
        print('Unknown error: $e');
        throw Exception('An unknown error occurred');
      }
    }
  }
}
