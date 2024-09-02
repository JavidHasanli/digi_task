class UserTaskModel {
  String? firstName;
  String? lastName;
  Group? group;
  String? userType;
  TaskDetails? taskDetails;
  List<OngoingTasks>? ongoingTasks;
  List<Meetings>? meetings;

  UserTaskModel(
      {this.firstName, this.lastName, this.group, this.userType, this.taskDetails, this.ongoingTasks, this.meetings});

  UserTaskModel.fromJson(Map<String, dynamic> json) {
    firstName = json['first_name'];
    lastName = json['last_name'];
    group = json['group'] != null ? Group.fromJson(json['group']) : null;
    userType = json['user_type'];
    taskDetails = json['task_details'] != null ? TaskDetails.fromJson(json['task_details']) : null;
    if (json['ongoing_tasks'] != null) {
      ongoingTasks = <OngoingTasks>[];
      json['ongoing_tasks'].forEach((v) {
        ongoingTasks!.add(OngoingTasks.fromJson(v));
      });
    }
    if (json['meetings'] != null) {
      meetings = <Meetings>[];
      json['meetings'].forEach((v) {
        meetings!.add(Meetings.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    if (group != null) {
      data['group'] = group!.toJson();
    }
    data['user_type'] = userType;
    if (taskDetails != null) {
      data['task_details'] = taskDetails!.toJson();
    }
    if (ongoingTasks != null) {
      data['ongoing_tasks'] = ongoingTasks!.map((v) => v.toJson()).toList();
    }
    if (meetings != null) {
      data['meetings'] = meetings!.map((v) => v.toJson()).toList();
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

class TaskDetails {
  int? problemCount;
  int? connectionCount;

  TaskDetails({this.problemCount, this.connectionCount});

  TaskDetails.fromJson(Map<String, dynamic> json) {
    problemCount = json['problem_count'];
    connectionCount = json['connection_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['problem_count'] = problemCount;
    data['connection_count'] = connectionCount;
    return data;
  }
}

class OngoingTasks {
  int? id;
  List<Group>? group;
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
  String? time;
  String? status;
  bool? isVoice;
  bool? isInternet;
  bool? isTv;
  int? user;

  OngoingTasks(
      {this.id,
      this.group,
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
      this.time,
      this.status,
      this.isVoice,
      this.isInternet,
      this.isTv,
      this.user});

  OngoingTasks.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    if (json['group'] != null) {
      group = <Group>[];
      json['group'].forEach((v) {
        group!.add(Group.fromJson(v));
      });
    }
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
    time = json['time'];
    status = json['status'];
    isVoice = json['is_voice'];
    isInternet = json['is_internet'];
    isTv = json['is_tv'];
    user = json['user'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    if (group != null) {
      data['group'] = group!.map((v) => v.toJson()).toList();
    }
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
    data['time'] = time;
    data['status'] = status;
    data['is_voice'] = isVoice;
    data['is_internet'] = isInternet;
    data['is_tv'] = isTv;
    data['user'] = user;
    return data;
  }
}

class Meetings {
  int? id;
  String? title;
  String? meetingType;
  String? date;
  String? meetingDescription;

  Meetings({this.id, this.title, this.meetingType, this.date, this.meetingDescription});

  Meetings.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    meetingType = json['meeting_type'];
    date = json['date'];
    meetingDescription = json['meeting_description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['meeting_type'] = meetingType;
    data['date'] = date;
    data['meeting_description'] = meetingDescription;
    return data;
  }
}
