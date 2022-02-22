import 'package:flutter/material.dart';
import 'package:queuemusic/common/QueueMusicColor.dart';
import 'package:queuemusic/screens/DashboardScreen.dart';

class SplashScreen extends StatelessWidget {
  static const route = "Splash";

  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    _resolveDestination(context, DashboardScreen.route);
    return const Scaffold(
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
    );
  }

  Future<void> _resolveDestination(BuildContext context, String destination) async {
    await Future.delayed(const Duration(seconds: 2));

    Navigator.pushReplacementNamed(context, destination);
  }

}