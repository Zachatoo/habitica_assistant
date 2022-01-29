import 'package:flutter/material.dart';
import 'package:habitica_assistant/services/shared_preferences_service.dart';
import 'package:habitica_assistant/views/battle_gear_view.dart';
import 'package:habitica_assistant/views/login_view.dart';

class HomeView extends StatelessWidget {
  final SharedPreferencesService _sharedPreferencesService = SharedPreferencesService();

  HomeView({Key? key}) : super(key: key);

  Future<List<String?>> _initSharedPreferences() async {
    final apiTokenFuture = _sharedPreferencesService.getApiToken();
    final userIDFuture = _sharedPreferencesService.getUserID();
    List<String?> authArr = await Future.wait([apiTokenFuture, userIDFuture]);
    return authArr;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initSharedPreferences(),
      builder: (BuildContext context, AsyncSnapshot<List<String?>> snapshot) {
        if (!snapshot.hasData) {
          return const CircularProgressIndicator();
        }
        if (snapshot.data![0] != null && snapshot.data![1] != null) {
          return const BattleGearView();
        }
        return const LoginView();
      },
    );
  }
}