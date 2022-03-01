import 'package:habitica_assistant/models/base_model.dart';
import 'package:habitica_assistant/models/gear_full_model.dart';
import 'package:habitica_assistant/models/gear_model.dart';

class CostumeModel extends BaseModel {
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
  String? pet;
  String? mount;

  CostumeModel({
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
    this.pet,
    this.mount,
    DateTime? updatedAt,
    DateTime? createdAt,
    bool? deleted,
  }) : super(id: id, updatedAt: updatedAt, createdAt: createdAt, deleted: deleted);

  CostumeModel.fromGear({
    int? id,
    required this.name,
    this.sequence = 0,
    required GearModel gear,
    this.pet,
    this.mount,
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

  CostumeModel.fromGearFull({
    int? id,
    required this.name,
    this.sequence = 0,
    required GearFullModel gear,
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
    pet = gear.pet;
    mount = gear.mount;
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
      pet: $pet,
      mount: $mount,
      updatedAt: $updatedAt,
      createdAt: $createdAt,
      deleted: $deleted
    }''';
  }
}
