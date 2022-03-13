import 'package:flutter/material.dart';
import 'package:habitica_assistant/components/snack_bar.dart';
import 'package:habitica_assistant/models/costume_model.dart';
import 'package:habitica_assistant/providers/costume_provider.dart';
import 'package:habitica_assistant/services/habitica_service.dart';
import 'package:provider/provider.dart';

class CostumesView extends StatelessWidget {
  const CostumesView({Key? key}) : super(key: key);
  final HabiticaService _habiticaService = const HabiticaService();

  void _setEquippedCostume({required CostumeModel gear, required BuildContext context}) async {
    try {
      await _habiticaService.setEquippedCostume(gear);
      buildSnackBar(
        context: context,
        content: 'Successfully updated costume',
        duration: snackBarDuration.short,
      );
    } catch (ex) {
      buildSnackBar(context: context, content: ex.toString());
    }
  }

  void _removeCostume(int gearID, BuildContext context, CostumeProvider provider) async {
    final CostumeModel? copyOfCostume = await provider.getSingle(gearID);
    if (copyOfCostume == null) {
      buildSnackBar(context: context, content: 'Unable to remove Costume');
    } else {
      buildSnackBar(
        context: context,
        content: 'Costume removed',
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () async {
            copyOfCostume.deleted = false;
            await provider.update(copyOfCostume);
          },
        ),
        duration: snackBarDuration.long,
      );
      await provider.delete(gearID);
    }
  }

  void _handleCostumeDropdownSelect(
    int option,
    CostumeModel costume,
    BuildContext context,
    CostumeProvider provider,
  ) {
    switch (option) {
      case 1:
        Navigator.pushNamed(context, '/editCostume', arguments: costume);
        break;
      case 2:
        _removeCostume(costume.id as int, context, provider);
        break;
      default:
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CostumeProvider>(
      builder: (context, provider, _) {
        return ListView.separated(
          primary: false,
          itemCount: provider.entityCount,
          itemBuilder: (context, index) {
            final item = provider.entities[index];
            return ListTile(
              title: Text(item.name),
              subtitle: Text(item.createdAt.toString()),
              onTap: () => _setEquippedCostume(context: context, gear: item),
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
                    _handleCostumeDropdownSelect(option as int, item, context, provider),
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
