import 'package:flutter/material.dart';
import 'package:habitica_assistant/models/habitica_auth_data_model.dart';
import 'package:habitica_assistant/services/secure_storage_service.dart';
import 'package:habitica_assistant/views/battle_gear_view.dart';
import 'package:habitica_assistant/views/login_view.dart';

class HomeView extends StatelessWidget {
  final SecureStorageService _secureStorageService = SecureStorageService();

  HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _secureStorageService.getAuthData(),
      builder: (BuildContext context, AsyncSnapshot<HabiticaAuthDataModel> snapshot) {
        if (!snapshot.hasData) {
          return const CircularProgressIndicator();
        }
        if (snapshot.data!.apiToken != null && snapshot.data!.userID != null) {
          return const BattleGearView();
        }
        return const LoginView();
      },
    );
  }
}
