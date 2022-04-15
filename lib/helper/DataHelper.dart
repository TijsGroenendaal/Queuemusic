import 'dart:io' show Directory;

import 'package:path/path.dart' as paths;
import 'package:path_provider/path_provider.dart';
import 'package:queuemusic/helper/SqlfiteHelper.dart';
import 'package:queuemusic/helper/StorageSolution.dart';
import 'package:sqflite/sqflite.dart';

import 'Cache.dart';

class DataHelper {

  static late StorageSolution? db;
  static late Cache cache;

  static Future<void> initialize() async {
    await _initializeDatabase();
    cache = Cache();
  }

  static Future<void> _initializeDatabase() async {
    Directory defPath = await getApplicationDocumentsDirectory();
    String databasePath = paths.join(defPath.path, 'queuemusic.db');

    // deleteDatabase(databasePath);

    db = SqfliteHelper(await openDatabase(
        databasePath,
        version: 1,
        // will only execute if no database with the name `queuemusic.db` is found.
        onCreate: _buildDatabase
    ));
  }

  static void _buildDatabase(Database db, int version) async {
    Batch batch = db.batch();
    batch.execute("CREATE TABLE likedsongs (id VARCHAR, songname VARCHAR, album VARCHAR, authors VARCHAR);");
    // might add new tables in the future
    await batch.commit(noResult: true);
  }
}
