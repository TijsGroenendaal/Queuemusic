import 'package:queuemusic/helper/StorageSolution.dart';
import 'package:sqflite/sqflite.dart';

import '../models/Song.dart';

class SqfliteHelper implements StorageSolution {

  final Database _db;

  SqfliteHelper(this._db);

  @override
  List<Song> loadSongs() {
    List<Song> toReturn = [];
    _db.query('likedsongs', limit: 50).then((value) => value.forEach((element) {
      toReturn.add(Song(
          element["album"].toString(),
          element["songName"].toString(),
          element["authors"].toString(),
          element["id"].toString()
      ));
    }));
    return toReturn;
  }

  @override
  void deleteSong(String id) {
    _db.delete('likedsongs', where: 'id = ?', whereArgs: [id]);
  }

  @override
  void addSong(Song song) {
    _db.insert('likedsongs', song.toMap());
  }
}