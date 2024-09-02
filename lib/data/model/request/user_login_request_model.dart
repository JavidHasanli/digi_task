import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_login_request_model.g.dart';

@JsonSerializable()
class UserLoginRequestModel extends Equatable {
  final String? email;
  final String? password;

  const UserLoginRequestModel({this.email, this.password});

  factory UserLoginRequestModel.fromJson(Map<String, dynamic> json) {
    return _$UserLoginRequestModelFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$UserLoginRequestModelToJson(this);
  }

  @override
  List<Object?> get props => [email, password];
}
