class Costume {
  int id;
  final String name;
  // equipment types
  final String? armor;
  final String? head;
  final String? shield;
  final String? weapon;
  final String? eyewear;
  final String? headAccessory;
  final String? body;
  final String? back;

  Costume({
    required this.id,
    required this.name,
    this.armor,
    this.head,
    this.shield,
    this.weapon,
    this.eyewear,
    this.headAccessory,
    this.body,
    this.back,
  });
}
