import 'package:digi_task/features/profile/data/model/profile_model.dart';
import 'package:equatable/equatable.dart';

abstract class ProfileState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ProfileInitial extends ProfileState {}

class ProfileProgress extends ProfileState {}

class ProfileSuccess extends ProfileState {
  final UserProfileModel userModel;

  ProfileSuccess({required this.userModel});
}

class ProfileFailure extends ProfileState {}
