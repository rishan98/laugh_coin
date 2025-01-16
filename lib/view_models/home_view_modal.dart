import 'dart:async';

import 'package:flutter/material.dart';
import 'package:laugh_coin/models/balance_response.dart';
import 'package:laugh_coin/models/deposit_history_response.dart';
import 'package:laugh_coin/models/deposit_response.dart';
import 'package:laugh_coin/models/deposit_view_response.dart';
import 'package:laugh_coin/models/mine_response.dart';
import 'package:laugh_coin/models/task_response.dart';
import 'package:laugh_coin/models/user_detail_response.dart';
import 'package:laugh_coin/models/user_task_response.dart';
import 'package:laugh_coin/models/withdrawal_history_response.dart';
import 'package:laugh_coin/models/withdrawal_response.dart';
import 'package:laugh_coin/models/withdrawal_view_response.dart';
import 'package:laugh_coin/services/home_service.dart';
import 'package:laugh_coin/utils/preference.dart';
import 'package:laugh_coin/utils/toast.dart';
import 'package:laugh_coin/views/home_screen.dart';
import 'package:laugh_coin/views/login_screen.dart';

class HomeViewModal with ChangeNotifier {
  final HomeService _homeService = HomeService();

  ShowToast toast = ShowToast();

  Timer? _timer;
  Duration _timeRemaining = Duration.zero;
  bool isTimerRunning = false;

  double currentLgc = 0.0;
  Map<String, bool> claimButtonStates = {};

  bool _isBalanceLoading = false;
  bool _isMiningLoading = false;
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
  WithdrawalViewResponse? _withdrawalViewResponse;
  DepositViewResponse? _depositViewResponse;

  bool get isBalanceLoading => _isBalanceLoading;
  bool get isMiningLoading => _isMiningLoading;
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
  WithdrawalViewResponse? get withdrawalViewResponse => _withdrawalViewResponse;
  DepositViewResponse? get depositViewResponse => _depositViewResponse;

  Duration get timeRemaining => _timeRemaining;

  loadingBalance(bool load) {
    _isBalanceLoading = load;
    notifyListeners();
  }

  loadingMining(bool load) {
    _isMiningLoading = load;
    notifyListeners();
  }

  getBalanceData(BuildContext context) async {
    isTimerRunning = false;
    _timeRemaining = Duration.zero;
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
          if (response.data!.miningSysResponse!.minedTime != null) {
            isTimerRunning = true;
            startCountdown(response.data!.miningSysResponse!.startedTime!);
          }
          notifyListeners();
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

    if (int.parse(amount) < 3000) {
      loadingBalance(false);
      toast.showToastError('Please enter amount more than 3000');
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

  doUserMine() async {
    loadingMining(true);
    String? token = Preference.getString('token');
    await _homeService.doMine(token).then((response) async {
      if (response.error!) {
        loadingMining(false);
        toast.showToastError(response.errorMessage!);
      } else {
        if (response.data != null) {
          _mineResponse = response.data!;
          if (response.data!.appMassage == "started") {
            loadingMining(false);
            isTimerRunning = true;
            DateTime now = DateTime.now();
            startCountdown(now.toString());
            notifyListeners();
          }
        } else {
          loadingMining(false);
          isTimerRunning = false;
          toast.showToastError('Something went wrong');
        }
      }
    }).catchError((error) {
      isTimerRunning = false;
      loadingMining(false);
      toast.showToastError(error.toString());
    }).whenComplete(() {
      loadingMining(false);
    });
  }

  void startCountdown(String startedTimeString) {
    DateTime startedTime = DateTime.parse(startedTimeString);
    DateTime endTime = startedTime.add(const Duration(hours: 24));
    DateTime now = DateTime.now();

    if (now.isAfter(endTime)) {
      // If the end time has already passed
      isTimerRunning = false;
      _timeRemaining = Duration.zero;
      notifyListeners();
    } else {
      // Calculate the initial remaining time
      _timeRemaining = endTime.difference(now);

      // Start the timer
      _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        if (_timeRemaining.inSeconds > 0) {
          _timeRemaining = _timeRemaining - const Duration(seconds: 1);
          notifyListeners();
        } else {
          // Stop the timer when countdown is over
          timer.cancel();
          isTimerRunning = false;
          notifyListeners();
        }
      });
    }
  }

  getWithdrawalDetails(BuildContext context) async {
    loadingBalance(true);
    String? token = Preference.getString('token');
    await _homeService.viewWithdrawalDetails(token).then((response) async {
      if (response.error!) {
        toast.showToastError(response.errorMessage!);
        Preference.setBool('login', false);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LoginScreen()),
        );
      } else {
        if (response.data != null) {
          _withdrawalViewResponse = response.data!;
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

  getDepositDetails(BuildContext context) async {
    loadingBalance(true);
    String? token = Preference.getString('token');
    await _homeService.viewDepositDetails(token).then((response) async {
      if (response.error!) {
        toast.showToastError(response.errorMessage!);
        Preference.setBool('login', false);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LoginScreen()),
        );
      } else {
        if (response.data != null) {
          _depositViewResponse = response.data!;
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

  void initializeClaimButtonStates(List<TaskList> taskList) {
    for (var task in taskList) {
      claimButtonStates[task.id ?? ''] =
          false;
    }
    notifyListeners();
  }

  void enableClaimButton(String taskId) {
    claimButtonStates[taskId] = true; 
    notifyListeners();
  }
}
