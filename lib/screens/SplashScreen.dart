import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:queuemusic/common/QueueMusicColor.dart';
import 'package:queuemusic/common/QueueMusicTheme.dart';
import 'package:queuemusic/screens/DashboardScreen.dart';

import '../helper/DataHelper.dart';

class SplashScreen extends StatelessWidget {
  static const route = "Splash";

  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    _resolveDestination(context, DashboardScreen.route);
    return Theme(
      data: theme(),
      child: const Scaffold(
        body: Center(
          child: SizedBox(
            child: CircularProgressIndicator(
              color: QueueMusicColor.green750,
              strokeWidth: 10,
            ),
            height: 100,
            width: 100,
          ),
        ),
      ),
    );
  }

  Future<void> _resolveDestination(BuildContext buildcontext, String destination) async {
    await _initialize();
    Navigator.pushReplacementNamed(buildcontext, destination);
  }

  Future<void> _initialize() async {
    await Firebase.initializeApp();
    await DataHelper.initialize();
  }
}
