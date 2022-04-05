import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:queuemusic/common/QueueMusicColor.dart';
import 'package:queuemusic/common/QueueMusicTheme.dart';
import '../widgets/LikedSongsWidget.dart';

class DashboardScreen extends StatefulWidget {
  static const route = "Dashboard";

  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardState();
}

class _DashboardState extends State<DashboardScreen> {
  int _selectedIndex = 0;
  static const List<Widget> _widgetOptions = <Widget>[
    Center(child: Text("DASHBOARD")),
    LikedSongsWidget(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
        data: theme(),
        child: Scaffold(
          body: _widgetOptions[_selectedIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: _selectedIndex,
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.house_fill),
                label: "Dashboard"
              ),
              BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.heart_fill),
                label: 'LikedSongs'
              )
            ],
            selectedItemColor: QueueMusicColor.green,
            selectedIconTheme: IconThemeData(color: QueueMusicColor.green750),
            unselectedItemColor: QueueMusicColor.grey,
            unselectedIconTheme: IconThemeData(color: QueueMusicColor.grey),
            selectedFontSize: 12,
            backgroundColor: QueueMusicColor.black750,
            onTap: _onItemTapped,
          ),
        )
    );
  }
}
