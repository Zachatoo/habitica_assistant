import 'package:habitica_assistant/models/battle_gear_model.dart';
import 'package:habitica_assistant/repositories/base_repository.dart';

String _kID = 'id';
String _kName = 'name';
String _kSequence = 'sequence';
String _kArmor = 'armor';
String _kHead = 'head';
String _kShield = 'shield';
String _kWeapon = 'weapon';
String _kEyewear = 'eyewear';
String _kHeadAccessory = 'head_accessory';
String _kBody = 'body';
String _kBack = 'back';
String _kUpdatedAt = 'updated_at';
String _kCreatedAt = 'created_at';
String _kDeleted = 'deleted';

class BattleGearRepository extends BaseRepository<BattleGearModel> {
  @override
  String table = 'equipment_battle_gear';

  @override
  BattleGearModel fromMap(Map<String, dynamic> map) {
    return BattleGearModel(
      id: map[_kID],
      name: map[_kName],
      sequence: map[_kSequence],
      armor: map[_kArmor],
      head: map[_kHead],
      shield: map[_kShield],
      weapon: map[_kWeapon],
      eyewear: map[_kEyewear],
      headAccessory: map[_kHeadAccessory],
      body: map[_kBody],
      back: map[_kBack],
      updatedAt: DateTime.fromMillisecondsSinceEpoch(
          map[_kUpdatedAt] ?? DateTime.now().millisecondsSinceEpoch),
      createdAt: DateTime.fromMillisecondsSinceEpoch(
          map[_kCreatedAt] ?? DateTime.now().millisecondsSinceEpoch),
      deleted: map[_kDeleted] == 0 ? true : false,
    );
  }

  @override
  Map<String, dynamic> toMap(BattleGearModel entity) {
    return {
      _kID: entity.id,
      _kName: entity.name,
      _kSequence: entity.sequence,
      _kArmor: entity.armor,
      _kHead: entity.head,
      _kShield: entity.shield,
      _kWeapon: entity.weapon,
      _kEyewear: entity.eyewear,
      _kHeadAccessory: entity.headAccessory,
      _kBody: entity.body,
      _kBack: entity.back,
      _kUpdatedAt: entity.updatedAt.millisecondsSinceEpoch,
      _kCreatedAt: entity.createdAt.millisecondsSinceEpoch,
      _kDeleted: entity.deleted == true ? 1 : 0,
    };
  }
}
