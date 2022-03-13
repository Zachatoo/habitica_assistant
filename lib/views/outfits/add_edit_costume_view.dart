import 'package:flutter/material.dart';
import 'package:habitica_assistant/components/snack_bar.dart';
import 'package:habitica_assistant/models/costume_model.dart';
import 'package:habitica_assistant/providers/costume_provider.dart';
import 'package:habitica_assistant/services/habitica_service.dart';
import 'package:provider/provider.dart';

class AddEditCostumeView extends StatefulWidget {
  final CostumeModel? model;
  const AddEditCostumeView({Key? key, this.model}) : super(key: key);

  @override
  _AddEditCostumeViewState createState() => _AddEditCostumeViewState();
}

class _AddEditCostumeViewState extends State<AddEditCostumeView> {
  final HabiticaService _habiticaService = const HabiticaService();

  final _formKey = GlobalKey<FormState>();
  late Future<CostumeModel?> _gearFuture;
  late CostumeModel _gear;
  late Iterable<String> _gearList;
  late Iterable<String> _petsList;
  late Iterable<String> _mountsList;

  @override
  void initState() {
    super.initState();
    _gearFuture = _initCostume();
  }

  Future<CostumeModel?> _initCostume() async {
    try {
      final userProfile = await _habiticaService.getAuthenticatedUserProfile();
      final equippedCostume = userProfile.items.gear.costume;
      final gearList = userProfile.items.gear.owned;
      final petsList = userProfile.items.pets;
      final mountsList = userProfile.items.pets;
      if (mounted) {
        if (widget.model is CostumeModel) {
          setState(() {
            _gear = widget.model as CostumeModel;
            _gearList = gearList;
            _petsList = petsList;
            _mountsList = mountsList;
          });
        } else {
          setState(() {
            _gear = CostumeModel.fromGear(
              name: '',
              gear: equippedCostume,
              pet: userProfile.items.currentPet,
              mount: userProfile.items.currentMount,
              hair: userProfile.preferences.hair,
              size: userProfile.preferences.size,
              skin: userProfile.preferences.skin,
              shirt: userProfile.preferences.shirt,
              chair: userProfile.preferences.chair,
              background: userProfile.preferences.background,
            );
            _gearList = gearList;
            _petsList = petsList;
            _mountsList = mountsList;
          });
        }
      }
      return _gear;
    } catch (ex) {
      buildSnackBar(context: context, content: ex.toString());
      return null;
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
        await Provider.of<CostumeProvider>(context, listen: false).update(_gear);
      } else {
        await Provider.of<CostumeProvider>(context, listen: false).insert(_gear);
      }
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final String headerAction = widget.model is CostumeModel ? 'Edit' : 'Add';
    return Scaffold(
      appBar: AppBar(
        title: Text('$headerAction Costume'),
      ),
      body: FutureBuilder(
        future: _gearFuture,
        builder: (BuildContext context, AsyncSnapshot<CostumeModel?> snapshot) {
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
            decoration: const InputDecoration(
              labelText: 'Display Name',
              hintText: 'Enter name here',
            ),
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
          DropdownButtonFormField(
            value: _gear.pet,
            decoration: const InputDecoration(labelText: 'Pet'),
            onChanged: (String? value) => setState(() {
              _gear.pet = value;
            }),
            items: _petsList
                .map(
                  (e) => DropdownMenuItem(
                    child: Text(e),
                    value: e,
                  ),
                )
                .toList(),
          ),
          DropdownButtonFormField(
            value: _gear.mount,
            decoration: const InputDecoration(labelText: 'Mount'),
            onChanged: (String? value) => setState(() {
              _gear.mount = value;
            }),
            items: _mountsList
                .map(
                  (e) => DropdownMenuItem(
                    child: Text(e),
                    value: e,
                  ),
                )
                .toList(),
          ),
          ElevatedButton(
            onPressed: _handleSubmit,
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }
}
