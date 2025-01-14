import 'dart:convert';

import 'package:laugh_coin/models/api_response.dart';
import 'package:laugh_coin/models/balance_response.dart';
import 'package:laugh_coin/models/deposit_history_response.dart';
import 'package:laugh_coin/models/deposit_response.dart';
import 'package:laugh_coin/models/deposit_view_response.dart';
import 'package:laugh_coin/models/lgc_response.dart';
import 'package:laugh_coin/models/mine_response.dart';
import 'package:laugh_coin/models/task_response.dart';
import 'package:laugh_coin/models/user_detail_response.dart';
import 'package:laugh_coin/models/user_task_response.dart';
import 'package:laugh_coin/models/withdrawal_history_response.dart';
import 'package:laugh_coin/models/withdrawal_response.dart';
import 'package:laugh_coin/models/withdrawal_view_response.dart';
import 'package:laugh_coin/utils/global.dart';
import 'package:http/http.dart' as http;

class HomeService {
  Future<APIResponse<BalanceResponse>> userBalance(token) async {
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': token,
    };
    return http
        .get(Uri.parse(baseUrl + balance), headers: headers)
        .timeout(const Duration(seconds: 10))
        .then((data) {
      final jasonData = json.decode(data.body);

      if (data.statusCode == 200) {
        return APIResponse<BalanceResponse>(
            data: BalanceResponse.fromJson(jasonData));
      }
      if (data.statusCode == 401) {
        return APIResponse<BalanceResponse>(
            error: true, errorMessage: jasonData['message']);
      }

      if (data.statusCode == 500) {
        return APIResponse<BalanceResponse>(
            error: true, errorMessage: jasonData['message']);
      }

      return APIResponse<BalanceResponse>(
          error: true, errorMessage: 'Something went wrong');
    }).catchError((error) {
      return APIResponse<BalanceResponse>(
          error: true, errorMessage: 'Something went wrong');
    });
  }

  Future<APIResponse<WithdrawalResponse>> makeWithdrawal(
      amount, address, token) async {
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': token,
    };
    return http
        .post(Uri.parse(baseUrl + withdrawAmount),
            headers: headers,
            body: json.encode({"amount": amount, "address": address}))
        .then((data) {
      final jasonData = json.decode(data.body);

      if (data.statusCode == 200) {
        return APIResponse<WithdrawalResponse>(
            data: WithdrawalResponse.fromJson(jasonData));
      }
      if (data.statusCode == 401) {
        return APIResponse<WithdrawalResponse>(
            error: true, errorMessage: jasonData['message']);
      }

      return APIResponse<WithdrawalResponse>(
          error: true, errorMessage: 'Something went wrong');
    }).catchError((error) {
      return APIResponse<WithdrawalResponse>(
          error: true, errorMessage: 'Something went wrong');
    });
  }

  Future<APIResponse<DepositResponse>> makeDeposit(
      amount, address, token) async {
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': token,
    };
    return http
        .post(Uri.parse(baseUrl + depositAmount),
            headers: headers,
            body: json.encode({"amount": amount, "address": address}))
        .then((data) {
      final jasonData = json.decode(data.body);

      if (data.statusCode == 200) {
        return APIResponse<DepositResponse>(
            data: DepositResponse.fromJson(jasonData));
      }
      if (data.statusCode == 401) {
        return APIResponse<DepositResponse>(
            error: true, errorMessage: jasonData['message']);
      }

      return APIResponse<DepositResponse>(
          error: true, errorMessage: 'Something went wrong');
    }).catchError((error) {
      return APIResponse<DepositResponse>(
          error: true, errorMessage: 'Something went wrong');
    });
  }

  Future<APIResponse<WithdrawalHistoryResponse>> getWithdrawalHistory(
      token) async {
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': token,
    };
    return http
        .post(Uri.parse(baseUrl + withdrawalHistory), headers: headers)
        .timeout(const Duration(seconds: 10))
        .then((data) {
      final jasonData = json.decode(data.body);

      if (data.statusCode == 200) {
        return APIResponse<WithdrawalHistoryResponse>(
            data: WithdrawalHistoryResponse.fromJson(jasonData));
      }
      if (data.statusCode == 401) {
        return APIResponse<WithdrawalHistoryResponse>(
            error: true, errorMessage: jasonData['message']);
      }

      if (data.statusCode == 500) {
        return APIResponse<WithdrawalHistoryResponse>(
            error: true, errorMessage: jasonData['message']);
      }

      return APIResponse<WithdrawalHistoryResponse>(
          error: true, errorMessage: 'Something went wrong');
    }).catchError((error) {
      return APIResponse<WithdrawalHistoryResponse>(
          error: true, errorMessage: 'Something went wrong');
    });
  }

  Future<APIResponse<DepositHistoryResponse>> getDepositHistory(token) async {
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': token,
    };
    return http
        .post(Uri.parse(baseUrl + depositHistory), headers: headers)
        .timeout(const Duration(seconds: 10))
        .then((data) {
      final jasonData = json.decode(data.body);

      if (data.statusCode == 200) {
        return APIResponse<DepositHistoryResponse>(
            data: DepositHistoryResponse.fromJson(jasonData));
      }
      if (data.statusCode == 401) {
        return APIResponse<DepositHistoryResponse>(
            error: true, errorMessage: jasonData['message']);
      }

      if (data.statusCode == 500) {
        return APIResponse<DepositHistoryResponse>(
            error: true, errorMessage: jasonData['message']);
      }

      return APIResponse<DepositHistoryResponse>(
          error: true, errorMessage: 'Something went wrong');
    }).catchError((error) {
      return APIResponse<DepositHistoryResponse>(
          error: true, errorMessage: 'Something went wrong');
    });
  }

  Future<APIResponse<TaskResponse>> getTaskList(token) async {
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': token,
    };
    return http
        .post(Uri.parse(baseUrl + taskList), headers: headers)
        .timeout(const Duration(seconds: 10))
        .then((data) {
      final jasonData = json.decode(data.body);

      if (data.statusCode == 200) {
        return APIResponse<TaskResponse>(
            data: TaskResponse.fromJson(jasonData));
      }
      if (data.statusCode == 401) {
        return APIResponse<TaskResponse>(
            error: true, errorMessage: jasonData['message']);
      }

      if (data.statusCode == 500) {
        return APIResponse<TaskResponse>(
            error: true, errorMessage: jasonData['message']);
      }

      return APIResponse<TaskResponse>(
          error: true, errorMessage: 'Something went wrong');
    }).catchError((error) {
      return APIResponse<TaskResponse>(
          error: true, errorMessage: 'Something went wrong');
    });
  }

  Future<APIResponse<UserTaskResponse>> setUserTask(taskId, token) async {
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': token,
    };
    return http
        .post(Uri.parse(baseUrl + userTask),
            headers: headers, body: json.encode({"task_id": taskId}))
        .then((data) {
      final jasonData = json.decode(data.body);

      if (data.statusCode == 200) {
        return APIResponse<UserTaskResponse>(
            data: UserTaskResponse.fromJson(jasonData));
      }
      if (data.statusCode == 401) {
        return APIResponse<UserTaskResponse>(
            error: true, errorMessage: jasonData['message']);
      }

      return APIResponse<UserTaskResponse>(
          error: true, errorMessage: 'Something went wrong');
    }).catchError((error) {
      return APIResponse<UserTaskResponse>(
          error: true, errorMessage: 'Something went wrong');
    });
  }

  Future<APIResponse<LgcResponse>> getBuyLgc(lgc, token) async {
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': token,
    };
    return http
        .post(Uri.parse(baseUrl + buyLgc),
            headers: headers, body: json.encode({"lgc": lgc}))
        .then((data) {
      final jasonData = json.decode(data.body);

      if (data.statusCode == 200) {
        return APIResponse<LgcResponse>(data: LgcResponse.fromJson(jasonData));
      }
      if (data.statusCode == 401) {
        return APIResponse<LgcResponse>(
            error: true, errorMessage: jasonData['message']);
      }

      return APIResponse<LgcResponse>(
          error: true, errorMessage: 'Something went wrong');
    }).catchError((error) {
      return APIResponse<LgcResponse>(
          error: true, errorMessage: 'Something went wrong');
    });
  }

  Future<APIResponse<UserDetailResponse>> getUserDetail(token) async {
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': token,
    };
    return http
        .post(Uri.parse(baseUrl + userDetail), headers: headers)
        .timeout(const Duration(seconds: 10))
        .then((data) {
      final jasonData = json.decode(data.body);

      if (data.statusCode == 200) {
        return APIResponse<UserDetailResponse>(
            data: UserDetailResponse.fromJson(jasonData));
      }
      if (data.statusCode == 401) {
        return APIResponse<UserDetailResponse>(
            error: true, errorMessage: jasonData['message']);
      }

      if (data.statusCode == 500) {
        return APIResponse<UserDetailResponse>(
            error: true, errorMessage: jasonData['message']);
      }

      return APIResponse<UserDetailResponse>(
          error: true, errorMessage: 'Something went wrong');
    }).catchError((error) {
      return APIResponse<UserDetailResponse>(
          error: true, errorMessage: 'Something went wrong');
    });
  }

  Future<APIResponse<MineResponse>> doMine(token) async {
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': token,
    };
    return http
        .post(Uri.parse(baseUrl + setMine), headers: headers)
        .then((data) {
      final jasonData = json.decode(data.body);

      if (data.statusCode == 200) {
        return APIResponse<MineResponse>(
            data: MineResponse.fromJson(jasonData));
      }
      if (data.statusCode == 401) {
        return APIResponse<MineResponse>(
            error: true, errorMessage: jasonData['message']);
      }

      return APIResponse<MineResponse>(
          error: true, errorMessage: 'Something went wrong');
    }).catchError((error) {
      return APIResponse<MineResponse>(
          error: true, errorMessage: 'Something went wrong');
    });
  }

  Future<APIResponse<WithdrawalViewResponse>> viewWithdrawalDetails(
      token) async {
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': token,
    };
    return http
        .post(Uri.parse(baseUrl + viewWithdrawal), headers: headers)
        .then((data) {
      final jasonData = json.decode(data.body);

      if (data.statusCode == 200) {
        return APIResponse<WithdrawalViewResponse>(
            data: WithdrawalViewResponse.fromJson(jasonData));
      }
      if (data.statusCode == 401) {
        return APIResponse<WithdrawalViewResponse>(
            error: true, errorMessage: jasonData['message']);
      }

      return APIResponse<WithdrawalViewResponse>(
          error: true, errorMessage: 'Something went wrong');
    }).catchError((error) {
      return APIResponse<WithdrawalViewResponse>(
          error: true, errorMessage: 'Something went wrong');
    });
  }

  Future<APIResponse<DepositViewResponse>> viewDepositDetails(token) async {
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': token,
    };
    return http
        .post(Uri.parse(baseUrl + viewDeposit), headers: headers)
        .then((data) {
      final jasonData = json.decode(data.body);

      if (data.statusCode == 200) {
        return APIResponse<DepositViewResponse>(
            data: DepositViewResponse.fromJson(jasonData));
      }
      if (data.statusCode == 401) {
        return APIResponse<DepositViewResponse>(
            error: true, errorMessage: jasonData['message']);
      }

      return APIResponse<DepositViewResponse>(
          error: true, errorMessage: 'Something went wrong');
    }).catchError((error) {
      return APIResponse<DepositViewResponse>(
          error: true, errorMessage: 'Something went wrong');
    });
  }
}
