class BalanceResponse {
  int? iD;
  String? username;
  String? email;
  String? lgcBal;
  String? bnbBal;
  String? myRefCode;
  String? miningRateForHour;

  BalanceResponse(
      {this.iD,
      this.username,
      this.email,
      this.lgcBal,
      this.bnbBal,
      this.myRefCode,
      this.miningRateForHour});

  BalanceResponse.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    username = json['username'];
    email = json['email'];
    lgcBal = json['lgc_bal'];
    bnbBal = json['bnb_bal'];
    myRefCode = json['my_ref_code'];
    miningRateForHour = json['mining_rate_for_hour'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.iD;
    data['username'] = this.username;
    data['email'] = this.email;
    data['lgc_bal'] = this.lgcBal;
    data['bnb_bal'] = this.bnbBal;
    data['my_ref_code'] = this.myRefCode;
    data['mining_rate_for_hour'] = this.miningRateForHour;
    return data;
  }
}
