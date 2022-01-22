import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:habitica_assistant/database.dart';
import 'package:habitica_assistant/models/query.dart';
import 'package:sqflite/sqflite.dart';

const defaultColumnOrderBy = 'created_at';
final OrderBy defaultOrderBy = OrderBy(column: defaultColumnOrderBy);

/// Base entity with id and auditing properties.
abstract class BaseEntity {
  int? id;
  DateTime updatedAt = DateTime.now();
  DateTime createdAt = DateTime.now();
  bool deleted = false;
  BaseEntity(this.id, this.updatedAt, this.createdAt, this.deleted);
}

/// Base provider with basic CRUD operations for database tables.
abstract class BaseProvider<T extends BaseEntity> extends ChangeNotifier {
  /// Database client singleton.
  DatabaseClient databaseClient = DatabaseClient.db;

  /// Name of table to query/modify in database.
  abstract String table;

  T fromMap(Map<String, dynamic> map);
  Map<String, dynamic> toMap(T entity);

  /// Private list of entities.
  final List<T> _entities = [];

  /// List of entities accessible to other classes.
  UnmodifiableListView<T> get entities => UnmodifiableListView(_entities);

  /// Number of entities in table.
  int get entityCount => _entities.length;

  /// Retrieves all entities from table that aren't deleted.
  /// Notifies ChangeNotifyProviders of changes.
  Future<List<T>> getAll({OrderBy? orderBy}) async {
    orderBy ??= defaultOrderBy;
    final Database db = await databaseClient.database;
    List<Map<String, dynamic>> maps = await db.query(
      table,
      where: "deleted = 0",
      orderBy: orderBy.toString(),
    );
    final results = List.generate(maps.length, (i) => fromMap(maps[i]));
    _entities.clear();
    _entities.addAll(results);
    notifyListeners();
    return results;
  }

  /// Retrieves a single entity from table by id.
  Future<T?> getSingle(int id) async {
    final Database db = await databaseClient.database;
    List<Map<String, dynamic>> maps = await db.query(
      table,
      where: 'id = ?',
      whereArgs: [id],
    );
    if (maps.isNotEmpty) {
      return fromMap(maps.first);
    }
    return null;
  }

  /// Inserts a new entity into the table.
  /// Notifies ChangeNotifyProviders of changes.
  /// Returns the inserted entity.
  Future<T> insert(T entity) async {
    final Database db = await databaseClient.database;
    entity.id = await db.insert(
      table,
      toMap(entity),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    _entities.add(entity);
    notifyListeners();
    return entity;
  }

  Future<T> _update(T entity) async {
    final Database db = await databaseClient.database;
    entity.updatedAt = DateTime.now();
    await db.update(
      table,
      toMap(entity),
      where: 'id = ?',
      whereArgs: [entity.id],
    );
    return entity;
  }

  /// Updates the entity in the database.
  /// Notifies ChangeNotifyProviders of changes.
  /// Returns the updated entity.
  Future<T> update(T entity) async {
    final updatedEntity = await _update(entity);
    final index = _entities.indexWhere((e) => e.id == updatedEntity.id);
    if (index == -1) {}
    _entities[index] = updatedEntity;
    notifyListeners();
    return updatedEntity;
  }

  /// Marks the entity as deleted by id in the database.
  /// Notifies ChangeNotifyProviders of changes.
  /// Returns the deleted entity.
  Future<T?> delete(int id) async {
    final T? entity = await getSingle(id);
    if (entity == null) {
      throw Exception('Entity with id $id not found');
    }
    entity.deleted = true;
    final deletedEntity = await _update(entity);
    _entities.removeWhere((element) => element.id == id);
    notifyListeners();
    return deletedEntity;
  }
}
