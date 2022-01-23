import 'package:flutter/material.dart';
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
      onCreate: (db, version) async {
        Batch batch = db.batch();
        batch.execute('''CREATE TABLE equipment_battle_gear(
           id INTEGER PRIMARY KEY AUTOINCREMENT
          ,name TEXT NOT NULL
          ,sequence INTEGER(4) NOT NULL
          ,armor TEXT
          ,head TEXT
          ,shield TEXT
          ,weapon TEXT
          ,eyewear TEXT
          ,head_accessory TEXT
          ,body TEXT
          ,back TEXT
          ,created_at INTEGER(4) NOT NULL DEFAULT (strftime('%s','now'))
          ,updated_at INTEGER(4) NOT NULL DEFAULT (strftime('%s','now'))
          ,deleted INTEGER NOT NULL
        )''');
        batch.execute('''CREATE TABLE equipment_costumes(
           id INTEGER PRIMARY KEY AUTOINCREMENT
          ,name TEXT NOT NULL
          ,sequence INTEGER(4) NOT NULL
          ,armor TEXT
          ,head TEXT
          ,shield TEXT
          ,weapon TEXT
          ,eyewear TEXT
          ,head_accessory TEXT
          ,body TEXT
          ,back TEXT
          ,created_at INTEGER(4) NOT NULL DEFAULT (strftime('%s','now'))
          ,updated_at INTEGER(4) NOT NULL DEFAULT (strftime('%s','now'))
          ,deleted INTEGER NOT NULL
        )''');
        batch
            .execute('CREATE INDEX idx_equipment_battle_gear_name ON equipment_battle_gear (name)');
        batch.execute(
            'CREATE INDEX idx_equipment_battle_gear_sequence ON equipment_battle_gear (sequence)');
        batch.execute(
            'CREATE INDEX idx_equipment_battle_gear_created_at ON equipment_battle_gear (created_at)');
        batch.execute(
            'CREATE INDEX idx_equipment_battle_gear_deleted ON equipment_battle_gear (deleted)');
        batch.execute('CREATE INDEX idx_equipment_costume_name ON equipment_costumes (name)');
        batch.execute(
            'CREATE INDEX idx_equipment_costume_sequence ON equipment_costumes (sequence)');
        batch.execute(
            'CREATE INDEX idx_equipment_costume_created_at ON equipment_costumes (created_at)');
        batch.execute('CREATE INDEX idx_equipment_costume_deleted ON equipment_costumes (deleted)');
        await batch.commit();
      },
      version: 1,
    );
  }
}
