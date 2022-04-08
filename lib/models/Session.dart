import 'package:flutter/widgets.dart';

class Session with ChangeNotifier implements Exception {
  String error() => "Not In Session";

  late String _sessionCode;
  late String _hostUser;
  bool _inSession = false;

  bool get inSession => _inSession;

  String get sessionCode {
    if (_inSession) return _sessionCode;
    throw error();
  }

  set sessionCode(String sessionCode) {
    _sessionCode = sessionCode;
  }

  String get hostUser {
    if (_inSession) return _hostUser;
    throw error();
  }

  set hostUser(String hostUser) {
    _hostUser = hostUser;
  }

  void joinSession(String hostUser, String sessionCode) {
    this.hostUser = hostUser;
    this.sessionCode = sessionCode;
    _inSession = true;

    notifyListeners();
  }

  void leaveSession() {
    _inSession = false;

    notifyListeners();
  }
}
