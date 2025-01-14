class SmsSendResponse {
  int? userID;
  String? appMassage;

  SmsSendResponse({this.userID, this.appMassage});

  SmsSendResponse.fromJson(Map<String, dynamic> json) {
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
