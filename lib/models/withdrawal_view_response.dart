class WithdrawalViewResponse {
  String? appMassage;
  String? adress;
  String? text;
  String? comingSoon;
  String? comingSoonText;
  String? btnText;
  String? lgcAvalible;

  WithdrawalViewResponse(
      {this.appMassage,
      this.adress,
      this.text,
      this.comingSoon,
      this.comingSoonText,
      this.btnText,
      this.lgcAvalible});

  WithdrawalViewResponse.fromJson(Map<String, dynamic> json) {
    appMassage = json['app_massage'];
    adress = json['Adress'];
    text = json['Text'];
    comingSoon = json['coming_soon'];
    comingSoonText = json['coming_soon_text'];
    btnText = json['btn_text'];
    lgcAvalible = json['lgc_avalible'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['app_massage'] = this.appMassage;
    data['Adress'] = this.adress;
    data['Text'] = this.text;
    data['coming_soon'] = this.comingSoon;
    data['coming_soon_text'] = this.comingSoonText;
    data['btn_text'] = this.btnText;
    data['lgc_avalible'] = this.lgcAvalible;
    return data;
  }
}
