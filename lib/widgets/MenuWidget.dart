import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:queuemusic/common/QueueMusicColor.dart';
import 'package:queuemusic/common/QueueMusicTheme.dart';

class MenuWidget extends StatefulWidget {
  const MenuWidget({Key? key}) : super(key: key);

  @override
  _MenuWidgetState createState() => _MenuWidgetState();
}

class _MenuWidgetState extends State<MenuWidget> {
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: theme(),
      child: Scaffold(
        appBar: AppBar(
          title: Text("Home"),
        ),
        body: Center(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ListTile(
                  title: Text("Host Session"),
                  trailing: IconButton(
                    onPressed: () {},
                    icon: Icon(CupertinoIcons.arrow_right),
                    color: QueueMusicColor.green,
                    iconSize: 40,
                  ),
                ),
                ListTile(
                  title: Text("Join Session"),
                  trailing: IconButton(
                    onPressed: () {},
                    icon: Icon(CupertinoIcons.arrow_right),
                    color: QueueMusicColor.green,
                    iconSize: 40,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
