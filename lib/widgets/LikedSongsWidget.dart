import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:queuemusic/common/QueueMusicColor.dart';
import 'package:queuemusic/common/QueueMusicTheme.dart';
import 'package:queuemusic/helper/DataHelper.dart';
import 'package:queuemusic/helper/SnackbarHelper.dart';
import 'package:queuemusic/models/SessionSong.dart';
import 'package:queuemusic/widgets/AddSongWidget.dart';

import '../models/Session.dart';
import '../models/Song.dart';

class LikedSongsWidget extends StatefulWidget {
  const LikedSongsWidget({Key? key}) : super(key: key);

  @override
  _LikedSongsWidgetState createState() => _LikedSongsWidgetState();
}

class _LikedSongsWidgetState extends State<LikedSongsWidget> {

  late Session session;

  @override
  void initState() {
    session = Provider.of<Session>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: theme(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Liked Songs"),
        ),
        body: Container(
          padding: EdgeInsets.all(20),
          child: FutureBuilder<List<Song>>(
            future: _getSongs(),
            builder: (BuildContext context, AsyncSnapshot<List<Song>> snapshot) {
              if (snapshot.hasError) {
                return ListView(
                  children: [_buildStorageNotAvailableTile()],
                );
              }
              if (snapshot.connectionState == ConnectionState.done && snapshot.hasData) {
                if (snapshot.data!.isEmpty) {
                  return _buildNoSongFoundTile();
                }
                return ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: snapshot.data!.length,
                  separatorBuilder: (BuildContext context, int index) => const Divider(),
                  itemBuilder: (context, index) {
                    return _buildSongTile(snapshot.data![index]);
                  }
                );
              }

              return ListView(
                children: [_buildStorageNotAvailableTile()],
              );
            },
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

  Future<List<Song>> _getSongs() async {
    return DataHelper.db!.loadSongs();
  }

  ListTile _buildSongTile(Song song) {
    return ListTile(
      title: Text("${song.songname}, ${song.album}"),
      subtitle: Text(song.authors, style: TextStyle(color: QueueMusicColor.grey),),
      trailing: Builder(
        builder: (context) {
          List<Widget> trailing = [
            IconButton(
              onPressed: () {
                DataHelper.db!.deleteSong(song.id);
                setState(() {});
              },
              icon: const Icon(Icons.delete),
              iconSize: 25,
              color: QueueMusicColor.error,
            )
          ];
          if (session.inSession && !session.isHost) {
            trailing.add(IconButton(
                onPressed: () async {
                  CollectionReference collectionReference = FirebaseFirestore.instance.collection("sessions").doc(session.sessionCode).collection("songs");
                  QuerySnapshot snapshot = await collectionReference
                      .where("authors", isEqualTo: song.authors)
                      .where("songName", isEqualTo: song.songname).get();
                  if (snapshot.size >= 1) {
                    SnackbarHelper.deploy(const Text("Song is already in Queue"), context);
                  } else {
                    await collectionReference.add(
                        SessionSong(song.songname, song.authors, song.album, session.userSessionId).toMap()
                    ).catchError((error) {
                      print(error.toString());
                      SnackbarHelper.deploy(const Text("Could not add Song to the Queue"), context);
                    });
                    SnackbarHelper.deploy(const Text("Song added"), context);
                  }
                },
                icon: const Icon(Icons.queue),
                color: QueueMusicColor.green
            ),
            );
          }
          return Row(
            mainAxisSize: MainAxisSize.min,
            children: trailing,
          );
        },
      )
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
