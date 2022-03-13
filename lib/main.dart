import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:habitica_assistant/models/battle_gear_model.dart';
import 'package:habitica_assistant/providers/battle_gear_provider.dart';
import 'package:habitica_assistant/providers/costume_provider.dart';
import 'package:habitica_assistant/views/outfits/add_edit_battle_gear_view.dart';
import 'package:habitica_assistant/views/outfits/add_edit_costume_view.dart';
import 'package:habitica_assistant/views/home_view.dart';
import 'package:provider/provider.dart';

import 'models/costume_model.dart';

void main() async {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.light,
    systemNavigationBarColor: Colors.transparent,
  ));
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  final primaryColor = const Color(0xFF34B5C1); // teal 50
  final highlightColor = const Color(0xFF3BCAD7); // teal 100
  final errorColor = const Color.fromARGB(255, 224, 118, 111);
  final greyColor = const Color.fromARGB(255, 49, 56, 58);

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

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<BattleGearProvider>(create: (_) => BattleGearProvider()),
        ChangeNotifierProvider<CostumeProvider>(create: (_) => CostumeProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Habitica Assistant',
        theme: Theme.of(context).copyWith(
          primaryColor: primaryColor,
          highlightColor: highlightColor,
          errorColor: errorColor,
          scaffoldBackgroundColor: Colors.black54,
          canvasColor: Colors.black,
          textTheme: const TextTheme().apply(
            bodyColor: Colors.white,
            displayColor: Colors.white,
            decorationColor: Colors.white,
          ),
          popupMenuTheme: PopupMenuThemeData(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            color: greyColor,
          ),
          inputDecorationTheme: InputDecorationTheme(
            labelStyle: TextStyle(color: primaryColor),
            floatingLabelBehavior: FloatingLabelBehavior.always,
            hintStyle: const TextStyle(color: Colors.white54),
            border: const UnderlineInputBorder(),
            enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: highlightColor),
            ),
          ),
          listTileTheme: ListTileTheme.of(context).copyWith(
            textColor: Colors.white,
            iconColor: Colors.white,
          ),
          dividerTheme: DividerTheme.of(context).copyWith(
            color: Colors.grey,
            space: 0,
          ),
          appBarTheme: AppBarTheme.of(context).copyWith(
            titleTextStyle: const TextStyle(
              color: Colors.white,
              fontSize: 20,
            ),
            backgroundColor: Colors.black,
          ),
          bottomAppBarTheme: BottomAppBarTheme.of(context).copyWith(
            color: Colors.black,
          ),
          bottomNavigationBarTheme: BottomNavigationBarTheme.of(context).copyWith(
            backgroundColor: Colors.black,
            unselectedItemColor: Colors.grey,
            selectedItemColor: primaryColor,
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(primaryColor)),
          ),
          snackBarTheme: SnackBarThemeData(
            behavior: SnackBarBehavior.floating,
            actionTextColor: primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            elevation: 3.0,
          ),
          progressIndicatorTheme: ProgressIndicatorTheme.of(context).copyWith(
            color: primaryColor,
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
