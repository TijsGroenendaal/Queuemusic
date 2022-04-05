import 'package:flutter/material.dart';
import 'package:queuemusic/common/QueueMusicColor.dart';
import 'package:queuemusic/common/QueueMusicTheme.dart';
import 'package:queuemusic/helper/DataHelper.dart';
import 'package:queuemusic/widgets/AddSongWidget.dart';

import '../models/Song.dart';

class LikedSongsWidget extends StatefulWidget {
  const LikedSongsWidget({Key? key}) : super(key: key);

  @override
  _LikedSongsWidgetState createState() => _LikedSongsWidgetState();
}

class _LikedSongsWidgetState extends State<LikedSongsWidget> {

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: theme(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Liked Songs"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            constraints: const BoxConstraints(
              maxWidth: 600
            ),
            child: FutureBuilder<List<Widget>>(
              future: _buildSongList(),
              builder: (BuildContext context, AsyncSnapshot<List<Widget>> snapshot) {
                if (snapshot.hasError) {
                  return ListView(
                    children: [_buildStorageNotAvailableTile()],
                  );
                }
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.data!.isEmpty) {
                    return _buildNoSongFoundTile();
                  }
                  return ListView(
                    children: snapshot.data!,
                  );
                }

                return ListView(
                  children: [_buildStorageNotAvailableTile()],
                );
              },
            ),
          ),
        ),
        floatingActionButton: DataHelper.db == null ? null : FloatingActionButton.extended(
          onPressed: () => _addSong(context),
          label: const Text("ADD"),
          icon: const Icon(Icons.add),
        ),
      ),
    );
  }
  Future<List<Widget>> _buildSongList() async {
    List<Widget> containers = [];
    if (DataHelper.db == null) return [_buildStorageNotAvailableTile()];
    List<Song>? playlist = await DataHelper.db?.loadSongs();
    if (playlist == null) return [_buildNoSongFoundTile()];
    if (playlist.isEmpty) return [_buildNoSongFoundTile()];

    for (Song song in playlist) {
      print(song);
      containers.add(_buildSongTile(song));
    }
    return containers;
  }

  ListTile _buildSongTile(Song song) {
    return ListTile(
      title: Text("${song.songname}, ${song.album}"),
      subtitle: Text(song.authors, style: TextStyle(color: QueueMusicColor.grey),),
      trailing: IconButton(
        onPressed: () {
          DataHelper.db?.deleteSong(song.id);
        },
        icon: const Icon(Icons.delete),
        iconSize: 25,
        color: QueueMusicColor.error,
      ),
    );
  }

  ListTile _buildNoSongFoundTile() {
    return ListTile(
      title: const Text("No Song Found"),
      subtitle: Text("Add a Song", style: theme().textTheme.bodyText2,),
      trailing: IconButton(
        icon: Icon(Icons.add, color: theme().iconTheme.color,),
        onPressed: () => _addSong(context),
      ),
    );
  }

  ListTile _buildStorageNotAvailableTile() {
    return const ListTile(
      title: Text("Storage not available"),
    );
  }

  void _addSong(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(
        builder: (context) => AddSongWidget(callback: callback,))
    );
  }

  void callback() {
    setState(() {});
  }
}
