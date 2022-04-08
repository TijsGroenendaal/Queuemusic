import 'package:flutter/widgets.dart';

class Session with ChangeNotifier implements Exception {
  String error() => "Not In Session";

  late String _sessionCode;
  late String _hostUser;
  bool inSession = false;

  String get sessionCode {
    if (inSession) return _sessionCode;
    throw error();
  }

  set sessionCode(String sessionCode) {
    _sessionCode = sessionCode;
  }

  String get hostUser {
    if (inSession) return _hostUser;
    throw error();
  }

  set hostUser(String hostUser) {
    _hostUser = hostUser;
  }

  void joinSession(String hostUser, String sessionCode) {
    this.hostUser = hostUser;
    this.sessionCode = sessionCode;
    inSession = true;

    notifyListeners();
  }

  void leaveSession() {
    inSession = false;

    notifyListeners();
  }
}
