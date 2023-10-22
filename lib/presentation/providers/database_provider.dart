import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:surf_together/data/models/dao/places_dao.dart';

class DatabaseProvider extends ChangeNotifier {
  DatabaseProvider();
  static final _instance = DatabaseProvider._internal();
  static DatabaseProvider staticDataBase = _instance;
  bool isInitialized = false;
  late Database _db;


  DatabaseProvider._internal();

  Future<Database> db() async {
    if (!isInitialized) await _init();
    return _db;
  }

  Future _init() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, "surf_together.db");

    _db = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute(PlacesDao().createTableQuery);
    });
  }
}
