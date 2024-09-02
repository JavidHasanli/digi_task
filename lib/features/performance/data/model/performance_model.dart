class PerformanceModel {
  int? id;
  String? userType;
  String? firstName;
  String? lastName;
  Group? group;
  TaskCount? taskCount;
  List<String>? dates;

  PerformanceModel({
    this.id,
    this.userType,
    this.firstName,
    this.lastName,
    this.group,
    this.taskCount,
    this.dates,
  });

  PerformanceModel.fromJson(Map<String, dynamic> json) {
    id = json['id'] is String ? int.tryParse(json['id']) : json['id'];
    userType = json['user_type'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    group = json['group'] != null &&
            json['group'] is Map<String, dynamic> &&
            json['group'].isNotEmpty
        ? Group.fromJson(json['group'])
        : null;
    taskCount = json['task_count'] != null &&
            json['task_count'] is Map<String, dynamic> &&
            json['task_count'].isNotEmpty
        ? TaskCount.fromJson(json['task_count'])
        : null;
    dates = json['dates'] != null ? List<String>.from(json['dates']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_type'] = userType;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    if (group != null) {
      data['group'] = group!.toJson();
    }
    if (taskCount != null) {
      data['task_count'] = taskCount!.toJson();
    }
    if (dates != null) {
      data['dates'] = dates;
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
    id = json['id'] is String ? int.tryParse(json['id']) : json['id'];
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

class TaskCount {
  int? total;
  int? connection;
  int? problem;

  TaskCount({this.total, this.connection, this.problem});

  TaskCount.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    connection = json['connection'];
    problem = json['problem'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['total'] = total;
    data['connection'] = connection;
    data['problem'] = problem;
    return data;
  }
}
