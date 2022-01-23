import 'package:habitica_assistant/database.dart';
import 'package:habitica_assistant/models/base_model.dart';
import 'package:habitica_assistant/models/query_model.dart';
import 'package:sqflite/sqflite.dart';

const defaultColumnOrderBy = 'created_at';
final OrderBy defaultOrderBy = OrderBy(column: defaultColumnOrderBy);

/// Base provider with basic CRUD operations for database tables.
abstract class BaseRepository<T extends BaseModel> {
  /// Database client singleton instance.
  DatabaseClient databaseClient = DatabaseClient.instance;

  /// Name of table to query/modify in database.
  abstract String table;

  T fromMap(Map<String, dynamic> map);
  Map<String, dynamic> toMap(T entity);

  /// Retrieves all entities from table that aren't deleted.
  /// Supports ordering.
  Future<List<T>> getAll({OrderBy? orderBy}) async {
    orderBy ??= defaultOrderBy;
    final Database db = await databaseClient.database;
    List<Map<String, dynamic>> maps = await db.query(
      table,
      where: "deleted = 0",
      orderBy: orderBy.toString(),
    );
    final results = List.generate(maps.length, (i) => fromMap(maps[i]));
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
  /// Returns the inserted entity.
  Future<T> insert(T entity) async {
    final Database db = await databaseClient.database;
    entity.id = await db.insert(
      table,
      toMap(entity),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return entity;
  }

  /// Updates the entity in the database.
  /// Returns the updated entity.
  Future<T> update(T entity) async {
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

  /// Marks the entity as deleted by id in the database.
  /// Returns the deleted entity.
  Future<T?> delete(int id) async {
    final T? entity = await getSingle(id);
    if (entity == null) {
      throw Exception('Entity with id $id not found');
    }
    entity.deleted = true;
    final deletedEntity = await update(entity);
    return deletedEntity;
  }
}
