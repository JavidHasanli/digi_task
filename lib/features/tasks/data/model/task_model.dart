class TaskModel {
  late final int id;
  List<Group>? group;
  String? fullName;
  String? firstName;
  String? lastName;
  String? createdAt;
  String? updatedAt;
  String? taskType;
  String? description;
  String? registrationNumber;
  String? contactNumber;
  String? location;
  String? note;
  String? date;
  String? startTime;
  String? endTime;
  String? time;
  String? status;
  bool? isVoice;
  bool? isInternet;
  bool? isTv;
  int? user;
  Tv? tv;
  Voice? voice;
  Internet? internet;

  TaskModel({
    required this.id,
    this.group,
    this.fullName,
    this.firstName,
    this.lastName,
    this.createdAt,
    this.updatedAt,
    this.taskType,
    this.description,
    this.registrationNumber,
    this.contactNumber,
    this.location,
    this.note,
    this.date,
    this.startTime,
    this.endTime,
    this.time,
    this.status,
    this.isVoice,
    this.isInternet,
    this.isTv,
    this.user,
    this.tv,
    this.voice,
    this.internet,
  });

  TaskModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    if (json['group'] != null) {
      group = <Group>[];
      json['group'].forEach((v) {
        group!.add(Group.fromJson(v));
      });
    }
    fullName = json['full_name'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    taskType = json['task_type'];
    description = json['description'];
    registrationNumber = json['registration_number'];
    contactNumber = json['contact_number'];
    location = json['location'];
    note = json['note'];
    date = json['date'];
    startTime = json['start_time'];
    endTime = json['end_time'];
    time = json['time'];
    status = json['status'];
    isVoice = json['is_voice'];
    isInternet = json['is_internet'];
    isTv = json['is_tv'];
    user = json['user'];
    tv = json['tv'] != null ? Tv.fromJson(json['tv']) : null;
    voice = json['voice'] != null ? Voice.fromJson(json['voice']) : null;
    internet =
        json['internet'] != null ? Internet.fromJson(json['internet']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    if (group != null) {
      data['group'] = group!.map((v) => v.toJson()).toList();
    }
    data['full_name'] = fullName;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['task_type'] = taskType;
    data['description'] = description;
    data['registration_number'] = registrationNumber;
    data['contact_number'] = contactNumber;
    data['location'] = location;
    data['note'] = note;
    data['date'] = date;
    data['start_time'] = startTime;
    data['end_time'] = endTime;
    data['time'] = time;
    data['status'] = status;
    data['is_voice'] = isVoice;
    data['is_internet'] = isInternet;
    data['is_tv'] = isTv;
    data['user'] = user;
    if (tv != null) {
      data['tv'] = tv!.toJson();
    }
    if (voice != null) {
      data['voice'] = voice!.toJson();
    }
    if (internet != null) {
      data['internet'] = internet!.toJson();
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

class Tv {
  int? id;
  String? photoModem;
  String? modemSN;
  String? rg6Cable;
  String? fConnector;
  String? splitter;
  int? task;

  Tv(
      {this.id,
      this.photoModem,
      this.modemSN,
      this.rg6Cable,
      this.fConnector,
      this.splitter,
      this.task});

  Tv.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    photoModem = json['photo_modem'];
    modemSN = json['modem_SN'];
    rg6Cable = json['rg6_cable'];
    fConnector = json['f_connector'];
    splitter = json['splitter'];
    task = json['task'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['photo_modem'] = photoModem;
    data['modem_SN'] = modemSN;
    data['rg6_cable'] = rg6Cable;
    data['f_connector'] = fConnector;
    data['splitter'] = splitter;
    data['task'] = task;
    return data;
  }
}

class Voice {
  int? id;
  String? photoModem;
  String? modemSN;
  String? homeNumber;
  String? password;
  int? task;

  Voice(
      {this.id,
      this.photoModem,
      this.modemSN,
      this.homeNumber,
      this.password,
      this.task});

  Voice.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    photoModem = json['photo_modem'];
    modemSN = json['modem_SN'];
    homeNumber = json['home_number'];
    password = json['password'];
    task = json['task'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['photo_modem'] = photoModem;
    data['modem_SN'] = modemSN;
    data['home_number'] = homeNumber;
    data['password'] = password;
    data['task'] = task;
    return data;
  }
}

class Internet {
  int? id;
  String? photoModem;
  String? modemSN;
  int? task;
  String? optical_cable;
  String? fastconnector;
  String? siqnal;

  Internet(
      {this.id,
      this.photoModem,
      this.modemSN,
      this.task,
      this.optical_cable,
      this.fastconnector,
      this.siqnal});

  Internet.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    photoModem = json['photo_modem'];
    modemSN = json['modem_SN'];
    task = json['task'];
    optical_cable = json['optical_cable'];
    fastconnector = json['fastconnector'];
    siqnal = json['siqnal'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['photo_modem'] = photoModem;
    data['modem_SN'] = modemSN;
    data['task'] = task;
    data['optical_cable'] = optical_cable;
    data['fastconnector'] = fastconnector;
    data['siqnal'] = siqnal;
    return data;
  }
}
