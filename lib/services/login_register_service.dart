import 'dart:convert';

import 'package:laugh_coin/models/api_response.dart';
import 'package:laugh_coin/models/delete_account_response.dart';
import 'package:laugh_coin/models/edit_profile_response.dart';
import 'package:laugh_coin/models/email_send_response.dart';
import 'package:laugh_coin/models/kyc_response.dart';
import 'package:laugh_coin/models/login_response.dart';
import 'package:http/http.dart' as http;
import 'package:laugh_coin/models/otp_response.dart';
import 'package:laugh_coin/models/register_response.dart';
import 'package:laugh_coin/models/sms_otp_response.dart';
import 'package:laugh_coin/models/sms_send_resposne.dart';
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

  Future<APIResponse<KycResponse>> getKycInfo(token) async {
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': token,
    };
    return http
        .post(
          Uri.parse(baseUrl + kycInfo),
          headers: headers,
        )
        .timeout(const Duration(seconds: 10))
        .then((data) {
      final jasonData = json.decode(data.body);

      if (data.statusCode == 200) {
        return APIResponse<KycResponse>(data: KycResponse.fromJson(jasonData));
      }
      if (data.statusCode == 401) {
        return APIResponse<KycResponse>(
            error: true, errorMessage: jasonData['message']);
      }

      return APIResponse<KycResponse>(
          error: true, errorMessage: 'Something went wrong');
    }).catchError((error) {
      return APIResponse<KycResponse>(
          error: true, errorMessage: 'Something went wrong');
    });
  }

  Future<APIResponse<EmailSendResponse>> sentKycEmail(token) async {
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': token,
    };
    return http
        .post(
          Uri.parse(baseUrl + sendEmail),
          headers: headers,
        )
        .timeout(const Duration(seconds: 10))
        .then((data) {
      final jasonData = json.decode(data.body);

      if (data.statusCode == 200) {
        return APIResponse<EmailSendResponse>(
            data: EmailSendResponse.fromJson(jasonData));
      }
      if (data.statusCode == 401) {
        return APIResponse<EmailSendResponse>(
            error: true, errorMessage: jasonData['message']);
      }

      return APIResponse<EmailSendResponse>(
          error: true, errorMessage: 'Something went wrong');
    }).catchError((error) {
      return APIResponse<EmailSendResponse>(
          error: true, errorMessage: 'Something went wrong');
    });
  }

  Future<APIResponse<SmsSendResponse>> sentKycSms(token) async {
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': token,
    };
    return http
        .post(
          Uri.parse(baseUrl + sendSms),
          headers: headers,
        )
        .timeout(const Duration(seconds: 10))
        .then((data) {
      final jasonData = json.decode(data.body);

      if (data.statusCode == 200) {
        return APIResponse<SmsSendResponse>(
            data: SmsSendResponse.fromJson(jasonData));
      }
      if (data.statusCode == 401) {
        return APIResponse<SmsSendResponse>(
            error: true, errorMessage: jasonData['message']);
      }

      return APIResponse<SmsSendResponse>(
          error: true, errorMessage: 'Something went wrong');
    }).catchError((error) {
      return APIResponse<SmsSendResponse>(
          error: true, errorMessage: 'Something went wrong');
    });
  }

  Future<APIResponse<OtpResponse>> sentEmailOtp(token, otp) async {
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': token,
    };
    return http
        .post(Uri.parse(baseUrl + sendOtp),
            headers: headers, body: json.encode({"otp": otp}))
        .timeout(const Duration(seconds: 10))
        .then((data) {
      final jasonData = json.decode(data.body);

      if (data.statusCode == 200) {
        return APIResponse<OtpResponse>(data: OtpResponse.fromJson(jasonData));
      }
      if (data.statusCode == 401) {
        return APIResponse<OtpResponse>(
            error: true, errorMessage: jasonData['message']);
      }

      return APIResponse<OtpResponse>(
          error: true, errorMessage: 'Something went wrong');
    }).catchError((error) {
      return APIResponse<OtpResponse>(
          error: true, errorMessage: 'Something went wrong');
    });
  }

  Future<APIResponse<SmsOtpResponse>> sentSmsOtp(token, otp) async {
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': token,
    };
    return http
        .post(Uri.parse(baseUrl + sendSmsOtp),
            headers: headers, body: json.encode({"otp": otp}))
        .timeout(const Duration(seconds: 10))
        .then((data) {
      final jasonData = json.decode(data.body);

      if (data.statusCode == 200) {
        return APIResponse<SmsOtpResponse>(
            data: SmsOtpResponse.fromJson(jasonData));
      }
      if (data.statusCode == 401) {
        return APIResponse<SmsOtpResponse>(
            error: true, errorMessage: jasonData['message']);
      }

      return APIResponse<SmsOtpResponse>(
          error: true, errorMessage: 'Something went wrong');
    }).catchError((error) {
      return APIResponse<SmsOtpResponse>(
          error: true, errorMessage: 'Something went wrong');
    });
  }
}
