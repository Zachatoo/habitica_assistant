import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  final _disclaimerLine1 =
      'Habitica Assistant requires your Habitica User ID and API Token to function correctly. Your User ID and API Token will be stored locally on your device only.';
  final _disclaimerLine2 =
      'By entering your User ID and API Key below, you are allowing this application to act in your behalf using your credientials.';
  final _habiticaApiLink = 'https://habitica.com/user/settings/api';
  final _tokenRegex = RegExp(r'^[\w\d]{8}-[\w\d]{4}-[\w\d]{4}-[\w\d]{4}-[\w\d]{12}$');
  final _hintText = 'XXXXXXXX-XXXX-XXXX-XXXXXXXXXXXX';

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
    if (value != null && !_tokenRegex.hasMatch(value)) {
      return 'Enter valid ID';
    }
    return null;
  }

  String? _validateToken(String? value) {
    if (value != null && !_tokenRegex.hasMatch(value)) {
      return 'Enter valid token';
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
    if (await canLaunch(_habiticaApiLink)) {
      launch(_habiticaApiLink);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Habitica Assistant'),
        backgroundColor: Theme.of(context).primaryColor,
        systemOverlayStyle: SystemUiOverlayStyle.light,
      ),
      body: Form(
        key: _formKey,
        child: Container(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: ListView(
            children: [
              Center(
                child: Container(
                  margin: const EdgeInsets.only(top: 15, bottom: 15),
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: '$_disclaimerLine1\n\n$_disclaimerLine2\n\n',
                        ),
                        const TextSpan(
                          text: 'You can get your User ID and API Token from this link ',
                        ),
                        TextSpan(
                          text: _habiticaApiLink,
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
                decoration: InputDecoration(
                  labelText: 'Habitica User ID',
                  hintText: _hintText,
                ),
                onChanged: (value) => setState(() {
                  _authData.userID = value;
                }),
              ),
              TextFormField(
                initialValue: _authData.apiToken,
                validator: _validateToken,
                decoration: InputDecoration(
                  labelText: 'API Token',
                  hintText: _hintText,
                ),
                onChanged: (value) => setState(() {
                  _authData.apiToken = value;
                }),
              ),
              ElevatedButton(
                onPressed: _handleSubmit,
                child: const Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
