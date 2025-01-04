class DepositResponse {
  int? iD;
  String? appMassage;

  DepositResponse({this.iD, this.appMassage});

  DepositResponse.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    appMassage = json['app_massage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.iD;
    data['app_massage'] = this.appMassage;
    return data;
  }
}
