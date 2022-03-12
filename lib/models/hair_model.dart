class HairModel {
  late String color;
  late String base;
  late String bangs;
  late String beard;
  late String mustache;
  late String flower;

  HairModel({
    this.color = "",
    this.base = "",
    this.bangs = "",
    this.beard = "",
    this.mustache = "",
    this.flower = "",
  });

  HairModel.fromMap(Map<String, dynamic> map) {
    color = map["color"].toString();
    base = map["base"].toString();
    bangs = map["bangs"].toString();
    beard = map["beard"].toString();
    mustache = map["mustache"].toString();
    flower = map["flower"].toString();
  }

  @override
  String toString() {
    return '''$runtimeType{
      color: $color,
      base: $base,
      bangs: $bangs,
      beard: $beard,
      mustache: $mustache,
      flower: $flower,
    }''';
  }
}
