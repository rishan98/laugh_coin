import 'dart:convert';

import 'package:laugh_coin/models/api_response.dart';
import 'package:laugh_coin/models/delete_account_response.dart';
import 'package:laugh_coin/models/edit_profile_response.dart';
import 'package:laugh_coin/models/login_response.dart';
import 'package:http/http.dart' as http;
import 'package:laugh_coin/models/register_response.dart';
import 'package:laugh_coin/models/token_response.dart';
import 'package:laugh_coin/utils/global.dart';

class LoginRegisterService {
  Future<APIResponse<LoginResponse>> userLogin(userName, password) async {
    var headers = {
      'Content-Type': 'application/json',
    };
    return http
        .post(Uri.parse(baseUrl + login),
            headers: headers,
            body: json.encode({"user": userName, "pass": password}))
        .then((data) {
      final jasonData = json.decode(data.body);

      if (data.statusCode == 200) {
        return APIResponse<LoginResponse>(
            data: LoginResponse.fromJson(jasonData));
      }
      if (data.statusCode == 401) {
        return APIResponse<LoginResponse>(
            error: true, errorMessage: jasonData['message']);
      }

      return APIResponse<LoginResponse>(
          error: true, errorMessage: 'Something went wrong');
    }).catchError((error) {
      return APIResponse<LoginResponse>(
          error: true, errorMessage: 'Something went wrong');
    });
  }

  Future<APIResponse<RegisterResponse>> userRegister(
      userName, password, email, firstName, lastName, mobile, refCode) async {
    var headers = {
      'Content-Type': 'application/json',
    };
    return http
        .post(Uri.parse(baseUrl + register),
            headers: headers,
            body: json.encode({
              "user": userName,
              "pass": password,
              "email": email,
              "first_name": firstName,
              "last_name": lastName,
              "mobile": mobile,
              "refcd": refCode
            }))
        .then((data) {
      final jasonData = json.decode(data.body);

      if (data.statusCode == 200) {
        return APIResponse<RegisterResponse>(
            data: RegisterResponse.fromJson(jasonData));
      }
      if (data.statusCode == 400) {
        return APIResponse<RegisterResponse>(
            error: true, errorMessage: jasonData['message']);
      }

      return APIResponse<RegisterResponse>(
          error: true, errorMessage: 'Something went wrong');
    }).catchError((error) {
      return APIResponse<RegisterResponse>(
          error: true, errorMessage: 'Something went wrong');
    });
  }

  Future<APIResponse<TokenResponse>> userLoginToken(userName, password) async {
    var headers = {
      'Content-Type': 'application/json',
    };
    return http
        .post(Uri.parse(baseUrl + token),
            headers: headers,
            body: json.encode({"user": userName, "pass": password}))
        .then((data) {
      final jasonData = json.decode(data.body);

      if (data.statusCode == 200) {
        return APIResponse<TokenResponse>(
            data: TokenResponse.fromJson(jasonData));
      }
      if (data.statusCode == 401) {
        return APIResponse<TokenResponse>(
            error: true, errorMessage: jasonData['message']);
      }

      return APIResponse<TokenResponse>(
          error: true, errorMessage: 'Something went wrong');
    }).catchError((error) {
      return APIResponse<TokenResponse>(
          error: true, errorMessage: 'Something went wrong');
    });
  }

  Future<APIResponse<DeleteAccountResponse>> userDeleteAccount(token) async {
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': token,
    };
    return http
        .post(
          Uri.parse(baseUrl + deleteAccount),
          headers: headers,
        )
        .timeout(const Duration(seconds: 10))
        .then((data) {
      final jasonData = json.decode(data.body);

      if (data.statusCode == 200) {
        return APIResponse<DeleteAccountResponse>(
            data: DeleteAccountResponse.fromJson(jasonData));
      }
      if (data.statusCode == 401) {
        return APIResponse<DeleteAccountResponse>(
            error: true, errorMessage: jasonData['message']);
      }

      return APIResponse<DeleteAccountResponse>(
          error: true, errorMessage: 'Something went wrong');
    }).catchError((error) {
      return APIResponse<DeleteAccountResponse>(
          error: true, errorMessage: 'Something went wrong');
    });
  }

  Future<APIResponse<EditProfileResponse>> editProfile(
      userName, password, firstName, lastName, email, token) async {
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': token,
    };
    return http
        .post(Uri.parse(baseUrl + editUserProfile),
            headers: headers,
            body: json.encode({
              "user": userName,
              "pass": password,
              "first_name": firstName,
              "last_name": lastName,
              "email": email
            }))
        .then((data) {
      final jasonData = json.decode(data.body);

      if (data.statusCode == 200) {
        return APIResponse<EditProfileResponse>(
            data: EditProfileResponse.fromJson(jasonData));
      }
      if (data.statusCode == 401) {
        return APIResponse<EditProfileResponse>(
            error: true, errorMessage: jasonData['message']);
      }

      return APIResponse<EditProfileResponse>(
          error: true, errorMessage: 'Something went wrong');
    }).catchError((error) {
      return APIResponse<EditProfileResponse>(
          error: true, errorMessage: 'Something went wrong');
    });
  }
}
