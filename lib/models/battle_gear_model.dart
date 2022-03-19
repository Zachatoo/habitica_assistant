import 'package:habitica_assistant/models/base_model.dart';
import 'package:habitica_assistant/models/gear_model.dart';

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

class BattleGearModel extends BaseModel {
  String name;
  int sequence;
  // equipment types
  String? armor;
  String? head;
  String? shield;
  String? weapon;
  String? eyewear;
  String? headAccessory;
  String? body;
  String? back;

  BattleGearModel({
    int? id,
    required this.name,
    this.sequence = 0,
    this.armor,
    this.head,
    this.shield,
    this.weapon,
    this.eyewear,
    this.headAccessory,
    this.body,
    this.back,
    DateTime? updatedAt,
    DateTime? createdAt,
    bool? deleted,
  }) : super(id: id, updatedAt: updatedAt, createdAt: createdAt, deleted: deleted);

  BattleGearModel.fromGear({
    int? id,
    required this.name,
    this.sequence = 0,
    required GearModel gear,
    DateTime? updatedAt,
    DateTime? createdAt,
    bool? deleted,
  }) : super(id: id, updatedAt: updatedAt, createdAt: createdAt, deleted: deleted) {
    armor = gear.armor;
    head = gear.head;
    shield = gear.shield;
    weapon = gear.weapon;
    eyewear = gear.eyewear;
    headAccessory = gear.headAccessory;
    body = gear.body;
    back = gear.back;
  }

  @override
  String toString() {
    return '''$runtimeType{
      $_kID: $id,
      $_kName: $name,
      $_kSequence: $sequence,
      $_kArmor: $armor,
      $_kHead: $head,
      $_kShield: $shield,
      $_kWeapon: $weapon,
      $_kEyewear: $eyewear,
      $_kHeadAccessory: $headAccessory,
      $_kBody: $body,
      $_kBack: $back,
      $_kUpdatedAt: $updatedAt,
      $_kCreatedAt: $createdAt,
      $_kDeleted: $deleted
    }''';
  }
}
