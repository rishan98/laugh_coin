class BalanceResponse {
  int? iD;
  String? username;
  String? email;
  String? lgcBal;
  String? bnbBal;
  String? perDayEarn;
  String? myRefCode;
  MiningSysResponse? miningSysResponse;
  Socials? socials;

  BalanceResponse(
      {this.iD,
      this.username,
      this.email,
      this.lgcBal,
      this.bnbBal,
      this.perDayEarn,
      this.myRefCode,
      this.miningSysResponse,
      this.socials});

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
    socials =
        json['socials'] != null ? new Socials.fromJson(json['socials']) : null;
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
    if (this.socials != null) {
      data['socials'] = this.socials!.toJson();
    }
    return data;
  }
}

class MiningSysResponse {
  int? userID;
  String? states;
  double? mined;
  String? currentTime;
  String? startedTime;
  int? minedTime;

  MiningSysResponse(
      {this.userID,
      this.states,
      this.mined,
      this.currentTime,
      this.startedTime,
      this.minedTime});

  MiningSysResponse.fromJson(Map<String, dynamic> json) {
    userID = json['User ID'];
    states = json['states'];
    mined = json['mined'];
    currentTime = json['current_time'];
    startedTime = json['started_time'];
    minedTime = json['mined_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['User ID'] = this.userID;
    data['states'] = this.states;
    data['mined'] = this.mined;
    data['current_time'] = this.currentTime;
    data['started_time'] = this.startedTime;
    data['mined_time'] = this.minedTime;
    return data;
  }
}

class Socials {
  String? facebook;
  String? x;
  String? tIKTOK;
  String? youtube;
  String? insta;
  String? whatsapp;

  Socials(
      {this.facebook,
      this.x,
      this.tIKTOK,
      this.youtube,
      this.insta,
      this.whatsapp});

  Socials.fromJson(Map<String, dynamic> json) {
    facebook = json['facebook'];
    x = json['X'];
    tIKTOK = json['TIKTOK'];
    youtube = json['Youtube'];
    insta = json['Insta'];
    whatsapp = json['whatsapp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['facebook'] = this.facebook;
    data['X'] = this.x;
    data['TIKTOK'] = this.tIKTOK;
    data['Youtube'] = this.youtube;
    data['Insta'] = this.insta;
    data['whatsapp'] = this.whatsapp;
    return data;
  }
}
