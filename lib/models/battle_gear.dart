import 'package:habitica_assistant/models/gear.dart';
import 'package:habitica_assistant/providers/base_provider.dart';

class BattleGear extends BaseEntity {
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

  BattleGear({
    id,
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
    updatedAt,
    createdAt,
    deleted,
  }) : super(id, updatedAt, createdAt, deleted);

  BattleGear.fromGear({
    id,
    required this.name,
    this.sequence = 0,
    required Gear gear,
    updatedAt,
    createdAt,
    deleted,
  }) : super(id, updatedAt = DateTime.now(), createdAt = DateTime.now(), deleted = false) {
    armor = gear.armor;
    head = gear.head;
    shield = gear.shield;
    weapon = gear.weapon;
    eyewear = gear.eyewear;
    headAccessory = gear.headAccessory;
    body = gear.body;
    back = gear.back;
  }

  // Map<String, dynamic> toMap() {
  //   return {
  //     'id': id,
  //     'name': name,
  //     'armor': armor,
  //     'head': head,
  //     'shield': shield,
  //     'weapon': weapon,
  //     'eyewear': eyewear,
  //     'headAccessory': headAccessory,
  //     'body': body,
  //     'back': back,
  //   };
  // }

  // BattleGear.fromMap(Map<String, dynamic> map) {
  //   id = map["id"];
  //   name = map["name"];
  //   armor = map["armor"];
  //   head = map["head"];
  //   shield = map["shield"];
  //   weapon = map["weapon"];
  //   eyewear = map["eyewear"];
  //   headAccessory = map["headAccessory"];
  //   body = map["body"];
  //   back = map["back"];
  // }

  @override
  String toString() {
    return '''BattleGear{
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
