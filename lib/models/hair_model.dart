const String _kColor = 'color';
const String _kBase = 'base';
const String _kBangs = 'bangs';
const String _kBeard = 'beard';
const String _kMustache = 'mustache';
const String _kAccent = 'accent';
const String _kFlower = 'flower';

class HairModel {
  String? color;
  String? base;
  String? bangs;
  String? beard;
  String? mustache;
  String? accent;

  HairModel({
    this.color,
    this.base,
    this.bangs,
    this.beard,
    this.mustache,
    this.accent,
  });

  HairModel.fromMap(Map<String, dynamic> map) {
    color = map[_kColor]?.toString();
    base = map[_kBase]?.toString();
    bangs = map[_kBangs]?.toString();
    beard = map[_kBeard]?.toString();
    mustache = map[_kMustache]?.toString();
    accent = map[_kFlower]?.toString();
  }

  @override
  String toString() {
    return '''$runtimeType{
      $_kColor: $color,
      $_kBase: $base,
      $_kBangs: $bangs,
      $_kBeard: $beard,
      $_kMustache: $mustache,
      $_kAccent: $accent,
    }''';
  }
}
