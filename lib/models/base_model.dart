/// Base entity with id and auditing properties.
abstract class BaseModel {
  int? id;
  DateTime updatedAt = DateTime.now();
  DateTime createdAt = DateTime.now();
  bool deleted = false;

  BaseModel({this.id, DateTime? updatedAt, DateTime? createdAt, bool? deleted}) {
    this.createdAt = createdAt ?? DateTime.now();
    this.updatedAt = updatedAt ?? DateTime.now();
    this.deleted = deleted ?? false;
  }
}
