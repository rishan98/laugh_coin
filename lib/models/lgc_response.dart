class LgcResponse {
  int? iD;
  String? username;
  String? info;
  String? lgcBal;
  String? bnbBal;

  LgcResponse({this.iD, this.username, this.info, this.lgcBal, this.bnbBal});

  LgcResponse.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    username = json['username'];
    info = json['info'];
    lgcBal = json['lgc_bal'];
    bnbBal = json['bnb_bal'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.iD;
    data['username'] = this.username;
    data['info'] = this.info;
    data['lgc_bal'] = this.lgcBal;
    data['bnb_bal'] = this.bnbBal;
    return data;
  }
}
