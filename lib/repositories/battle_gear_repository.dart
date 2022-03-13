import 'package:habitica_assistant/models/battle_gear_model.dart';
import 'package:habitica_assistant/repositories/base_repository.dart';

class BattleGearRepository extends BaseRepository<BattleGearModel> {
  @override
  String table = 'equipment_battle_gear';

  @override
  BattleGearModel fromMap(Map<String, dynamic> map) {
    return BattleGearModel(
      id: map['id'],
      name: map['name'],
      sequence: map['sequence'],
      armor: map['armor'],
      head: map['head'],
      shield: map['shield'],
      weapon: map['weapon'],
      eyewear: map['eyewear'],
      headAccessory: map['head_accessory'],
      body: map['body'],
      back: map['back'],
      updatedAt: DateTime.fromMillisecondsSinceEpoch(
          map['updatedAt'] ?? DateTime.now().millisecondsSinceEpoch),
      createdAt: DateTime.fromMillisecondsSinceEpoch(
          map['createdAt'] ?? DateTime.now().millisecondsSinceEpoch),
      deleted: map['deleted'] == 0 ? true : false,
    );
  }

  @override
  Map<String, dynamic> toMap(BattleGearModel entity) {
    return {
      'id': entity.id,
      'name': entity.name,
      'sequence': entity.sequence,
      'armor': entity.armor,
      'head': entity.head,
      'shield': entity.shield,
      'weapon': entity.weapon,
      'eyewear': entity.eyewear,
      'head_accessory': entity.headAccessory,
      'body': entity.body,
      'back': entity.back,
      'updated_at': entity.updatedAt.millisecondsSinceEpoch,
      'created_at': entity.createdAt.millisecondsSinceEpoch,
      'deleted': entity.deleted,
    };
  }
}
