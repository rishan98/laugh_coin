import 'dart:async';

import 'package:flutter/material.dart';
import 'package:laugh_coin/models/balance_response.dart';
import 'package:laugh_coin/models/deposit_history_response.dart';
import 'package:laugh_coin/models/deposit_response.dart';
import 'package:laugh_coin/models/mine_response.dart';
import 'package:laugh_coin/models/task_response.dart';
import 'package:laugh_coin/models/user_detail_response.dart';
import 'package:laugh_coin/models/user_task_response.dart';
import 'package:laugh_coin/models/withdrawal_history_response.dart';
import 'package:laugh_coin/models/withdrawal_response.dart';
import 'package:laugh_coin/services/home_service.dart';
import 'package:laugh_coin/utils/preference.dart';
import 'package:laugh_coin/utils/toast.dart';
import 'package:laugh_coin/views/home_screen.dart';
import 'package:laugh_coin/views/login_screen.dart';

class HomeViewModal with ChangeNotifier {
  final HomeService _homeService = HomeService();

  ShowToast toast = ShowToast();

  int _timeRemaining = 250; // Example: 250 seconds
  Timer? _timer;
  bool isTimerRunning = false;

  double currentLgc = 0.0;

  bool _isBalanceLoading = false;
  String? _errorMessage;
  BalanceResponse? _balanceResponse;
  WithdrawalResponse? _withdrawalResponse;
  DepositResponse? _depositResponse;
  WithdrawalHistoryResponse? _withdrawalHistoryResponse;
  DepositHistoryResponse? _depositHistoryResponse;
  TaskResponse? _taskResponse;
  UserTaskResponse? _userTaskResponse;
  UserDetailResponse? _userDetailResponse;
  MineResponse? _mineResponse;

  bool get isBalanceLoading => _isBalanceLoading;
  String? get errorMessage => _errorMessage;
  BalanceResponse? get balanceResponse => _balanceResponse;
  WithdrawalResponse? get withdrawalResponse => _withdrawalResponse;
  DepositResponse? get depositResponse => _depositResponse;
  WithdrawalHistoryResponse? get withdrawalHistoryResponse =>
      _withdrawalHistoryResponse;
  DepositHistoryResponse? get depositHistoryResponse => _depositHistoryResponse;
  TaskResponse? get taskResponse => _taskResponse;
  UserTaskResponse? get userTaskResponse => _userTaskResponse;
  UserDetailResponse? get userDetailResponse => _userDetailResponse;
  MineResponse? get mineResponse => _mineResponse;

  int get timeRemaining => _timeRemaining;

  loadingBalance(bool load) {
    _isBalanceLoading = load;
    notifyListeners();
  }

