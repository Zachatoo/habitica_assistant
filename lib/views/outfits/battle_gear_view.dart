import 'package:flutter/material.dart';
import 'package:habitica_assistant/components/snack_bar.dart';
import 'package:habitica_assistant/models/battle_gear_model.dart';
import 'package:habitica_assistant/providers/battle_gear_provider.dart';
import 'package:habitica_assistant/services/habitica_service.dart';
import 'package:provider/provider.dart';

class BattleGearView extends StatelessWidget {
  const BattleGearView({Key? key}) : super(key: key);
  final HabiticaService _habiticaService = const HabiticaService();

  void _setEquippedBattleGear(
      {required BattleGearModel gear, required BuildContext context}) async {
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

  void _handleBattleGearDropdownSelect(
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

  void _removeBattleGear(int gearID, BuildContext context, BattleGearProvider provider) async {
    final BattleGearModel? copyOfBattleGear = await provider.getSingle(gearID);
    if (copyOfBattleGear == null) {
      buildSnackBar(context: context, content: 'Unable to remove Battle Gear');
    } else {
      buildSnackBar(
        context: context,
        content: 'Battle Gear removed',
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () async {
            copyOfBattleGear.deleted = false;
            await provider.update(copyOfBattleGear);
          },
        ),
        duration: snackBarDuration.long,
      );
      await provider.delete(gearID);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<BattleGearProvider>(
      builder: (context, provider, _) {
        return ListView.separated(
          primary: false,
          itemCount: provider.entityCount,
          itemBuilder: (context, index) {
            final item = provider.entities[index];
            return ListTile(
              title: Text(item.name),
              subtitle: Text(item.createdAt.toString()),
              onTap: () => _setEquippedBattleGear(context: context, gear: item),
              trailing: PopupMenuButton(
                itemBuilder: (context) => [
                  const PopupMenuItem(
                    child: Text('Edit'),
                    value: 1,
                  ),
                  const PopupMenuItem(
                    child: Text('Delete'),
                    value: 2,
                  )
                ],
                onSelected: (option) =>
                    _handleBattleGearDropdownSelect(option as int, item, context, provider),
                icon: const Icon(Icons.more_vert),
              ),
            );
          },
          separatorBuilder: (context, index) {
            return const Divider();
          },
        );
      },
    );
  }
}
