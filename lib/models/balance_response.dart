class BalanceResponse {
  int? iD;
  String? username;
  String? email;
  String? lgcBal;
  String? bnbBal;
  String? perDayEarn;
  String? myRefCode;
  MiningSysResponse? miningSysResponse;

  BalanceResponse(
      {this.iD,
      this.username,
      this.email,
      this.lgcBal,
      this.bnbBal,
      this.perDayEarn,
      this.myRefCode,
      this.miningSysResponse});

  BalanceResponse.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    username = json['username'];
    email = json['email'];
    lgcBal = json['lgc_bal'];
    bnbBal = json['bnb_bal'];
    perDayEarn = json['per_day_earn'];
    myRefCode = json['my_ref_code'];
    miningSysResponse = json['mining_sys_response'] != null
        ? new MiningSysResponse.fromJson(json['mining_sys_response'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.iD;
    data['username'] = this.username;
    data['email'] = this.email;
    data['lgc_bal'] = this.lgcBal;
    data['bnb_bal'] = this.bnbBal;
    data['per_day_earn'] = this.perDayEarn;
    data['my_ref_code'] = this.myRefCode;
    if (this.miningSysResponse != null) {
      data['mining_sys_response'] = this.miningSysResponse!.toJson();
    }
    return data;
  }
}

class MiningSysResponse {
  int? userID;
  String? states;
  double? mined;
  String? currentTime;
  int? currentTimeUnix;
  String? startedTime;
  int? startedTimeUnix;
  int? minedTime;

  MiningSysResponse(
      {this.userID,
      this.states,
      this.mined,
      this.currentTime,
      this.currentTimeUnix,
      this.startedTime,
      this.startedTimeUnix,
      this.minedTime});

  MiningSysResponse.fromJson(Map<String, dynamic> json) {
    userID = json['User ID'];
    states = json['states'];
    mined = json['mined'];
    currentTime = json['current_time'];
    currentTimeUnix = json['current_time_unix'];
    startedTime = json['started_time'];
    startedTimeUnix = json['started_time_unix'];
    minedTime = json['mined_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['User ID'] = this.userID;
    data['states'] = this.states;
    data['mined'] = this.mined;
    data['current_time'] = this.currentTime;
    data['current_time_unix'] = this.currentTimeUnix;
    data['started_time'] = this.startedTime;
    data['started_time_unix'] = this.startedTimeUnix;
    data['mined_time'] = this.minedTime;
    return data;
  }
}
