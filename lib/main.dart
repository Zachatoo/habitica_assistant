import 'package:flutter/material.dart';
import 'package:habitica_assistant/models/battle_gear_model.dart';
import 'package:habitica_assistant/providers/battle_gear_provider.dart';
import 'package:habitica_assistant/providers/costume_provider.dart';
import 'package:habitica_assistant/views/add_edit_battle_gear_view.dart';
import 'package:habitica_assistant/views/add_edit_costume_view.dart';
import 'package:habitica_assistant/views/home_view.dart';
import 'package:provider/provider.dart';

import 'models/costume_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<BattleGearProvider>(create: (_) => BattleGearProvider()),
        ChangeNotifierProvider<CostumeProvider>(create: (_) => CostumeProvider()),
      ],
      child: MaterialApp(
        title: 'Habitica Assistant',
        theme: ThemeData(
          primaryColor: const Color(0xFF34B5C1), // teal 50
          // primaryColor: const Color(0xFF613384), // purple
          highlightColor: const Color(0xFF3BCAD7), // teal 100
          snackBarTheme: SnackBarThemeData(
            behavior: SnackBarBehavior.floating,
            actionTextColor: const Color(0xFF3BCAD7),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            elevation: 3.0,
          ),
        ),
        home: HomeView(),
        onGenerateRoute: _getRoute,
        routes: {
          '/addBattleGear': (_) => const AddEditBattleGearView(),
          '/addCostume': (_) => const AddEditCostumeView(),
        },
      ),
    );
  }
}

Route<dynamic> _getRoute(RouteSettings settings) {
  final arguments = settings.arguments;
  switch (settings.name) {
    case '/editBattleGear':
      if (arguments is BattleGearModel) {
        return _buildRoute(settings, AddEditBattleGearView(model: arguments));
      }
      return _buildRoute(settings, const AddEditBattleGearView());
    case '/editCostume':
      if (arguments is CostumeModel) {
        return _buildRoute(settings, AddEditCostumeView(model: arguments));
      }
      return _buildRoute(settings, const AddEditCostumeView());
    default:
      return _buildRoute(settings, HomeView());
  }
}

MaterialPageRoute _buildRoute(RouteSettings settings, Widget builder) {
  return MaterialPageRoute(builder: (ctx) => builder, settings: settings);
}
