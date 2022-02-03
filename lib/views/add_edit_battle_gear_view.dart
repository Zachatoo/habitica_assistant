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

  String? _validateGearField(String? value) {
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
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Battle Gear"),
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
            validator: _validateGearField,
            decoration: const InputDecoration(labelText: 'Armor'),
            onChanged: (String? value) => setState(() {
              _gear.armor = value;
            }),
            items: _gearList
                .map(
                  (e) => DropdownMenuItem(
                    child: Text(e),
                    value: e,
                  ),
                )
                .toList(),
          ),
          TextFormField(
            initialValue: _gear.head,
            validator: _validateGearField,
            decoration: const InputDecoration(labelText: 'Head'),
            onChanged: (value) => setState(() {
              _gear.head = value;
            }),
          ),
          TextFormField(
            initialValue: _gear.shield,
            validator: _validateGearField,
            decoration: const InputDecoration(labelText: 'Shield'),
            onChanged: (value) => setState(() {
              _gear.shield = value;
            }),
          ),
          TextFormField(
            initialValue: _gear.weapon,
            validator: _validateGearField,
            decoration: const InputDecoration(labelText: 'Weapon'),
            onChanged: (value) => setState(() {
              _gear.weapon = value;
            }),
          ),
          TextFormField(
            initialValue: _gear.eyewear,
            validator: _validateGearField,
            decoration: const InputDecoration(labelText: 'Eyewear'),
            onChanged: (value) => setState(() {
              _gear.eyewear = value;
            }),
          ),
          TextFormField(
            initialValue: _gear.headAccessory,
            validator: _validateGearField,
            decoration: const InputDecoration(labelText: 'Head Accessory'),
            onChanged: (value) => setState(() {
              _gear.headAccessory = value;
            }),
          ),
          TextFormField(
            initialValue: _gear.body,
            validator: _validateGearField,
            decoration: const InputDecoration(labelText: 'Body'),
            onChanged: (value) => setState(() {
              _gear.body = value;
            }),
          ),
          TextFormField(
            initialValue: _gear.back,
            validator: _validateGearField,
            decoration: const InputDecoration(labelText: 'Back'),
            onChanged: (value) => setState(() {
              _gear.back = value;
            }),
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
