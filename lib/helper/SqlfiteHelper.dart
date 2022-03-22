import 'package:queuemusic/helper/StorageSolution.dart';
import 'package:sqflite/sqflite.dart';

import '../models/Song.dart';

class SqfliteHelper implements StorageSolution {

  Database _db;

  SqfliteHelper(this._db);

  @override
  List<Song> loadSongs() {
    List<Song> toReturn = [];
    _db.query('likedsongs', limit: 50).then((value) => value.forEach((element) {
      toReturn.add(Song(
          element["songId"].toString(),
          element["songName"].toString(),
          element["authors"].toString(),
          element["identifier"].toString()
      ));
    }));
    return toReturn;
  }

  @override
  void deleteSong(String songId) {
    _db.delete('likedsongs', where: 'songId = ?', whereArgs: [songId]);
  }
}