  getBalanceData(BuildContext context) async {
    loadingBalance(true);
    String? token = Preference.getString('token');
    await _homeService.userBalance(token).then((response) async {
      if (response.error!) {
        toast.showToastError(response.errorMessage!);
        Preference.setBool('login', false);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LoginScreen()),
        );
      } else {
        if (response.data != null) {
          _balanceResponse = response.data!;
        } else {
          toast.showToastError('Something went wrong');
        }
      }
    }).catchError((error) {
      toast.showToastError(error.toString());
    }).whenComplete(() {
      loadingBalance(false);
    });
  }

  Future<bool> setWithdrawalAmount(
      BuildContext context, String amount, String address) async {
    loadingBalance(true);
    String? token = Preference.getString('token');

    if (amount.isEmpty || address.isEmpty) {
      loadingBalance(false);
      toast.showToastError('Please enter amount and address');
      return false;
    }

    bool isSuccess = false;
    await _homeService
        .makeWithdrawal(amount, address, token)
        .then((response) async {
      if (response.error!) {
        toast.showToastError(response.errorMessage!);
      } else {
        if (response.data != null) {
          _withdrawalResponse = response.data!;
          toast.showToastSuccess(response.data!.appMassage!);
          isSuccess = true;
        } else {
          toast.showToastError('Something went wrong');
        }
      }
    }).catchError((error) {
      toast.showToastError(error.toString());
    }).whenComplete(() {
      loadingBalance(false);
    });

    return isSuccess;
  }

  Future<bool> setDepositAmount(
      BuildContext context, String amount, String address) async {
    loadingBalance(true);
    String? token = Preference.getString('token');

    if (amount.isEmpty || address.isEmpty) {
      loadingBalance(false);
      toast.showToastError('Please enter amount and address');
      return false;
    }

    bool isSuccess = false;
    await _homeService
        .makeDeposit(amount, address, token)
        .then((response) async {
      if (response.error!) {
        toast.showToastError(response.errorMessage!);
      } else {
        if (response.data != null) {
          _depositResponse = response.data!;
          toast.showToastSuccess(response.data!.appMassage!);
          isSuccess = true;
        } else {
          toast.showToastError('Something went wrong');
        }
      }
    }).catchError((error) {
      toast.showToastError(error.toString());
    }).whenComplete(() {
      loadingBalance(false);
    });

    return isSuccess;
  }

  getWithdrawalHistory(BuildContext context) async {
    loadingBalance(true);
    String? token = Preference.getString('token');
    await _homeService.getWithdrawalHistory(token).then((response) async {
      if (response.error!) {
        toast.showToastError(response.errorMessage!);
        Preference.setBool('login', false);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LoginScreen()),
        );
      } else {
        if (response.data != null) {
          _withdrawalHistoryResponse = response.data!;
        } else {
          toast.showToastError('Something went wrong');
        }
      }
    }).catchError((error) {
      toast.showToastError(error.toString());
    }).whenComplete(() {
      loadingBalance(false);
    });
  }

  getDepositHistory(BuildContext context) async {
    loadingBalance(true);
    String? token = Preference.getString('token');
    await _homeService.getDepositHistory(token).then((response) async {
      if (response.error!) {
        toast.showToastError(response.errorMessage!);
        Preference.setBool('login', false);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LoginScreen()),
        );
      } else {
        if (response.data != null) {
          _depositHistoryResponse = response.data!;
        } else {
          toast.showToastError('Something went wrong');
        }
      }
    }).catchError((error) {
      toast.showToastError(error.toString());
    }).whenComplete(() {
      loadingBalance(false);
    });
  }

  getTaskList(BuildContext context) async {
    loadingBalance(true);
    String? token = Preference.getString('token');
    await _homeService.getTaskList(token).then((response) async {
      if (response.error!) {
        toast.showToastError(response.errorMessage!);
        Preference.setBool('login', false);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LoginScreen()),
        );
      } else {
        if (response.data != null) {
          _taskResponse = response.data!;
        } else {
          toast.showToastError('Something went wrong');
        }
      }
    }).catchError((error) {
      toast.showToastError(error.toString());
    }).whenComplete(() {
      loadingBalance(false);
    });
  }

  setUserTask(BuildContext context, String taskId) async {
    loadingBalance(true);
    String? token = Preference.getString('token');
    await _homeService.setUserTask(taskId, token).then((response) async {
      if (response.error!) {
        toast.showToastError(response.errorMessage!);
      } else {
        if (response.data != null) {
          Navigator.pop(context);
          toast.showToastSuccess(response.data!.info!);
          _userTaskResponse = response.data!;
        } else {
          toast.showToastError('Something went wrong');
        }
      }
    }).catchError((error) {
      toast.showToastError(error.toString());
    }).whenComplete(() {
      loadingBalance(false);
    });
  }

  getBuyLgc(BuildContext context, String lgc) async {
    loadingBalance(true);
    String? token = Preference.getString('token');
    if (lgc.isNotEmpty) {
      await _homeService.getBuyLgc(lgc, token).then((response) async {
        if (response.error!) {
          toast.showToastError(response.errorMessage!);
        } else {
          if (response.data != null) {
            toast.showToastSuccess(response.data!.info!);
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const HomeScreen()),
            );
          } else {
            toast.showToastError('Something went wrong');
          }
        }
      }).catchError((error) {
        toast.showToastError(error.toString());
      }).whenComplete(() {
        loadingBalance(false);
      });
    } else {
      loadingBalance(false);
      toast.showToastError('Please enter lgc');
    }
  }

  getUserDetail(BuildContext context) async {
    loadingBalance(true);
    String? token = Preference.getString('token');
    await _homeService.getUserDetail(token).then((response) async {
      if (response.error!) {
        toast.showToastError(response.errorMessage!);
        Preference.setBool('login', false);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LoginScreen()),
        );
      } else {
        if (response.data != null) {
          _userDetailResponse = response.data!;
        } else {
          toast.showToastError('Something went wrong');
        }
      }
    }).catchError((error) {
      toast.showToastError(error.toString());
    }).whenComplete(() {
      loadingBalance(false);
    });
  }

  void clickStartCountDown() {
    isTimerRunning = true;
    double hrRate = double.tryParse(
            _balanceResponse?.miningRateForHour?.toString() ?? '0') ??
        0.0;
    double lgcValue =
        double.tryParse(_balanceResponse?.lgcBal?.toString() ?? '0') ?? 0.0;

    currentLgc = lgcValue;

    if (hrRate != 0) {
      var secondValue = hrRate / 3600;

      _timer?.cancel();
      _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        lgcValue += secondValue;
        _balanceResponse?.lgcBal = lgcValue.toStringAsFixed(6);

        notifyListeners();
      });
    } else {
      toast.showToastError('Mining rate is zero, cannot start countdown.');
    }
  }

  void clickStopCountDown() {
    isTimerRunning = false;
    _timer?.cancel();
    notifyListeners();

    double runningLgc =
        double.tryParse(_balanceResponse?.lgcBal?.toString() ?? '0') ?? 0.0;
    double lgcDiff = runningLgc - currentLgc;
    doUserMine(lgcDiff.toStringAsFixed(6));

  }

  void stopCountdown() {
    isTimerRunning = false;
    _timer?.cancel();
    notifyListeners();
  }

  doUserMine(String lgc) async {
    String? token = Preference.getString('token');
    await _homeService.doMine(lgc, token).then((response) async {
      if (response.error!) {
        toast.showToastError(response.errorMessage!);
        stopCountdown();
      } else {
        if (response.data != null) {
          _mineResponse = response.data!;
          if (response.data!.appMassage == "Limit Reached") {
            isTimerRunning = false;
            toast.showToastError(response.data!.appMassage!);
            stopCountdown();
            return;
          }

          toast.showToastSuccess(response.data!.appMassage!);
        } else {
          isTimerRunning = false;
          stopCountdown();
          toast.showToastError('Something went wrong');
        }
      }
    }).catchError((error) {
      isTimerRunning = false;
      stopCountdown();
      toast.showToastError(error.toString());
    }).whenComplete(() {
      // loadingBalance(false);
    });
  }
}
