import 'package:flutter/material.dart';

import '../../data/repository/auth_repository.dart';

enum AuthState { initial, progress, authenticated, unauthenticated, onboarding }

class AuthNotifier extends ChangeNotifier {
  AuthNotifier(this.authRepository);
  final IAuthRepository authRepository;

  AuthState _authState = AuthState.initial;
  AuthState get authState => _authState;

  void checkAuth() async {
    try {
      await Future.delayed(const Duration(seconds: 3));
      final isAuthenticated = await authRepository.isAuthenticated;

      if (isAuthenticated) {
        _authState = AuthState.authenticated;
        notifyListeners();
      } else {
        _authState = AuthState.unauthenticated;
        notifyListeners();
      }
    } catch (_) {
      _authState = AuthState.unauthenticated;
      notifyListeners();
    }
  }

  void userLogged() {
    _authState = AuthState.authenticated;
    notifyListeners();
  }

  void logOut() async {
    try {
      await authRepository.logOut();
      _authState = AuthState.progress;
      notifyListeners();
      await Future.delayed(const Duration(seconds: 2));
      _authState = AuthState.unauthenticated;
      notifyListeners();
    } catch (_) {}
  }
}
