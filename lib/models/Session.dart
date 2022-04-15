import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:queuemusic/helper/IdHelper.dart';
import 'package:uuid/uuid.dart';

class Session with ChangeNotifier implements Exception {
  String error() => "Not In Session";

  late String _sessionCode;
  late String _hostUser;
  late bool isHost;
  bool _inSession = false;
  late String _userSessionId;

  String get userSessionId => _userSessionId;

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
    isHost = (hostUser == FirebaseAuth.instance.currentUser?.uid);
    _inSession = true;
    IdHelper.getDeviceId().then((value) => _userSessionId = value!);

    notifyListeners();
  }

  void leaveSession() {
    _inSession = false;

    notifyListeners();
  }

  void closeSession() async {
    await FirebaseFirestore.instance.collection("sessions").doc(sessionCode).update({
      "open": false
    });
    await FirebaseAuth.instance.signOut();
    leaveSession();
  }
}
