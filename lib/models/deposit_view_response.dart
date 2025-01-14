class DepositViewResponse {
  String? appMassage;
  String? adress;
  String? text;
  String? comingSoon;
  String? comingSoonText;
  String? btnText;

  DepositViewResponse(
      {this.appMassage,
      this.adress,
      this.text,
      this.comingSoon,
      this.comingSoonText,
      this.btnText});

  DepositViewResponse.fromJson(Map<String, dynamic> json) {
    appMassage = json['app_massage'];
    adress = json['Adress'];
    text = json['Text'];
    comingSoon = json['coming_soon'];
    comingSoonText = json['coming_soon_text'];
    btnText = json['btn_text'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['app_massage'] = this.appMassage;
    data['Adress'] = this.adress;
    data['Text'] = this.text;
    data['coming_soon'] = this.comingSoon;
    data['coming_soon_text'] = this.comingSoonText;
    data['btn_text'] = this.btnText;
    return data;
  }
}
