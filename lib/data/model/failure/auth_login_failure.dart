class AuthLoginFailure {
  String? detail;

  AuthLoginFailure({this.detail});

  AuthLoginFailure.fromJson(Map<String, dynamic> json) {
    detail = json['detail'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['detail'] = detail;
    return data;
  }
}
