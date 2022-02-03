import 'package:flutter/material.dart';
import 'package:habitica_assistant/models/battle_gear_model.dart';
import 'package:habitica_assistant/providers/battle_gear_provider.dart';
import 'package:habitica_assistant/services/habitica_service.dart';
import 'package:provider/provider.dart';

class AddEditBattleGearView extends StatefulWidget {
  final BattleGearModel? model;
  const AddEditBattleGearView({Key? key, this.model}) : super(key: key);

  @override
  _AddEditBattleGearViewState createState() => _AddEditBattleGearViewState();
}

class _AddEditBattleGearViewState extends State<AddEditBattleGearView> {
  final HabiticaService _habiticaService = HabiticaService();

  final _formKey = GlobalKey<FormState>();
  late Future<BattleGearModel?> _gearFuture;
  late BattleGearModel _gear;
  late Iterable<String> _gearList;

  @override
  void initState() {
    super.initState();
    _gearFuture = _initBattleGear();
  }

  Future<BattleGearModel?> _initBattleGear() async {
    try {
      final userProfile = await _habiticaService.getAuthenticatedUserProfile();
      final equippedGear = userProfile.items.gear.equipped;
      final gearList = userProfile.items.gear.owned;
      if (mounted) {
        if (widget.model is BattleGearModel) {
          setState(() {
            _gear = widget.model as BattleGearModel;
            _gearList = gearList;
          });
        } else {
          setState(() {
            _gear = BattleGearModel.fromGear(name: '', gear: equippedGear);
            _gearList = gearList;
          });
        }
      }
      return _gear;
    } catch (ex) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(ex.toString()),
        ),
      );
    }
  }

  String? _validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Display name is required';
    }
    return null;
  }

  void _handleSubmit() async {
    if (_formKey.currentState!.validate()) {
      if (_gear.id != null) {
        await Provider.of<BattleGearProvider>(context, listen: false).update(_gear);
      } else {
        await Provider.of<BattleGearProvider>(context, listen: false).insert(_gear);
      }
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final String headerAction = widget.model is BattleGearModel ? "Edit" : "Add";
    return Scaffold(
      appBar: AppBar(
        title: Text("$headerAction Battle Gear"),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: FutureBuilder(
        future: _gearFuture,
        builder: (BuildContext context, AsyncSnapshot<BattleGearModel?> snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.data != null) {
            return _buildForm();
          }
          throw Exception();
        },
      ),
    );
  }

  Widget _buildForm() {
    return Form(
      key: _formKey,
      child: ListView(
        padding: const EdgeInsets.only(left: 10, right: 10),
        children: [
          TextFormField(
            initialValue: _gear.name,
            validator: _validateName,
            decoration: const InputDecoration(labelText: 'Display Name'),
            onChanged: (value) => setState(() {
              _gear.name = value;
            }),
          ),
          DropdownButtonFormField(
            value: _gear.armor,
            decoration: const InputDecoration(labelText: 'Armor'),
            onChanged: (String? value) => setState(() {
              _gear.armor = value;
            }),
            items: _gearList
                .where((element) => element.startsWith('armor'))
                .map(
                  (e) => DropdownMenuItem(
                    child: Text(e),
                    value: e,
                  ),
                )
                .toList(),
          ),
          DropdownButtonFormField(
            value: _gear.head,
            decoration: const InputDecoration(labelText: 'Head'),
            onChanged: (String? value) => setState(() {
              _gear.head = value;
            }),
            items: _gearList
                .where((element) => element.startsWith('head_'))
                .map(
                  (e) => DropdownMenuItem(
                    child: Text(e),
                    value: e,
                  ),
                )
                .toList(),
          ),
          DropdownButtonFormField(
            value: _gear.shield,
            decoration: const InputDecoration(labelText: 'Shield'),
            onChanged: (String? value) => setState(() {
              _gear.shield = value;
            }),
            items: _gearList
                .where((element) => element.startsWith('shield'))
                .map(
                  (e) => DropdownMenuItem(
                    child: Text(e),
                    value: e,
                  ),
                )
                .toList(),
          ),
          DropdownButtonFormField(
            value: _gear.weapon,
            decoration: const InputDecoration(labelText: 'Weapon'),
            onChanged: (String? value) => setState(() {
              _gear.weapon = value;
            }),
            items: _gearList
                .where((element) => element.startsWith('weapon'))
                .map(
                  (e) => DropdownMenuItem(
                    child: Text(e),
                    value: e,
                  ),
                )
                .toList(),
          ),
          DropdownButtonFormField(
            value: _gear.eyewear,
            decoration: const InputDecoration(labelText: 'Eyewear'),
            onChanged: (String? value) => setState(() {
              _gear.eyewear = value;
            }),
            items: _gearList
                .where((element) => element.startsWith('eyewear'))
                .map(
                  (e) => DropdownMenuItem(
                    child: Text(e),
                    value: e,
                  ),
                )
                .toList(),
          ),
          DropdownButtonFormField(
            value: _gear.headAccessory,
            decoration: const InputDecoration(labelText: 'Head Accessory'),
            onChanged: (String? value) => setState(() {
              _gear.headAccessory = value;
            }),
            items: _gearList
                .where((element) => element.startsWith('headAccessory'))
                .map(
                  (e) => DropdownMenuItem(
                    child: Text(e),
                    value: e,
                  ),
                )
                .toList(),
          ),
          DropdownButtonFormField(
            value: _gear.body,
            decoration: const InputDecoration(labelText: 'Body'),
            onChanged: (String? value) => setState(() {
              _gear.body = value;
            }),
            items: _gearList
                .where((element) => element.startsWith('body'))
                .map(
                  (e) => DropdownMenuItem(
                    child: Text(e),
                    value: e,
                  ),
                )
                .toList(),
          ),
          DropdownButtonFormField(
            value: _gear.back,
            decoration: const InputDecoration(labelText: 'Back'),
            onChanged: (String? value) => setState(() {
              _gear.back = value;
            }),
            items: _gearList
                .where((element) => element.startsWith('back'))
                .map(
                  (e) => DropdownMenuItem(
                    child: Text(e),
                    value: e,
                  ),
                )
                .toList(),
          ),
          ElevatedButton(
            // style: ButtonStyle(
            //   backgroundColor: Theme.of(context).primaryColor,
            // ),
            onPressed: _handleSubmit,
            child: const Text('Submit'),
          ),
        ],
      ),
    );
  }
}
