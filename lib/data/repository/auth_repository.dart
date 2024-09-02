import 'package:digi_task/core/constants/app_keys.dart';
import 'package:digi_task/data/model/failure/auth_login_failure.dart';
import 'package:digi_task/data/model/response/user_login_response_model.dart';
import 'package:digi_task/data/services/local/secure_service.dart';
import 'package:digi_task/data/services/local/shared_service.dart';
import 'package:digi_task/data/services/network/auth_service.dart';
import 'package:dio/dio.dart';
import 'package:multiple_result/multiple_result.dart';

abstract interface class IAuthRepository {
  Future<Result<UserLoginResponseModel, AuthLoginFailure>> login({required String email, required String password});
  Future<bool> get isAuthenticated;
  Future<void> logOut();
}

class AuthRepository implements IAuthRepository {
  const AuthRepository({required this.secureStorage, required this.authDataSource, required this.preferenceService});
  final AuthService authDataSource;
  final SecureService secureStorage;
  final SharedPreferenceService preferenceService;

  @override
  Future<Result<UserLoginResponseModel, AuthLoginFailure>> login(
      {required String email, required String password}) async {
    try {
      final result = await authDataSource.login(email: email, password: password);
      await secureStorage.saveAccessToken(result?.accessToken ?? '');
      await secureStorage.saveRefresToken(result?.refreshToken ?? '');
      await preferenceService.saveBool(AppKeys.isAdmin, result?.isAdmin ?? false);
      print(result?.refreshToken);
      print(result?.accessToken);
      print(result?.userType);
      print(result?.isAdmin);

      return Result.success(result!);
    } on DioException catch (_) {
      return Result.error(AuthLoginFailure(detail: 'Invalid credentials. Please try again.'));
    } catch (e) {
      return Result.error(AuthLoginFailure(detail: e.toString()));
    }
  }

  @override
  Future<bool> get isAuthenticated async {
    try {
      final token = await secureStorage.accessToken;
      return token != null;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<void> logOut() async {
    try {
      await secureStorage.clearToken();
      await preferenceService.clear();
    } catch (e) {
      rethrow;
    }
  }
}
