import 'package:flutter/material.dart';
import 'package:habitica_assistant/components/snack_bar.dart';
import 'package:habitica_assistant/models/battle_gear_model.dart';
import 'package:habitica_assistant/models/costume_model.dart';
import 'package:habitica_assistant/providers/battle_gear_provider.dart';
import 'package:habitica_assistant/providers/costume_provider.dart';
import 'package:habitica_assistant/services/habitica_service.dart';
import 'package:provider/provider.dart';

class BattleGearView extends StatefulWidget {
  const BattleGearView({Key? key}) : super(key: key);

  @override
  _BattleGearViewState createState() => _BattleGearViewState();
}

class _BattleGearViewState extends State<BattleGearView> {
  final HabiticaService _habiticaService = HabiticaService();
  final _pageController = PageController();
  int _currentTabIndex = 0;

  @override
  void initState() {
    super.initState();
    _currentTabIndex = 0;
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _handleTabChange(int newIndex) {
    setState(() {
      _currentTabIndex = newIndex;
    });
  }

  void _handleTapTabChange(int newIndex) {
    _pageController.animateToPage(
      newIndex,
      duration: const Duration(milliseconds: 200),
      curve: Curves.bounceOut,
    );
  }

  void _addBattleGear(context) async {
    Navigator.pushNamed(context, '/addBattleGear');
  }

  void _addCostume(context) async {
    Navigator.pushNamed(context, '/addCostume');
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

  void _setEquippedCostume(CostumeModel gear, BuildContext context) async {
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
            await provider.getAll();
          },
        ),
        duration: snackBarDuration.long,
      );
      await provider.delete(gearID);
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
            await provider.getAll();
          },
        ),
        duration: snackBarDuration.long,
      );
      await provider.delete(gearID);
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

  void _handleCostumeDropdownSelect(
    int option,
    CostumeModel gear,
    BuildContext context,
    CostumeProvider provider,
  ) {
    switch (option) {
      case 1:
        Navigator.pushNamed(context, '/editCostume', arguments: gear);
        break;
      case 2:
        _removeCostume(gear.id as int, context, provider);
        break;
      default:
    }
  }

  IconButton _getAppBarAction(BuildContext context) {
    switch (_currentTabIndex) {
      case 0:
        return IconButton(
          onPressed: () => _addBattleGear(context),
          tooltip: 'Add Battle Gear',
          icon: const Icon(Icons.add),
        );
      case 1:
        return IconButton(
          onPressed: () => _addCostume(context),
          tooltip: 'Add Costume',
          icon: const Icon(Icons.add),
        );
    }
    throw Exception('Invalid index');
  }

  List<Widget> _getPages(BuildContext context) {
    return [
      Consumer<BattleGearProvider>(
        builder: (context, provider, _) {
          return GridView.count(
            crossAxisCount: 2,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            primary: false,
            padding: const EdgeInsets.all(20),
            children: <Widget>[
              ...provider.entities.map((entity) {
                return Card(
                  color: Theme.of(context).highlightColor,
                  child: InkWell(
                    onTap: () => _setEquippedBattleGear(entity, context),
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
                              onSelected: (option) => _handleBattleGearDropdownSelect(
                                  option as int, entity, context, provider),
                              icon: const Icon(Icons.more_vert),
                            ),
                          ],
                        ),
                        Text(entity.name),
                      ],
                    ),
                  ),
                );
              }),
            ],
          );
        },
      ),
      Consumer<CostumeProvider>(
        builder: (context, provider, _) {
          return GridView.count(
            crossAxisCount: 2,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            primary: false,
            padding: const EdgeInsets.all(20),
            children: <Widget>[
              ...provider.entities.map((entity) {
                return Card(
                  color: Theme.of(context).highlightColor,
                  child: InkWell(
                    onTap: () => _setEquippedCostume(entity, context),
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
                              onSelected: (option) => _handleCostumeDropdownSelect(
                                  option as int, entity, context, provider),
                              icon: const Icon(Icons.more_vert),
                            ),
                          ],
                        ),
                        Text(entity.name),
                      ],
                    ),
                  ),
                );
              }),
            ],
          );
        },
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Habitica Assistant'),
        backgroundColor: Theme.of(context).primaryColor,
        actions: [_getAppBarAction(context)],
      ),
      body: PageView(
        controller: _pageController,
        onPageChanged: _handleTabChange,
        children: _getPages(context),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.shield),
            label: 'Battle Gear',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.checkroom),
            label: 'Costume',
          ),
        ],
        currentIndex: _currentTabIndex,
        selectedItemColor: Theme.of(context).primaryColor,
        onTap: _handleTapTabChange,
      ),
    );
  }
}
