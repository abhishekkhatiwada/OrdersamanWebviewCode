import 'package:connectivity_plus/connectivity_plus.dart';

class InternetCheck {
  Future<bool> check() async {
    final ConnectivityResult connectivityResult =
        (await Connectivity().checkConnectivity()) as ConnectivityResult;
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      return true;
    }
    return false;
  }

  void checkInternet(Function func) {
    check().then((internet) {
      func(internet);
    });
  }
}
