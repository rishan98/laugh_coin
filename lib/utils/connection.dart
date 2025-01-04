import 'package:connectivity_plus/connectivity_plus.dart';

class Connection {
  Future<bool> check() async {
    List<ConnectivityResult> result = await Connectivity().checkConnectivity();
    if (result == ConnectivityResult.none) {
      return false;
    } 
    return true;
  }
}