import 'package:flutter/material.dart';
import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart';

Map<int, String> script = {
  1: ''' CREATE TABLE pessoa (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          nome TEXT,
          peso REAL,
          altura REAL,
          );'''
};

class DatabaseSQlite {
  static Database? db;

  Future<Database> obterDataBase() async {
    if (db == null) {
      return await iniciarBancoDeDados();
    } else {
      return db!;
    }
  }

  Future<Database> iniciarBancoDeDados() async {
    var db = await openDatabase(
        path.join(await getDatabasesPath(), 'database.db'),
        version: script.length, onCreate: (Database db, int version) async {
      for (var i = 1; i <= script.length; i++) {
        await db.execute(script[i]!);
        debugPrint(script[i]!);
      }
    }, onUpgrade: (Database db, int oldVersion, int newVersion) async {
      for (var i = oldVersion + 1; i <= script.length; i++) {
        await db.execute(script[i]!);
        debugPrint(script[i]!);
      }
    });
    return db;
  }
}
