import 'package:flutter/material.dart';
import 'package:habitica_assistant/models/battle_gear_model.dart';
import 'package:habitica_assistant/providers/battle_gear_provider.dart';
import 'package:habitica_assistant/services/habitica_service.dart';

class BattleGearView extends StatefulWidget {
  const BattleGearView({Key? key}) : super(key: key);

  @override
  _BattleGearViewState createState() => _BattleGearViewState();
}

class _BattleGearViewState extends State<BattleGearView> {
  List<BattleGearModel> _gearList = [];
  final BattleGearProvider _battleGearProvider = BattleGearProvider();

  @override
  void initState() {
    super.initState();
    _initBattleGear();
  }

  void _initBattleGear() async {
    final newBattleGearList = await _battleGearProvider.getAll();
    setState(() {
      _gearList = newBattleGearList;
    });
  }

  void _addBattleGear() async {
    final service = HabiticaService();
    try {
      final gear = await service.getEquippedBattleGear();
      final battleGear = BattleGearModel.fromGear(name: '123', gear: gear);
      await _battleGearProvider.insert(battleGear);
      final newBattleGearList = _battleGearProvider.entities;
      setState(() {
        _gearList = newBattleGearList;
      });
    } catch (ex) {
      print(ex);
    }
  }

  void _removeBattleGear(int gearID, BuildContext context) async {
    final BattleGearModel? copyOfBattleGear = await _battleGearProvider.getSingle(gearID);
    if (copyOfBattleGear == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Unable to remove outfit'),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          action: SnackBarAction(
            label: 'Undo',
            onPressed: () async {
              copyOfBattleGear.deleted = false;
              await _battleGearProvider.update(copyOfBattleGear);
              setState(() {
                _gearList = _battleGearProvider.entities;
              });
            },
          ),
          content: const Text('Outfit removed'),
        ),
      );
      await _battleGearProvider.delete(gearID);
      setState(() {
        _gearList = _battleGearProvider.entities;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Habitica Assistant'),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: GridView.count(
        crossAxisCount: 2,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        primary: false,
        padding: const EdgeInsets.all(20),
        children: <Widget>[
          ..._gearList.map((e) {
            return Card(
              color: Theme.of(context).highlightColor,
              child: InkWell(
                onTap: () => {},
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.delete_outline),
                          onPressed: () => _removeBattleGear(e.id as int, context),
                          tooltip: "Remove",
                        ),
                      ],
                    ),
                    Text(e.name),
                  ],
                ),
              ),
            );
          }),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addBattleGear,
        tooltip: 'Add Battle Gear',
        child: const Icon(Icons.add),
      ),
    );
  }
}
