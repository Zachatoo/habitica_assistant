import 'package:flutter/material.dart';
import 'package:habitica_assistant/models/habitica_auth_data_model.dart';
import 'package:habitica_assistant/services/shared_preferences_service.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final SharedPreferencesService _sharedPreferencesService = SharedPreferencesService();

  final _formKey = GlobalKey<FormState>();
  late HabiticaAuthDataModel _authData;

  @override
  void initState() {
    super.initState();
    setState(() {
      _authData = HabiticaAuthDataModel(apiToken: '', userID: '');
    });
  }

  String? _validateID(String? value) {
    String pattern = r'^[\w\d]{8}-[\w\d]{4}-[\w\d]{4}-[\w\d]{4}-[\w\d]{12}$';
    RegExp regex = RegExp(pattern);
    if (value != null && !regex.hasMatch(value)) {
      return 'Enter valid ID';
    }
    return null;
  }

  void _handleSubmit() async {
    if (_formKey.currentState!.validate()) {
      await _sharedPreferencesService.setAuthData(_authData);
      Navigator.of(context).pushReplacementNamed('/');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Login"),
          backgroundColor: Theme.of(context).primaryColor,
        ),
        body: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                initialValue: _authData.userID,
                validator: _validateID,
                decoration: const InputDecoration(labelText: 'Habitica User ID'),
                onChanged: (value) => setState(() {
                  _authData.userID = value;
                }),
              ),
              TextFormField(
                initialValue: _authData.apiToken,
                validator: _validateID,
                decoration: const InputDecoration(labelText: 'API Token'),
                onChanged: (value) => setState(() {
                  _authData.apiToken = value;
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
        ));
  }
}
