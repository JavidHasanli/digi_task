class TaskCreatedSuccessModel {
  int? id;
  String? createdAt;
  String? updatedAt;
  String? fullName;
  String? taskType;
  String? registrationNumber;
  String? contactNumber;
  String? location;
  String? note;
  String? date;
  String? time;
  String? status;
  bool? isVoice;
  bool? isInternet;
  bool? isTv;
  int? user;
  List<int>? group;

  TaskCreatedSuccessModel(
      {this.id,
      this.createdAt,
      this.updatedAt,
      this.fullName,
      this.taskType,
      this.registrationNumber,
      this.contactNumber,
      this.location,
      this.note,
      this.date,
      this.time,
      this.status,
      this.isVoice,
      this.isInternet,
      this.isTv,
      this.user,
      this.group});

  TaskCreatedSuccessModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    fullName = json['full_name'];
    taskType = json['task_type'];
    registrationNumber = json['registration_number'];
    contactNumber = json['contact_number'];
    location = json['location'];
    note = json['note'];
    date = json['date'];
    time = json['time'];
    status = json['status'];
    isVoice = json['is_voice'];
    isInternet = json['is_internet'];
    isTv = json['is_tv'];
    user = json['user'];
    group = json['group'].cast<int>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['full_name'] = fullName;
    data['task_type'] = taskType;
    data['registration_number'] = registrationNumber;
    data['contact_number'] = contactNumber;
    data['location'] = location;
    data['note'] = note;
    data['date'] = date;
    data['time'] = time;
    data['status'] = status;
    data['is_voice'] = isVoice;
    data['is_internet'] = isInternet;
    data['is_tv'] = isTv;
    data['user'] = user;
    data['group'] = group;
    return data;
  }
}
