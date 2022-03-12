import 'package:habitica_assistant/models/appearance_model.dart';
import 'package:habitica_assistant/models/battle_gear_model.dart';
import 'package:habitica_assistant/models/gear_model.dart';
import 'package:habitica_assistant/models/hair_model.dart';

class CostumeModel extends BattleGearModel {
  String? pet;
  String? mount;
  HairModel? hair;
  String? size;
  String? skin;
  String? shirt;
  String? chair;
  String? background;

  CostumeModel({
    int? id,
    required String name,
    int sequence = 0,
    String? armor,
    String? head,
    String? shield,
    String? weapon,
    String? eyewear,
    String? headAccessory,
    String? body,
    String? back,
    this.pet,
    this.mount,
    this.hair,
    this.size,
    this.skin,
    this.shirt,
    this.chair,
    this.background,
    DateTime? updatedAt,
    DateTime? createdAt,
    bool? deleted,
  }) : super(
          id: id,
          name: name,
          sequence: sequence,
          armor: armor,
          head: head,
          shield: shield,
          weapon: weapon,
          eyewear: eyewear,
          headAccessory: headAccessory,
          body: body,
          back: back,
          updatedAt: updatedAt,
          createdAt: createdAt,
          deleted: deleted,
        );

  CostumeModel.fromGear({
    int? id,
    required String name,
    int sequence = 0,
    required GearModel gear,
    this.pet,
    this.mount,
    this.hair,
    this.size,
    this.skin,
    this.shirt,
    this.chair,
    this.background,
    DateTime? updatedAt,
    DateTime? createdAt,
    bool? deleted,
  }) : super(
          id: id,
          name: name,
          sequence: sequence,
          armor: gear.armor,
          head: gear.head,
          shield: gear.shield,
          weapon: gear.weapon,
          eyewear: gear.eyewear,
          headAccessory: gear.headAccessory,
          body: gear.body,
          back: gear.back,
          updatedAt: updatedAt,
          createdAt: createdAt,
          deleted: deleted,
        );

  CostumeModel.fromAppearanceModel({
    int? id,
    required String name,
    int sequence = 0,
    required AppearanceModel appearance,
    DateTime? updatedAt,
    DateTime? createdAt,
    bool? deleted,
  }) : super(
          id: id,
          name: name,
          sequence: sequence,
          armor: appearance.armor,
          head: appearance.head,
          shield: appearance.shield,
          weapon: appearance.weapon,
          eyewear: appearance.eyewear,
          headAccessory: appearance.headAccessory,
          body: appearance.body,
          back: appearance.back,
          updatedAt: updatedAt,
          createdAt: createdAt,
          deleted: deleted,
        ) {
    pet = appearance.pet;
    mount = appearance.mount;
    hair = appearance.hair;
    size = appearance.size;
    skin = appearance.skin;
    shirt = appearance.shirt;
    chair = appearance.chair;
    background = appearance.background;
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
      hair: $hair,
      size: $size,
      skin: $skin,
      shirt: $shirt,
      chair: $chair,
      background: $background,
      updatedAt: $updatedAt,
      createdAt: $createdAt,
      deleted: $deleted
    }''';
  }
}
