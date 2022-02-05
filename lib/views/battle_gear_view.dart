import 'package:flutter/material.dart';
import 'package:habitica_assistant/components/snack_bar.dart';
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
      buildSnackBar(
        context: context,
        content: 'Successfully updated battle gear',
        duration: snackBarDuration.short,
      );
    } catch (ex) {
      buildSnackBar(context: context, content: ex.toString());
    }
  }

  void _removeBattleGear(int gearID, BuildContext context, BattleGearProvider provider) async {
    final BattleGearModel? copyOfBattleGear = await provider.getSingle(gearID);
    if (copyOfBattleGear == null) {
      buildSnackBar(context: context, content: 'Unable to remove outfit');
    } else {
      buildSnackBar(
        context: context,
        content: 'Outfit removed',
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () async {
            copyOfBattleGear.deleted = false;
            await provider.update(copyOfBattleGear);
            await provider.getAll();
          },
        ),
        duration: snackBarDuration.long,
      );
      await provider.delete(gearID);
    }
  }

  void _handleSelect(
    int option,
    BattleGearModel gear,
    BuildContext context,
    BattleGearProvider provider,
  ) {
    switch (option) {
      case 1:
        Navigator.pushNamed(context, '/editBattleGear', arguments: gear);
        break;
      case 2:
        _removeBattleGear(gear.id as int, context, provider);
        break;
      default:
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
                            PopupMenuButton(
                              itemBuilder: (context) => [
                                const PopupMenuItem(
                                  child: Text("Edit"),
                                  value: 1,
                                ),
                                const PopupMenuItem(
                                  child: Text("Delete"),
                                  value: 2,
                                )
                              ],
                              onSelected: (option) =>
                                  _handleSelect(option as int, e, context, provider),
                              icon: const Icon(Icons.more_vert),
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
