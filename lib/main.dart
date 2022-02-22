import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:queuemusic/common/QueueMusicColor.dart';
import 'package:queuemusic/helper/DatabaseHelper.dart';
import 'package:queuemusic/screens/DashboardScreen.dart';
import 'package:queuemusic/screens/SplashScreen.dart';

void main() {
  _initialize().whenComplete(() => runApp(const MyApp()));
}

Future<void> _initialize() async {
  await Firebase.initializeApp();
  await DatabaseHelper.initialize();
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'QueueMusic',
      theme: ThemeData(
        textTheme: const TextTheme(
          bodyText1: TextStyle(
            color: QueueMusicColor.white,
          ),
          subtitle1: TextStyle(
            color: QueueMusicColor.grey,
          )
        ),
        scaffoldBackgroundColor: QueueMusicColor.black,
        appBarTheme: const AppBarTheme(
          titleTextStyle: TextStyle(
            color: QueueMusicColor.white,
          ),
          backgroundColor: QueueMusicColor.black600,
        ),
        backgroundColor: QueueMusicColor.black,
      ),
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
        "/":                    (_) => const SplashScreen(),
      },
      initialRoute: "/",
    );
  }
}
