import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../models/Session.dart';

class DashboardScreen extends StatefulWidget {
  static const route = "Dashboard";

  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardState();
}

class _DashboardState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<Session>(
      builder: (context, session, child) {
        if (session.inSession) {
          // TODO SessionScreen
          throw UnimplementedError();
        } else {
          // TODO LikedSongsPlaylist
          throw UnimplementedError();
        }
      },
    );
  }
}
