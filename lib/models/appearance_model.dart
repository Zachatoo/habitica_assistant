import 'package:habitica_assistant/models/habitica_user_profile_model.dart';
import 'package:habitica_assistant/models/hair_model.dart';

import 'gear_model.dart';

const String _kArmor = 'armor';
const String _kHead = 'head';
const String _kShield = 'shield';
const String _kWeapon = 'weapon';
const String _kEyewear = 'eyewear';
const String _kHeadAccessory = 'head_accessory';
const String _kBody = 'body';
const String _kBack = 'back';
const String _kPet = 'pet';
const String _kMount = 'mount';
const String _kHair = 'hair';
const String _kSize = 'size';
const String _kSkin = 'skin';
const String _kShirt = 'shirt';
const String _kChair = 'chair';
const String _kBackground = 'background';

class AppearanceModel extends GearModel {
  String? pet;
  String? mount;
  late HairModel hair;
  late String size;
  late String skin;
  late String shirt;
  late String chair;
  late String background;

  AppearanceModel({
    this.pet,
    this.mount,
    required this.hair,
    required this.size,
    required this.skin,
    required this.shirt,
    required this.chair,
    required this.background,
  });

  AppearanceModel.fromHabiticaUserProfile(HabiticaUserProfileModel model) {
    final items = model.items;
    final gear = items.gear.costume;
    final preferences = model.preferences;
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
    hair = preferences.hair;
    size = preferences.size;
    skin = preferences.skin;
    shirt = preferences.shirt;
    chair = preferences.chair;
    background = preferences.background;
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      _kArmor: armor,
      _kHead: head,
      _kShield: shield,
      _kWeapon: weapon,
      _kEyewear: eyewear,
      _kHeadAccessory: headAccessory,
      _kBody: body,
      _kBack: back,
      _kPet: pet,
      _kMount: mount,
      _kHair: hair,
      _kSize: size,
      _kSkin: skin,
      _kShirt: shirt,
      _kChair: chair,
      _kBackground: background,
    };
  }

  @override
  String toString() {
    return '''$runtimeType{
      $_kArmor: $armor,
      $_kHead: $head,
      $_kShield: $shield,
      $_kWeapon: $weapon,
      $_kEyewear: $eyewear,
      $_kHeadAccessory: $headAccessory,
      $_kBody: $body,
      $_kBack: $back,
      $_kPet: $pet,
      $_kMount: $mount,
      $_kHair: $hair,
      $_kSize: $size,
      $_kSkin: $skin,
      $_kShirt: $shirt,
      $_kChair: $chair,
      $_kBackground: $background,
    }''';
  }
}
