import 'package:digi_task/features/isciler/models/group_model.dart';

class User {
  final int id;
  final String email;
  final String firstName;
  final String lastName;
  final String phone;
  final String userType;
  final Group? group;
  final String username;

  User({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.phone,
    required this.userType,
    this.group,
    required this.username,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as int,
      email: json['email'] as String,
      firstName: json['first_name'] as String,
      lastName: json['last_name'] as String,
      phone: json['phone'] as String,
      userType: json['user_type'] as String,
      group: json['group'] != null ? Group.fromJson(json['group']) : null,
      username: json['username'] as String,
    );
  }
}
