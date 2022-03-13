import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:habitica_assistant/models/habitica_auth_data_model.dart';
import 'package:habitica_assistant/services/secure_storage_service.dart';
import 'package:url_launcher/url_launcher.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final SecureStorageService _secureStorageService = SecureStorageService();

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
      await _secureStorageService.setAuthData(_authData);
      Navigator.of(context).pushReplacementNamed('/');
    }
  }

  void _handleClickLink() async {
    const url = 'https://habitica.com/user/settings/api';
    if (await canLaunch(url)) {
      launch(url);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Habitica Assistant'),
          backgroundColor: Theme.of(context).primaryColor,
        ),
        body: Form(
          key: _formKey,
          child: Column(
            children: [
              Center(
                child: Container(
                  margin: const EdgeInsets.all(15),
                  child: RichText(
                    text: TextSpan(
                      children: [
                        const TextSpan(
                          text:
                              'Habitica Assistant requires your Habitica User ID and API Token to function correctly. Your User ID and API Token will be stored locally on your device only.\n\nBy entering your User ID and API Key below, you are allowing this application to act in your behalf using your credientials.\n\n',
                          style: TextStyle(color: Colors.black),
                        ),
                        const TextSpan(
                          text: 'You can get your User ID and API Token from this link ',
                          style: TextStyle(color: Colors.black),
                        ),
                        TextSpan(
                          text: 'https://habitica.com/user/settings/api',
                          style: const TextStyle(color: Colors.blue),
                          recognizer: TapGestureRecognizer()..onTap = _handleClickLink,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
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
                child: const Text('Save'),
              ),
            ],
          ),
        ));
  }
}
