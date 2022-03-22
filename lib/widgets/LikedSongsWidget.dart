import 'package:flutter/material.dart';
import 'package:queuemusic/common/QueueMusicColor.dart';
import 'package:queuemusic/helper/DataHelper.dart';

import '../models/Song.dart';

class LikedSongsWidget extends StatelessWidget {
  const LikedSongsWidget ({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Liked Songs"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Container(
            constraints: const BoxConstraints(
              maxWidth: 600
            ),
            child: ListView(
              scrollDirection: Axis.vertical,
              children: _buildSongList(),
            ),
          ),
        ),
      ),
      floatingActionButton: DataHelper.db == null ? null : FloatingActionButton.extended(
          onPressed: _addSong,
          label: const Text("ADD"),
          icon: const Icon(Icons.add, color: QueueMusicColor.green750,),
      ),
    );
  }

  List<Widget> _buildSongList() {
    List<Widget> containers = [];
    if (DataHelper.db == null) return [_buildStorageNotAvailableTile()];
    List<Song>? playlist = DataHelper.db?.loadSongs();
    if (playlist == null) return [_buildNoSongFoundTile()];
    if (playlist.isEmpty) return [_buildNoSongFoundTile()];

    for (Song song in playlist) {
      containers.add(_buildSongTile(song));
      containers.add(const Divider(thickness: 2, color: QueueMusicColor.black500));
    }
    return containers;
  }

  ListTile _buildSongTile(Song song) {
    return ListTile(
      shape: RoundedRectangleBorder(side:  const BorderSide(color: QueueMusicColor.grey, width: 1), borderRadius: BorderRadius.circular(5)),
      title: Text(song.songName),
      subtitle: Text(song.authors),
      trailing: IconButton(
        onPressed: () {
          // TODO remove song
        },
        icon: const Icon(Icons.delete),
        iconSize: 25,
        color: QueueMusicColor.error,
      ),
    );
  }

  ListTile _buildNoSongFoundTile() {
    return ListTile(
      shape: RoundedRectangleBorder(side:  const BorderSide(color: QueueMusicColor.grey, width: 1), borderRadius: BorderRadius.circular(5)),
      title: const Text("No Song Found"),
      subtitle: const Text("Add a Song"),
      onTap: _addSong,
    );
  }

  ListTile _buildStorageNotAvailableTile() {
    return ListTile(
      shape: RoundedRectangleBorder(side:  const BorderSide(color: QueueMusicColor.grey, width: 1), borderRadius: BorderRadius.circular(5)),
      title: const Text("Storage not available"),
    );
  }

  void _addSong() {
    // TODO add song
  }
}
