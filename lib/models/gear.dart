class Gear {
  String? armor;
  String? head;
  String? shield;
  String? weapon;
  String? eyewear;
  String? headAccessory;
  String? body;
  String? back;

  Gear({
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
      'armor': armor,
      'head': head,
      'shield': shield,
      'weapon': weapon,
      'eyewear': eyewear,
      'headAccessory': headAccessory,
      'body': body,
      'back': back,
    };
  }

  Gear.fromMap(Map<String, dynamic> map) {
    armor = map["armor"];
    head = map["head"];
    shield = map["shield"];
    weapon = map["weapon"];
    eyewear = map["eyewear"];
    headAccessory = map["headAccessory"];
    body = map["body"];
    back = map["back"];
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
      back: $back
    }''';
  }
}
