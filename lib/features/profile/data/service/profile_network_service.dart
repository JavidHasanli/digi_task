import 'package:digi_task/data/services/jwt/dio_configuration.dart';
import 'package:digi_task/features/profile/data/model/profile_model.dart';

abstract interface class IProfileNetworkService {
  Future<UserProfileModel> getUserInformation();
}

final class ProfileNetworkService implements IProfileNetworkService {
  @override
  Future<UserProfileModel> getUserInformation() async {
    try {
      final response = await baseDio.get('/accounts/profile/');
      print(response.data);

      final userProfile = UserProfileModel.fromJson(response.data);
      return userProfile;
    } catch (e, s) {
      return Error.throwWithStackTrace(e, s);
    }
  }
}
