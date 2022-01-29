import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:habitica_assistant/models/battle_gear_model.dart';
import 'package:habitica_assistant/models/query_model.dart';
import 'package:habitica_assistant/repositories/battle_gear_repository.dart';

const defaultColumnOrderBy = 'created_at';
final OrderBy defaultOrderBy = OrderBy(column: defaultColumnOrderBy);

/// Base provider with basic CRUD operations for database tables.
class BattleGearProvider extends ChangeNotifier {
  /// Repository layer for interacting with the database.
  final BattleGearRepository _repository = BattleGearRepository();

  /// Private list of entities.
  final List<BattleGearModel> _entities = [];

  /// List of entities accessible to other classes.
  UnmodifiableListView<BattleGearModel> get entities => UnmodifiableListView(_entities);

  /// Number of entities in table.
  int get entityCount => _entities.length;

  BattleGearProvider() {
    getAll();
  }

  /// Retrieves all entities from table that aren't deleted.
  /// Notifies ChangeNotifyProviders of changes.
  Future<List<BattleGearModel>> getAll({OrderBy? orderBy}) async {
    orderBy ??= defaultOrderBy;
    final List<BattleGearModel> results = await _repository.getAll(orderBy: orderBy);
    _entities.clear();
    _entities.addAll(results);
    notifyListeners();
    return results;
  }

  /// Retrieves a single entity from table by id.
  Future<BattleGearModel?> getSingle(int id) async {
    return await _repository.getSingle(id);
  }

  /// Inserts a new entity into the table.
  /// Notifies ChangeNotifyProviders of changes.
  /// Returns the inserted entity.
  Future<BattleGearModel> insert(BattleGearModel entity) async {
    final BattleGearModel insertedEntity = await _repository.insert(entity);
    _entities.insert(0, insertedEntity);
    notifyListeners();
    return insertedEntity;
  }

  /// Updates the entity in the database.
  /// Notifies ChangeNotifyProviders of changes.
  /// Returns the updated entity.
  Future<BattleGearModel> update(BattleGearModel entity) async {
    final BattleGearModel updatedEntity = await _repository.update(entity);
    final index = _entities.indexWhere((e) => e.id == updatedEntity.id);
    if (index == -1) {
      throw Exception('Entity not found: $entity');
    }
    _entities[index] = updatedEntity;
    notifyListeners();
    return updatedEntity;
  }

  /// Marks the entity as deleted by id in the database.
  /// Notifies ChangeNotifyProviders of changes.
  /// Returns the deleted entity.
  Future<BattleGearModel?> delete(int id) async {
    final BattleGearModel? deletedEntity = await _repository.delete(id);
    _entities.removeWhere((element) => element.id == id);
    notifyListeners();
    return deletedEntity;
  }
}
