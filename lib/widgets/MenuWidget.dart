import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:queuemusic/common/QueueMusicColor.dart';
import 'package:queuemusic/common/QueueMusicTheme.dart';
import 'package:queuemusic/widgets/TextFieldWidget.dart';
import 'package:uuid/uuid.dart';

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
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                SizedBox(height: 15,),
                ListTile(
                  title: Text("Host Session"),
                  trailing: IconButton(
                    onPressed: () => _host(),
                    icon: Icon(CupertinoIcons.arrow_right),
                    color: QueueMusicColor.green,
                    iconSize: 40,
                  ),
                ),
                SizedBox(height: 5,),
                ListTile(
                  title: Text("Join Session"),
                  trailing: IconButton(
                    onPressed: () => _join(),
                    icon: Icon(CupertinoIcons.arrow_right),
                    color: QueueMusicColor.green,
                    iconSize: 40,
                  ),
                ),
              ],
            ),
          ),
        )
      ),
    );
  }

  void _host() {

  }

  void _join() {

  }
}
