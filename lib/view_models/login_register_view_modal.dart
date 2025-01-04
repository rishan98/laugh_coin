import 'package:flutter/material.dart';
import 'package:laugh_coin/models/delete_account_response.dart';
import 'package:laugh_coin/models/edit_profile_response.dart';
import 'package:laugh_coin/models/login_response.dart';
import 'package:laugh_coin/models/register_response.dart';
import 'package:laugh_coin/models/token_response.dart';
import 'package:laugh_coin/services/login_register_service.dart';
import 'package:laugh_coin/utils/preference.dart';
import 'package:laugh_coin/utils/toast.dart';
import 'package:laugh_coin/views/home_screen.dart';
import 'package:laugh_coin/views/login_screen.dart';

class LoginRegisterViewModel with ChangeNotifier {
  final LoginRegisterService _loginService = LoginRegisterService();
  ShowToast toast = ShowToast();

  bool _isLoading = false;
  String? _errorMessage;
  LoginResponse? _loginResponse;
  RegisterResponse? _registerResponse;
  TokenResponse? _tokenResponse;
  DeleteAccountResponse? _deleteAccountResponse;
  EditProfileResponse? _editProfileResponse;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  LoginResponse? get loginResponse => _loginResponse;
  RegisterResponse? get registerResponse => _registerResponse;
  TokenResponse? get tokenResponse => _tokenResponse;
  DeleteAccountResponse? get deleteAccountResponse => _deleteAccountResponse!;
  EditProfileResponse? get editProfileResponse => _editProfileResponse;

  loading(bool load) {
    _isLoading = load;
    notifyListeners();
  }

  onLoginBtnClick(
      BuildContext context, String userName, String password) async {
    loading(true);

    if (userName.isNotEmpty && password.isNotEmpty) {
      await _loginService.userLogin(userName, password).then((response) async {
        if (response.error!) {
          toast.showToastError(response.errorMessage!);
        } else {
          if (response.data!.success == true) {
            //get token
            getLoginToken(context, userName, password);
            Preference.setBool("login", true);
            Preference.setString("userName", (response.data!.user!.username)!);
            Preference.setString("userEmail", (response.data!.user!.email)!);
            Preference.setInt("userId", (response.data!.user!.iD!));
            _loginResponse = response.data!;

            toast.showToastSuccess(response.data!.message!);
          } else {
            toast.showToastError('Invlaid username or password');
          }
        }
      });
    } else {
      toast.showToastError("Please enter both username and password");
    }

    loading(false);
  }

  Future<void> onRegisterBtnClick(
      BuildContext context,
      String userName,
      String password,
      String email,
      String firstName,
      String lastName,
      String mobile,
      String refCode) async {
    loading(true);
    String? validationError = validateFields({
      "First Name": firstName,
      "Last Name": lastName,
      "Mobile": mobile,
      "Email": email,
      "User Name": userName,
      "Password": password,
    });

    if (validationError != null) {
      toast.showToastError(validationError);
      loading(false);
      return;
    }

    await _loginService
        .userRegister(
            userName, password, email, firstName, lastName, mobile, refCode)
        .then((response) async {
      if (response.error!) {
        toast.showToastError(response.errorMessage!);
      } else {
        if (response.data!.success == true) {
          getLoginToken(context, userName, password);
          Preference.setBool("login", true);
          Preference.setString("userName", (response.data!.user!.username)!);
          Preference.setString("userEmail", (response.data!.user!.email)!);
          Preference.setInt("userId", (response.data!.user!.iD!));
          _registerResponse = response.data!;

          toast.showToastSuccess(response.data!.message!);
        } else {
          toast.showToastError('Invlaid credentials');
        }
      }
    });
    loading(false);
  }

  String? validateFields(Map<String, String> fields) {
    for (var entry in fields.entries) {
      if (entry.value.isEmpty) {
        return '${entry.key} cannot be empty';
      }
      if (entry.key == "Email" && !validateEmail(entry.value)) {
        return 'Please enter a valid email address';
      }
    }
    return null;
  }

  bool validateEmail(String email) {
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+',
    );
    return emailRegex.hasMatch(email);
  }

  getLoginToken(BuildContext context, String userName, String password) async {
    loading(true);

    await _loginService
        .userLoginToken(userName, password)
        .then((response) async {
      if (response.error!) {
        toast.showToastError(response.errorMessage!);
      } else {
        if (response.data!.success == true) {
          Preference.setString("token", (response.data!.user!.bearerToken)!);
          _tokenResponse = response.data!;

          if (_tokenResponse != null) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const HomeScreen()),
            );
          }
        } else {
          toast.showToastError('Invalid username or password');
        }
      }
    });
    loading(false);
  }

  deleteUserAccount(BuildContext context) async {
    loading(true);
    String? token = Preference.getString('token');
    await _loginService.userDeleteAccount(token!).then((response) async {
      if (response.error!) {
        toast.showToastError(response.errorMessage!);
      } else {
        if (response.data!.isDeletedResponse == true) {
          _deleteAccountResponse = response.data!;

          if (_deleteAccountResponse != null &&
              response.data!.isDeletedResponse == true) {
            Preference.setBool("login", false);
            Preference.clearPreferences();
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const LoginScreen()),
            );
          }
        } else {
          toast.showToastError('Error Occured. Please try again');
        }
      }
    });
    loading(false);
  }

  editProfile(BuildContext context, String firstName, String lastName,
      String email, String userName, String password) async {
    loading(true);
    String? token = Preference.getString('token');
    await _loginService
        .editProfile(userName, password, firstName, lastName, email, token!)
        .then((response) async {
      if (response.error!) {
        toast.showToastError(response.errorMessage!);
      } else {
        if (response.data != null) {
          Preference.setString("userName", userName);
          Preference.setString("userEmail", email);
          toast.showToastSuccess(response.data!.appMassage!);
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const HomeScreen()),
          );
        } else {
          toast.showToastError('Error Occured. Please try again');
        }
      }
    });
    loading(false);
  }
}
