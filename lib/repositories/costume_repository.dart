import 'package:habitica_assistant/models/costume_model.dart';
import 'package:habitica_assistant/models/hair_model.dart';
import 'package:habitica_assistant/repositories/base_repository.dart';

String _kId = 'id';
String _kName = 'name';
String _kSequence = 'sequence';
String _kArmor = 'armor';
String _kHead = 'head';
String _kShield = 'shield';
String _kWeapon = 'weapon';
String _kEyewear = 'eyewear';
String _kHeadAccessory = 'head_accessory';
String _kBody = 'body';
String _kBack = 'back';
String _kPet = 'pet';
String _kMount = 'mount';
String _kHairColor = 'hair_color';
String _kHairBase = 'hair_base';
String _kHairBangs = 'hair_bangs';
String _kHairBeard = 'hair_beard';
String _kHairMustache = 'hair_mustache';
String _kHairAccent = 'hair_accent';
String _kSize = 'size';
String _kSkin = 'skin';
String _kShirt = 'shirt';
String _kChair = 'chair';
String _kBackground = 'background';
String _kCreatedAt = 'created_at';
String _kUpdatedAt = 'updated_at';
String _kDeleted = 'deleted';

class CostumeRepository extends BaseRepository<CostumeModel> {
  @override
  String table = 'equipment_costumes';

  @override
  CostumeModel fromMap(Map<String, dynamic> map) {
    return CostumeModel(
      id: map[_kId],
      name: map[_kName],
      sequence: map[_kSequence],
      armor: map[_kArmor],
      head: map[_kHead],
      shield: map[_kShield],
      weapon: map[_kWeapon],
      eyewear: map[_kEyewear],
      headAccessory: map[_kHeadAccessory],
      body: map[_kBody],
      back: map[_kBack],
      pet: map[_kPet],
      mount: map[_kMount],
      hair: HairModel(
        color: map[_kHairColor],
        base: map[_kHairBase]?.toString(),
        bangs: map[_kHairBangs]?.toString(),
        beard: map[_kHairBeard]?.toString(),
        mustache: map[_kHairMustache]?.toString(),
        accent: map[_kHairAccent]?.toString(),
      ),
      size: map[_kSize],
      skin: map[_kSkin],
      shirt: map[_kShirt],
      chair: map[_kChair],
      background: map[_kBackground],
      updatedAt: DateTime.fromMillisecondsSinceEpoch(
          map[_kUpdatedAt] ?? DateTime.now().millisecondsSinceEpoch),
      createdAt: DateTime.fromMillisecondsSinceEpoch(
          map[_kCreatedAt] ?? DateTime.now().millisecondsSinceEpoch),
      deleted: map[_kDeleted] == 0 ? true : false,
    );
  }

  @override
  Map<String, dynamic> toMap(CostumeModel entity) {
    return {
      _kId: entity.id,
      _kName: entity.name,
      _kSequence: entity.sequence,
      _kArmor: entity.armor,
      _kHead: entity.head,
      _kShield: entity.shield,
      _kWeapon: entity.weapon,
      _kEyewear: entity.eyewear,
      _kHeadAccessory: entity.headAccessory,
      _kBody: entity.body,
      _kBack: entity.back,
      _kPet: entity.pet,
      _kMount: entity.mount,
      _kHairColor: entity.hair?.color,
      _kHairBase: entity.hair?.base,
      _kHairBangs: entity.hair?.bangs,
      _kHairBeard: entity.hair?.beard,
      _kHairMustache: entity.hair?.mustache,
      _kHairAccent: entity.hair?.accent,
      _kSize: entity.size,
      _kSkin: entity.skin,
      _kShirt: entity.shirt,
      _kChair: entity.chair,
      _kBackground: entity.background,
      _kCreatedAt: entity.createdAt.millisecondsSinceEpoch,
      _kUpdatedAt: entity.updatedAt.millisecondsSinceEpoch,
      _kDeleted: entity.deleted == true ? 1 : 0,
    };
  }
}
