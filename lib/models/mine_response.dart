class MineResponse {
  int? iD;
  String? appMassage;
  String? lgcBal;

  MineResponse({this.iD, this.appMassage, this.lgcBal});

  MineResponse.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    appMassage = json['app_massage'];
    lgcBal = json['lgc_bal'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.iD;
    data['app_massage'] = this.appMassage;
    data['lgc_bal'] = this.lgcBal;
    return data;
  }
}
