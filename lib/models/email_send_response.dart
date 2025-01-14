class EmailSendResponse {
  int? userID;
  String? appMassage;

  EmailSendResponse({this.userID, this.appMassage});

  EmailSendResponse.fromJson(Map<String, dynamic> json) {
    userID = json['User ID'];
    appMassage = json['app_massage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['User ID'] = this.userID;
    data['app_massage'] = this.appMassage;
    return data;
  }
}
