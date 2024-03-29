import 'package:flutter/material.dart';
import 'package:habitica_assistant/models/habitica_auth_data_model.dart';
import 'package:habitica_assistant/services/secure_storage_service.dart';
import 'package:habitica_assistant/views/outfits/outfits_view.dart';
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
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.data!.apiToken != null && snapshot.data!.userID != null) {
          return const OutfitsView();
        }
        return const LoginView();
      },
    );
  }
}
