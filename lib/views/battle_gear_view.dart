import 'package:flutter/material.dart';
import 'package:habitica_assistant/models/battle_gear_model.dart';
import 'package:habitica_assistant/providers/battle_gear_provider.dart';
import 'package:habitica_assistant/services/habitica_service.dart';
import 'package:provider/provider.dart';

class BattleGearView extends StatefulWidget {
  const BattleGearView({Key? key}) : super(key: key);

  @override
  _BattleGearViewState createState() => _BattleGearViewState();
}

class _BattleGearViewState extends State<BattleGearView> {
  final HabiticaService _habiticaService = HabiticaService();

  void _addBattleGear(context) async {
    Navigator.pushNamed(context, '/addBattleGear');
  }

  void _setEquippedBattleGear(BattleGearModel gear, BuildContext context) async {
    try {
      await _habiticaService.setEquippedBattleGear(gear);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Successfully updated battle gear'),
        ),
      );
    } catch (ex) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(ex.toString()),
        ),
      );
    }
  }

  void _removeBattleGear(int gearID, BuildContext context, BattleGearProvider provider) async {
    final BattleGearModel? copyOfBattleGear = await provider.getSingle(gearID);
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
              await provider.update(copyOfBattleGear);
            },
          ),
          content: const Text('Outfit removed'),
        ),
      );
      await provider.delete(gearID);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Habitica Assistant'),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Consumer<BattleGearProvider>(
        builder: (context, provider, _) {
          return GridView.count(
            crossAxisCount: 2,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            primary: false,
            padding: const EdgeInsets.all(20),
            children: <Widget>[
              ...provider.entities.map((e) {
                return Card(
                  color: Theme.of(context).highlightColor,
                  child: InkWell(
                    onTap: () => _setEquippedBattleGear(e, context),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.delete_outline),
                              onPressed: () => _removeBattleGear(e.id as int, context, provider),
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
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _addBattleGear(context),
        tooltip: 'Add Battle Gear',
        child: const Icon(Icons.add),
      ),
    );
  }
}
