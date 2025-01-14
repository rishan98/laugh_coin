class KycResponse {
  int? userID;
  String? emailVerifiedStates;
  String? phoneVerifiedStates;

  KycResponse(
      {this.userID, this.emailVerifiedStates, this.phoneVerifiedStates});

  KycResponse.fromJson(Map<String, dynamic> json) {
    userID = json['User ID'];
    emailVerifiedStates = json['email_verified_states'];
    phoneVerifiedStates = json['phone_verified_states'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['User ID'] = this.userID;
    data['email_verified_states'] = this.emailVerifiedStates;
    data['phone_verified_states'] = this.phoneVerifiedStates;
    return data;
  }
}
