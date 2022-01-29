import 'package:flutter/material.dart';
import 'package:habitica_assistant/providers/battle_gear_provider.dart';
import 'package:habitica_assistant/views/add_edit_battle_gear_view.dart';
import 'package:habitica_assistant/views/home_view.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => BattleGearProvider(),
      child: MaterialApp(
        title: 'Habitica Assistant',
        theme: ThemeData(
          primaryColor: const Color(0xFF34B5C1), // teal 50
          // primaryColor: const Color(0xFF613384), // purple
          highlightColor: const Color(0xFF3BCAD7), // teal 100
        ),
        home: HomeView(),
        routes: {
          '/addBattleGear': (context) => const AddEditBattleGearView(),
        },
      ),
    );
  }
}
