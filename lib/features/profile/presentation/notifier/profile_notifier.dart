import 'package:digi_task/features/profile/presentation/notifier/profile_state.dart';
import 'package:flutter/material.dart';

import '../../domain/repository/profile_repository.dart';

class ProfileNotifier extends ChangeNotifier {
  ProfileNotifier(this.profileRepository);
  ProfileState state = ProfileInitial();
  final ProfileRepository profileRepository;
  Future<void> getUserInformation() async {
    state = ProfileProgress();
    notifyListeners();
    final result = await profileRepository.getUserInformation();
    if (result.isSuccess()) {
      final userModel = result.tryGetSuccess();

      state = ProfileSuccess(userModel: userModel!);
      notifyListeners();
    } else {
      state = ProfileFailure();
      notifyListeners();
    }
  }
}
