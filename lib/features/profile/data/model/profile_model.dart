class UserProfileModel {
  int? id;
  String? email;
  String? firstName;
  String? lastName;
  String? phone;
  String? userType;
  Group? group;

  UserProfileModel({this.id, this.email, this.firstName, this.lastName, this.phone, this.userType, this.group});

  UserProfileModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    phone = json['phone'];
    userType = json['user_type'];
    group = json['group'] != null ? Group.fromJson(json['group']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['email'] = email;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['phone'] = phone;
    data['user_type'] = userType;
    if (group != null) {
      data['group'] = group!.toJson();
    }
    return data;
  }
}

class Group {
  int? id;
  String? group;
  String? region;

  Group({this.id, this.group, this.region});

  Group.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    group = json['group'];
    region = json['region'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['group'] = group;
    data['region'] = region;
    return data;
  }
}
