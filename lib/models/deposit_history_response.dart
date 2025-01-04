class DepositHistoryResponse {
  int? iD;
  List<AppMassage>? appMassage;

  DepositHistoryResponse({this.iD, this.appMassage});

  DepositHistoryResponse.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    if (json['app_massage'] != null) {
      appMassage = <AppMassage>[];
      json['app_massage'].forEach((v) {
        appMassage!.add(new AppMassage.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ID'] = this.iD;
    if (this.appMassage != null) {
      data['app_massage'] = this.appMassage!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AppMassage {
  String? id;
  String? userId;
  String? amount;
  String? adress;
  String? coinType;
  String? approvedState;
  String? state;

  AppMassage(
      {this.id,
      this.userId,
      this.amount,
      this.adress,
      this.coinType,
      this.approvedState,
      this.state});

  AppMassage.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    amount = json['amount'];
    adress = json['adress'];
    coinType = json['coin_type'];
    approvedState = json['approved_state'];
    state = json['state'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['amount'] = this.amount;
    data['adress'] = this.adress;
    data['coin_type'] = this.coinType;
    data['approved_state'] = this.approvedState;
    data['state'] = this.state;
    return data;
  }
}
