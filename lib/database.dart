import 'package:flutter/material.dart';
import 'package:habitica_assistant/migrations/migration_scripts.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseClient {
  static final DatabaseClient instance = DatabaseClient._internal();
  Database? _database;

  DatabaseClient._internal();

  Future<Database> get database async {
    _database ??= await _initDB();
    return _database as Database;
  }

  Future<Database> _initDB() async {
    WidgetsFlutterBinding.ensureInitialized();
    return openDatabase(
      join(await getDatabasesPath(), 'habitica_assistant_database.db'),
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
      onDowngrade: _onDowngrade,
      version: 2,
    );
  }

  void _onCreate(Database db, int version) async {
    for (int i = 1; i <= migrationScripts.length; ++i) {
      if (migrationScripts[i] != null && migrationScripts[i]!.up.isNotEmpty) {
        await db.execute(migrationScripts[i]!.up);
      }
    }
  }

  void _onUpgrade(Database db, int oldVersion, int newVersion) async {
    for (int i = oldVersion + 1; i <= newVersion; ++i) {
      if (migrationScripts[i] != null && migrationScripts[i]!.up.isNotEmpty) {
        await db.execute(migrationScripts[i]!.up);
      }
    }
  }

  void _onDowngrade(Database db, int oldVersion, int newVersion) async {
    for (int i = oldVersion; i >= newVersion; --i) {
      if (migrationScripts[i] != null && migrationScripts[i]!.down.isNotEmpty) {
        await db.execute(migrationScripts[i]!.down);
      }
    }
  }
}
