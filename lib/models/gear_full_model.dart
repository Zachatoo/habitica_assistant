import 'package:habitica_assistant/models/habitica_user_profile_model.dart';

import 'gear_model.dart';

class GearFullModel extends GearModel {
  String? pet;
  String? mount;

  GearFullModel({
    this.pet,
    this.mount,
  });

  GearFullModel.fromHabiticaUserProfile(HabiticaUserProfileModel model) {
    final items = model.items;
    final gear = items.gear.costume;
    armor = gear.armor;
    head = gear.head;
    shield = gear.shield;
    weapon = gear.weapon;
    eyewear = gear.eyewear;
    headAccessory = gear.headAccessory;
    body = gear.body;
    back = gear.back;
    pet = items.currentPet;
    mount = items.currentMount;
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'armor': armor,
      'head': head,
      'shield': shield,
      'weapon': weapon,
      'eyewear': eyewear,
      'headAccessory': headAccessory,
      'body': body,
      'back': back,
      'pet': pet,
      'mount': mount,
    };
  }

  GearFullModel.fromMap(Map<String, dynamic> map) {
    armor = map["armor"];
    head = map["head"];
    shield = map["shield"];
    weapon = map["weapon"];
    eyewear = map["eyewear"];
    headAccessory = map["headAccessory"];
    body = map["body"];
    back = map["back"];
    pet = map["pet"];
    mount = map["mount"];
  }

  @override
  String toString() {
    return '''Gear{
      armor: $armor,
      head: $head,
      shield: $shield,
      weapon: $weapon,
      eyewear: $eyewear,
      headAccessory: $headAccessory,
      body: $body,
      back: $back,
      pet: $pet,
      mountL $mount,
    }''';
  }
}
