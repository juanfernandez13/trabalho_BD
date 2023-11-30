import 'package:flutter/material.dart';
import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart';

Map<int, String> scripts = {
  1: '''CREATE TABLE task (
    idTask INTEGER PRIMARY KEY AUTOINCREMENT,
    description TEXT NOT NULL,
    isCompleted INTEGER NOT NULL,
    idUser INTEGER NOT NULL,
    FOREIGN KEY (idUser) REFERENCES user(idUser)
  );
''',
  2: '''
  CREATE TABLE user (
    idUser INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL,
    age INTEGER NOT NULL,
    cpf TEXT NOT NULL,
    email TEXT NOT NULL
  );
''',
};

class SqliteDatabase {
  static Database? db;
  Future<Database> getDatabase() async {
    if (db == null) {
      return await initDB();
    } else {
      return db!;
    }
  }
}

Future initDB() async {
  //deleteDatabase(path.join(await getDatabasesPath(),'database.db'));
  var db = openDatabase(path.join(await getDatabasesPath(), 'database.db'),
      version: scripts.length, onCreate: (Database db, int index) async {
    for (var i = 1; i <= scripts.length; i++) {
      await db.execute(scripts[i]!);
      debugPrint(scripts[i]);
    }
  }, onUpgrade: (Database db, int oldVersion, int newVesion) async {
    for (var i = oldVersion + 1; i <= scripts.length; i++) {
      await db.execute(scripts[i]!);
      debugPrint(scripts[i]);
    }
  });
  return db;
}
