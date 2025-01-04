class UserDetailResponse {
  int? userID;
  String? username;
  String? email;
  String? firstName;
  String? lastName;

  UserDetailResponse(
      {this.userID, this.username, this.email, this.firstName, this.lastName});

  UserDetailResponse.fromJson(Map<String, dynamic> json) {
    userID = json['User ID'];
    username = json['username'];
    email = json['email'];
    firstName = json['first_name'];
    lastName = json['last_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['User ID'] = this.userID;
    data['username'] = this.username;
    data['email'] = this.email;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    return data;
  }
}
