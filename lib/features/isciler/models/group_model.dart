class Group {
  final int id;
  final String group;
  final String region;

  Group({
    required this.id,
    required this.group,
    required this.region,
  });

  factory Group.fromJson(Map<String, dynamic> json) {
    return Group(
      id: json['id'],
      group: json['group'],
      region: json['region'],
    );
  }
}
