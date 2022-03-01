import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as paths ;

class DatabaseHelper {
  static Database? db;

  static Future<void> initialize() async {
    Directory defPath = await getApplicationDocumentsDirectory();
    String databasePath = paths.join(defPath.path, 'queuemusic.db');

    db = await openDatabase(
        databasePath,
        version: 1,
        // will only execute of no database with the name `queuemusic.db` is found.
        onCreate: _buildDatabase
    );
  }

  static void _buildDatabase(Database db, int version) async {
    Batch batch = db.batch();
    batch.execute("CREATE TABLE likedsongs (identifier VARCHAR, songname VARCHAR, songId VARCHAR, authors VARCHAR");
    // might add new tables in the future
    await batch.commit(noResult: true);
  }
}
