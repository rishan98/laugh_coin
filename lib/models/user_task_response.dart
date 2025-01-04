class UserTaskResponse {
  int? userID;
  String? info;

  UserTaskResponse({this.userID, this.info});

  UserTaskResponse.fromJson(Map<String, dynamic> json) {
    userID = json['User ID'];
    info = json['info'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['User ID'] = this.userID;
    data['info'] = this.info;
    return data;
  }
}
