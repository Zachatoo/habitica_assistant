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
      )
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
        ,created_at INTEGER(4) NOT NULL DEFAULT (strftime('%s','now'))
        ,updated_at INTEGER(4) NOT NULL DEFAULT (strftime('%s','now'))
        ,deleted INTEGER NOT NULL
      )
      CREATE INDEX idx_equipment_battle_gear_name ON equipment_battle_gear (name)
      CREATE INDEX idx_equipment_battle_gear_sequence ON equipment_battle_gear (sequence)
      CREATE INDEX idx_equipment_battle_gear_created_at ON equipment_battle_gear (created_at)
      CREATE INDEX idx_equipment_battle_gear_deleted ON equipment_battle_gear (deleted)
      CREATE INDEX idx_equipment_costume_name ON equipment_costumes (name)
      CREATE INDEX idx_equipment_costume_sequence ON equipment_costumes (sequence)
      CREATE INDEX idx_equipment_costume_created_at ON equipment_costumes (created_at)
      CREATE INDEX idx_equipment_costume_deleted ON equipment_costumes (deleted)
    ''',
    down: '',
  ),
  2: Migration(
    up: '''
        ALTER TABLE equipment_costumes ADD COLUMN pet TEXT;
        ALTER TABLE equipment_costumes ADD COLUMN mount TEXT;
      ''',
    down: '''
        PRAGMA foreign_keys=off;
        BEGIN TRANSACTION;
        CREATE TABLE IF NOT EXISTS equipment_costumes_temp(
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
        )
        INSERT INTO equipment_costumes_temp(
          id
          ,name
          ,sequence
          ,armor
          ,head
          ,shield
          ,weapon
          ,eyewear
          ,head_accessory
          ,body
          ,back
          ,created_at
          ,updated_at)
        SELECT id
          ,name
          ,sequence
          ,armor
          ,head
          ,shield
          ,weapon
          ,eyewear
          ,head_accessory
          ,body
          ,back
          ,created_at
          ,updated_at
        FROM equipment_costumes;
        DROP TABLE equipment_costumes;
        ALTER TABLE equipement_costumes_temp RENAME TO equipment_costumes;
        COMMIT;
        PRAGMA foreign_keys=on;
      ''',
  ),
  3: Migration(
    up: '''
        ALTER TABLE equipment_costumes ADD COLUMN hair TEXT;
        ALTER TABLE equipment_costumes ADD COLUMN size TEXT;
        ALTER TABLE equipment_costumes ADD COLUMN skin TEXT;
        ALTER TABLE equipment_costumes ADD COLUMN shirt TEXT;
        ALTER TABLE equipment_costumes ADD COLUMN chair TEXT;
        ALTER TABLE equipment_costumes ADD COLUMN background TEXT;
      ''',
    down: '''
        PRAGMA foreign_keys=off;
        BEGIN TRANSACTION;
        CREATE TABLE IF NOT EXISTS equipment_costumes_temp(
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
          ,created_at INTEGER(4) NOT NULL DEFAULT (strftime('%s','now'))
          ,updated_at INTEGER(4) NOT NULL DEFAULT (strftime('%s','now'))
          ,deleted INTEGER NOT NULL
        )
        INSERT INTO equipment_costumes_temp(
          id
          ,name
          ,sequence
          ,armor
          ,head
          ,shield
          ,weapon
          ,eyewear
          ,head_accessory
          ,body
          ,back
          ,pet
          ,mount
          ,created_at
          ,updated_at)
        SELECT id
          ,name
          ,sequence
          ,armor
          ,head
          ,shield
          ,weapon
          ,eyewear
          ,head_accessory
          ,body
          ,back
          ,pet
          ,mount
          ,created_at
          ,updated_at
        FROM equipment_costumes;
        DROP TABLE equipment_costumes;
        ALTER TABLE equipement_costumes_temp RENAME TO equipment_costumes;
        COMMIT;
        PRAGMA foreign_keys=on;
      ''',
  ),
};
