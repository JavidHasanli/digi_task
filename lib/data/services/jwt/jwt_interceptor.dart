import 'package:digi_task/data/services/jwt/dio_configuration.dart';
import 'package:digi_task/injection.dart';
import 'package:dio/dio.dart';

import '../local/secure_service.dart';

// import 'package:jwt_decoder/jwt_decoder.dart';

class JwtInterceptor extends Interceptor {
  final _secureStorage = getIt.get<SecureService>();

  @override
  Future<void> onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    final token = await _secureStorage.accessToken;
    print(token);
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';

      // final decodedToken = JwtDecoder.decode(token);
      // final warehouseRegion = decodedToken['warehouse']?['region'];
      // final createdBy = decodedToken['created_by'];
      // final date = decodedToken['date'];

      // print('Warehouse Region: $warehouseRegion');
      // print('Created By: $createdBy');
      // print('Date: $date');
    }
    return handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 403) {
      final newAccessToken = await refreshToken();
      if (newAccessToken != null) {
        baseDio.options.headers['Authorization'] = 'Bearer $newAccessToken';
        return handler.resolve(await baseDio.fetch(err.requestOptions));
      }
    }
    return handler.next(err);
  }

  Future<String?> refreshToken() async {
    try {
      final refreshToken = await _secureStorage.refreshToken;
      final response = await baseDio
          .post('accounts/token/refresh/', data: {'refresh': refreshToken});
      final newAccessToken = response.data['access'];
      await _secureStorage.saveAccessToken(newAccessToken);
      return newAccessToken;
    } catch (e) {
      _secureStorage.clearToken();
    }
    return null;
  }
}
