import 'dart:io';

import 'package:pain_tracker/PainModel.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBProvider {
  DBProvider._();
  static final DBProvider db = DBProvider._();

  static Database _database;

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "PainDB2.db");
    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute("CREATE TABLE pain ("
          "id INTEGER PRIMARY KEY AUTOINCREMENT,"
          "pain_level INTEGER,"
          "pain_location INTEGER,"
          "pain_side INTEGER,"
          "x REAL,"
          "y REAL,"
          "dt INTEGER"
          ")");
    });
  }

  getAllPains() async {
    final db = await database;
    var res = await db.query("pain");
    List<Pain> list =
        res.isNotEmpty ? res.map((c) => Pain.fromJson(c)).toList() : [];
    return list;
  }

  newPain(Pain newPain) async {
    final db = await database;
    var res = await db.insert("pain", newPain.toJson());
    return res;
  }

  removeLastPain() async {
    final db = await database;
    var res = await db.rawDelete("delete from pain order by dt desc limit 1");
    return res;
  }

  Future<Database> get database async {
    if (_database != null) return _database;

    // if _database is null we instantiate it
    _database = await initDB();
    return _database;
  }
}
