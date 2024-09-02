class UserTaskFailure {
  String? detail;
  String? code;
  List<Messages>? messages;

  UserTaskFailure({this.detail, this.code, this.messages});

  UserTaskFailure.fromJson(Map<String, dynamic> json) {
    detail = json['detail'];
    code = json['code'];
    if (json['messages'] != null) {
      messages = <Messages>[];
      json['messages'].forEach((v) {
        messages!.add(Messages.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['detail'] = detail;
    data['code'] = code;
    if (messages != null) {
      data['messages'] = messages!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Messages {
  String? tokenClass;
  String? tokenType;
  String? message;

  Messages({this.tokenClass, this.tokenType, this.message});

  Messages.fromJson(Map<String, dynamic> json) {
    tokenClass = json['token_class'];
    tokenType = json['token_type'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['token_class'] = tokenClass;
    data['token_type'] = tokenType;
    data['message'] = message;
    return data;
  }
}
