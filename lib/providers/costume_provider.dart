import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:habitica_assistant/models/costume_model.dart';
import 'package:habitica_assistant/models/query_model.dart';
import 'package:habitica_assistant/repositories/costume_repository.dart';

const defaultColumnOrderBy = 'created_at';
final OrderBy defaultOrderBy = OrderBy(column: defaultColumnOrderBy);

/// Base provider with basic CRUD operations for database tables.
class CostumeProvider extends ChangeNotifier {
  /// Repository layer for interacting with the database.
  final CostumeRepository _repository = CostumeRepository();

  /// Private list of entities.
  final List<CostumeModel> _entities = [];

  /// List of entities accessible to other classes.
  UnmodifiableListView<CostumeModel> get entities => UnmodifiableListView(_entities);

  /// Number of entities in table.
  int get entityCount => _entities.length;

  CostumeProvider() {
    getAll();
  }

  /// Retrieves all entities from table that aren't deleted.
  /// Notifies ChangeNotifyProviders of changes.
  Future<List<CostumeModel>> getAll({OrderBy? orderBy}) async {
    orderBy ??= defaultOrderBy;
    final List<CostumeModel> results = await _repository.getAll(orderBy: orderBy);
    _entities.clear();
    _entities.addAll(results);
    notifyListeners();
    return results;
  }

  /// Retrieves a single entity from table by id.
  Future<CostumeModel?> getSingle(int id) async {
    return await _repository.getSingle(id);
  }

  /// Inserts a new entity into the table.
  /// Notifies ChangeNotifyProviders of changes.
  /// Returns the inserted entity.
  Future<CostumeModel> insert(CostumeModel entity) async {
    final CostumeModel insertedEntity = await _repository.insert(entity);
    _entities.insert(0, insertedEntity);
    notifyListeners();
    return insertedEntity;
  }

  /// Updates the entity in the database.
  /// Notifies ChangeNotifyProviders of changes.
  /// Returns the updated entity.
  Future<CostumeModel> update(CostumeModel entity) async {
    final CostumeModel updatedEntity = await _repository.update(entity);
    final index = _entities.indexWhere((e) => e.id == updatedEntity.id);
    if (index != -1) {
      _entities[index] = updatedEntity;
      if (updatedEntity.deleted) {
        _entities.removeAt(index);
      }
    } else if (!updatedEntity.deleted) {
      _entities.insert(0, updatedEntity);
    }
    notifyListeners();
    return updatedEntity;
  }

  /// Marks the entity as deleted by id in the database.
  /// Notifies ChangeNotifyProviders of changes.
  /// Returns the deleted entity.
  Future<CostumeModel?> delete(int id) async {
    final CostumeModel? deletedEntity = await _repository.delete(id);
    _entities.removeWhere((element) => element.id == id);
    notifyListeners();
    return deletedEntity;
  }
}
