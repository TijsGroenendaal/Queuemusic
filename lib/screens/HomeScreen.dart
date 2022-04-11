import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:queuemusic/widgets/MenuWidget.dart';
import 'package:queuemusic/widgets/SessionWidget.dart';

import '../models/Session.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<Session>(
        builder: (context, session, child) {
          if (session.inSession) {
            return const SessionWidget();
          } else {
            return const MenuWidget();
          }
        }
    );
  }
}
