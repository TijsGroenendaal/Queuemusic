import 'package:flutter/cupertino.dart';
import '../widgets/LikedSongsWidget.dart';

class DashboardScreen extends StatefulWidget {
  static const route = "Dashboard";

  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardState();
}

class _DashboardState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return const LikedSongsWidget();
  }
}
