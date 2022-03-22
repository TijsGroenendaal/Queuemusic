import 'dart:io' show Directory;

import 'package:path_provider/path_provider.dart';
import 'package:queuemusic/helper/SqlfiteHelper.dart';
import 'package:queuemusic/helper/StorageSolution.dart';
import 'package:path/path.dart' as paths;
import 'package:sqflite/sqflite.dart';

class DataHelper {

  static StorageSolution? db;

  static Future<void> initialize() async {
    _initializeDatabase();
  }


  static void _initializeDatabase() async {
    Directory defPath = await getApplicationDocumentsDirectory();
    String databasePath = paths.join(defPath.path, 'queuemusic.db');

    db = SqfliteHelper(await openDatabase(
        databasePath,
        version: 1,
        // will only execute of no database with the name `queuemusic.db` is found.
        onCreate: _buildDatabase
    ));
  }

  static void _buildDatabase(Database db, int version) async {
    Batch batch = db.batch();
    batch.execute("CREATE TABLE likedsongs (identifier VARCHAR, songname VARCHAR, songId VARCHAR, authors VARCHAR);");
    // might add new tables in the future
    await batch.commit(noResult: true);
  }
}
