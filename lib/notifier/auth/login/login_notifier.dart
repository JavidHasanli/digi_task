import 'package:digi_task/data/repository/auth_repository.dart';
import 'package:flutter/material.dart';

import 'login_state.dart';

class LoginNotifier extends ChangeNotifier {
  LoginNotifier(this.authRepository);
  LoginState state = LoginInitial();
  final IAuthRepository authRepository;

  Future<void> loginUser({required String email, required String password}) async {
    state = LoginProgress();
    notifyListeners();
    final result = await authRepository.login(email: email, password: password);

    if (result.isSuccess()) {
      state = LoginSuccess();
      notifyListeners();
    } else {
      final errorMessage = result.tryGetError()!.detail ?? 'Failed to login';
      print(errorMessage);
      state = LoginFailure(message: errorMessage);
      notifyListeners();
    }
  }
}
