class UserLoginResponseModel {
  String? email;
  String? accessToken;
  String? refreshToken;
  String? userType;
  bool? isAdmin;

  UserLoginResponseModel({this.email, this.accessToken, this.refreshToken, this.userType, this.isAdmin});

  UserLoginResponseModel.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    accessToken = json['access_token'];
    refreshToken = json['refresh_token'];
    userType = json['user_type'];
    isAdmin = json['is_admin'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['email'] = email;
    data['access_token'] = accessToken;
    data['refresh_token'] = refreshToken;
    data['user_type'] = userType;
    data['is_admin'] = isAdmin;
    return data;
  }
}
