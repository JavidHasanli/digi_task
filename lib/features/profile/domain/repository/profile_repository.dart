import 'package:multiple_result/multiple_result.dart';

import '../../data/model/profile_model.dart';

abstract class ProfileRepository {
  Future<Result<UserProfileModel, Exception>> getUserInformation();

}
