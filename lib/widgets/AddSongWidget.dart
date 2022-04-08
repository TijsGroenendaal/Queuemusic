import 'package:flutter/material.dart';
import 'package:queuemusic/common/QueueMusicTheme.dart';
import 'package:queuemusic/helper/DataHelper.dart';
import 'package:queuemusic/helper/SnackbarHelper.dart';
import 'package:queuemusic/models/Song.dart';
import 'package:queuemusic/widgets/TextFieldWidget.dart';
import 'package:uuid/uuid.dart';

import '../common/QueueMusicColor.dart';

class AddSongWidget extends StatelessWidget {
  AddSongWidget({Key? key, required this.callback}) : super(key: key);

  final Function() callback;

  final TextEditingController songNameController = TextEditingController();
  final TextEditingController authorController = TextEditingController();
  final TextEditingController albumController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: theme(),
      child: Scaffold(
        appBar: AppBar(title: Text("Add a Song to LikedSongs"),),
        body: SingleChildScrollView(
          child: Center(
            child: Container(
              margin: const EdgeInsets.all(20),
              constraints: const BoxConstraints(
                maxWidth: 300
              ),
              child: Column(
                children: [
                  TextFieldWidget(songNameController, "Song name", 64, BoolWrapper(true)),
                  TextFieldWidget(authorController, "Author('s)", 64, BoolWrapper(true)),
                  TextFieldWidget(albumController, "Album, optional", 64, BoolWrapper(true)),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(QueueMusicColor.green),
                      ),
                      onPressed: () => _addSong(context),
                      icon: const Icon(Icons.add),
                      label: const Text("Add"),
                    ),
                  )
                ],
              ),
            ),
          ),
        )
      ),
    );
  }

  void _addSong(BuildContext context) {
    if (songNameController.value.text.isEmpty || authorController.value.text.isEmpty) {
      SnackbarHelper.deploy(const Text("Fill in all input field"), context);
    }

    DataHelper.db!.addSong(Song(
        albumController.value.text,
        songNameController.value.text,
        authorController.value.text,
        Uuid().v1()
    )).then((value) => {
        callback(),
        Navigator.pop(context)
    });
  }
}
