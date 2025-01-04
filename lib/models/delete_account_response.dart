class DeleteAccountResponse {
  bool? isDeletedResponse;
  int? user;

  DeleteAccountResponse({this.isDeletedResponse, this.user});

  DeleteAccountResponse.fromJson(Map<String, dynamic> json) {
    isDeletedResponse = json['is_deleted_response'];
    user = json['user'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['is_deleted_response'] = this.isDeletedResponse;
    data['user'] = this.user;
    return data;
  }
}
