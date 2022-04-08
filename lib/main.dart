import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:queuemusic/common/QueueMusicTheme.dart';
import 'package:queuemusic/models/Session.dart';
import 'package:queuemusic/screens/DashboardScreen.dart';
import 'package:queuemusic/screens/SplashScreen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(ChangeNotifierProvider(
      create: (context) => Session(),
      child: const QueueMusicPage(title: 'QueueMusic',),
  ));
}

class QueueMusicPage extends StatefulWidget {
  const QueueMusicPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<QueueMusicPage> createState() => _QueueMusicPageState();
}

class _QueueMusicPageState extends State<QueueMusicPage> {

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: theme(),
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
