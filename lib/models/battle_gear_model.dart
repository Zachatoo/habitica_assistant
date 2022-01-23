import 'package:habitica_assistant/models/base_model.dart';
import 'package:habitica_assistant/models/gear_model.dart';

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
      id: $id,
      name: $name,
      sequence: $sequence,
      armor: $armor,
      head: $head,
      shield: $shield,
      weapon: $weapon,
      eyewear: $eyewear,
      headAccessory: $headAccessory,
      body: $body,
      back: $back,
      updatedAt: $updatedAt,
      createdAt: $createdAt,
      deleted: $deleted
    }''';
  }
}
