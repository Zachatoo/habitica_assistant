String _kArmor = 'armor';
String _kHead = 'head';
String _kShield = 'shield';
String _kWeapon = 'weapon';
String _kEyewear = 'eyewear';
String _kHeadAccessory = 'head_accessory';
String _kBody = 'body';
String _kBack = 'back';

class GearModel {
  String? armor;
  String? head;
  String? shield;
  String? weapon;
  String? eyewear;
  String? headAccessory;
  String? body;
  String? back;

  GearModel({
    this.armor,
    this.head,
    this.shield,
    this.weapon,
    this.eyewear,
    this.headAccessory,
    this.body,
    this.back,
  });

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
    };
  }

  GearModel.fromMap(Map<String, dynamic> map) {
    armor = map[_kArmor];
    head = map[_kHead];
    shield = map[_kShield];
    weapon = map[_kWeapon];
    eyewear = map[_kEyewear];
    headAccessory = map[_kHeadAccessory];
    body = map[_kBody];
    back = map[_kBack];
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
      $_kBack: $back
    }''';
  }
}
