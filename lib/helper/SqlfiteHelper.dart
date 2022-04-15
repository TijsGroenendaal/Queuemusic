import 'package:queuemusic/helper/StorageSolution.dart';
import 'package:sqflite/sqflite.dart';

import '../models/Song.dart';

class SqfliteHelper implements StorageSolution {

  final Database _db;

  SqfliteHelper(this._db);

  @override
  Future<List<Song>> getSongs() async {
    List<Song> toReturn = [];
    await _db.rawQuery("SELECT * FROM likedsongs;").then((value) => value.forEach((element) {
      toReturn.add(Song(
          element["album"].toString(),
          element["songname"].toString(),
          element["authors"].toString(),
          element["id"].toString()
      ));
    }));
    return toReturn;
  }

  @override
  Future<void> deleteSong(String id) async {
    await _db.delete('likedsongs', where: 'id = ?', whereArgs: [id]);
  }

  @override
  Future<void> addSong(Song song) async {
    await _db.rawInsert("INSERT INTO likedsongs (id, songname, album, authors) VALUES ('${song.id}', '${song.songname}', '${song.album}', '${song.authors}');");
  }
}