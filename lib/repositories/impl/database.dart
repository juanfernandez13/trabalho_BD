import 'package:flutter/material.dart';
import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart';

Map<int, String> scripts = {
  1: '''CREATE TABLE tarefa (
    idTarefa INTEGER PRIMARY KEY AUTOINCREMENT,
    descricao TEXT NOT NULL,
    concluida INTEGER NOT NULL,
    idUsuario INTEGER NOT NULL,
    FOREIGN KEY (idUsuario) REFERENCES usuario(idUsuario)
  );
''',
  2: '''
  CREATE TABLE usuario (
    idUsuario INTEGER PRIMARY KEY AUTOINCREMENT,
    nome TEXT NOT NULL,
    cpf TEXT NOT NULL,
    email TEXT NOT NULL
  );
''',
};

class SqliteDatabase {
  static Database? db;
  Future<Database> obterDatabase() async {
    if (db == null) {
      return await initDB();
    } else {
      return db!;
    }
  }
}

Future initDB() async {
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
