import 'package:flutter/material.dart';
import 'package:queuemusic/common/QueueMusicTheme.dart';
import 'package:queuemusic/screens/DashboardScreen.dart';
import 'package:queuemusic/screens/SplashScreen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'QueueMusic',
      theme: theme(),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: widget.title,
      routes: {
        DashboardScreen.route:  (_) => const DashboardScreen(),
        SplashScreen.route:     (_) => const SplashScreen(),
        '/':                    (_) => const SplashScreen(),
      },
      initialRoute: "/",
    );
  }
}
