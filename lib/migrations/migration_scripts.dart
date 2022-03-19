class Migration {
  String up;
  String down;

  Migration({required this.up, required this.down});
}

Map<int, Migration> migrationScripts = {
  1: Migration(
    up: '''
      CREATE TABLE equipment_battle_gear(
        id INTEGER PRIMARY KEY AUTOINCREMENT
        ,name TEXT NOT NULL
        ,sequence INTEGER(4) NOT NULL
        ,armor TEXT
        ,head TEXT
        ,shield TEXT
        ,weapon TEXT
        ,eyewear TEXT
        ,head_accessory TEXT
        ,body TEXT
        ,back TEXT
        ,created_at INTEGER(4) NOT NULL DEFAULT (strftime('%s','now'))
        ,updated_at INTEGER(4) NOT NULL DEFAULT (strftime('%s','now'))
        ,deleted INTEGER NOT NULL
      );
      CREATE TABLE equipment_costumes(
        id INTEGER PRIMARY KEY AUTOINCREMENT
        ,name TEXT NOT NULL
        ,sequence INTEGER(4) NOT NULL
        ,armor TEXT
        ,head TEXT
        ,shield TEXT
        ,weapon TEXT
        ,eyewear TEXT
        ,head_accessory TEXT
        ,body TEXT
        ,back TEXT
        ,pet TEXT
        ,mount TEXT
        ,hair_color TEXT
        ,hair_base INTEGER(4)
        ,hair_bangs INTEGER(4)
        ,hair_beard INTEGER(4)
        ,hair_mustache INTEGER(4)
        ,hair_accent INTEGER(4)
        ,size TEXT
        ,skin TEXT
        ,shirt TEXT
        ,chair TEXT
        ,background TEXT
        ,created_at INTEGER(4) NOT NULL DEFAULT (strftime('%s','now'))
        ,updated_at INTEGER(4) NOT NULL DEFAULT (strftime('%s','now'))
        ,deleted INTEGER NOT NULL
      );
      CREATE INDEX idx_equipment_battle_gear_name ON equipment_battle_gear (name);
      CREATE INDEX idx_equipment_battle_gear_sequence ON equipment_battle_gear (sequence);
      CREATE INDEX idx_equipment_battle_gear_created_at ON equipment_battle_gear (created_at);
      CREATE INDEX idx_equipment_battle_gear_deleted ON equipment_battle_gear (deleted);
      CREATE INDEX idx_equipment_costume_name ON equipment_costumes (name);
      CREATE INDEX idx_equipment_costume_sequence ON equipment_costumes (sequence);
      CREATE INDEX idx_equipment_costume_created_at ON equipment_costumes (created_at);
      CREATE INDEX idx_equipment_costume_deleted ON equipment_costumes (deleted);
    ''',
    down: '',
  ),
};
