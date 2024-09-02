import 'package:digi_task/core/constants/app_keys.dart';
import 'package:digi_task/data/services/jwt/jwt_interceptor.dart';
import 'package:dio/dio.dart';

final baseDio = Dio()
  ..options = BaseOptions(
    baseUrl: AppKeys.baseUrl,
    contentType: 'application/json',
    connectTimeout: const Duration(seconds: 5),
    receiveTimeout: const Duration(seconds: 3),
  )
  ..interceptors.add(JwtInterceptor());
