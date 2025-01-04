class TokenResponse {
  bool? success;
  String? message;
  User? user;

  TokenResponse({this.success, this.message, this.user});

  TokenResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    return data;
  }
}

class User {
  int? iD;
  String? username;
  String? email;
  String? bearerToken;
  int? expire;
  int? tokenValid;

  User(
      {this.iD,
      this.username,
      this.email,
      this.bearerToken,
      this.expire,
      this.tokenValid});

  User.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    username = json['username'];
    email = json['email'];
    bearerToken = json['bearer_token'];
    expire = json['expire'];
    tokenValid = json['token_valid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.iD;
    data['username'] = this.username;
    data['email'] = this.email;
    data['bearer_token'] = this.bearerToken;
    data['expire'] = this.expire;
    data['token_valid'] = this.tokenValid;
    return data;
  }
}
