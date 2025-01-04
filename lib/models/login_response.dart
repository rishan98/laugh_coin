class LoginResponse {
  bool? success;
  String? message;
  User? user;

  LoginResponse({this.success, this.message, this.user});

  LoginResponse.fromJson(Map<String, dynamic> json) {
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

  User({this.iD, this.username, this.email});

  User.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    username = json['username'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.iD;
    data['username'] = this.username;
    data['email'] = this.email;
    return data;
  }
}
