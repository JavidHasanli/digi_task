import 'package:digi_task/features/profile/data/service/profile_network_service.dart';
import 'package:multiple_result/multiple_result.dart';

import '../../domain/repository/profile_repository.dart';
import '../model/profile_model.dart';

final class ProfileRepositoryImpl implements ProfileRepository {
  ProfileRepositoryImpl({required this.profileService});
  final ProfileNetworkService profileService;
  @override
  Future<Result<UserProfileModel, Exception>> getUserInformation() async {
    try {
      final response = await profileService.getUserInformation();
      return Success(response);
    } catch (e) {
      return Error(Exception(e));
    }
  }
}
