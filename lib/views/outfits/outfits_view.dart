import 'package:flutter/material.dart';
import 'package:habitica_assistant/views/outfits/battle_gear_view.dart';
import 'package:habitica_assistant/views/outfits/costumes_view.dart';

class OutfitsView extends StatefulWidget {
  const OutfitsView({Key? key}) : super(key: key);

  @override
  _OutfitsViewState createState() => _OutfitsViewState();
}

class _OutfitsViewState extends State<OutfitsView> {
  final _pageController = PageController();
  int _currentTabIndex = 0;

  @override
  void initState() {
    super.initState();
    _currentTabIndex = 0;
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _handleTabChange(int newIndex) {
    setState(() {
      _currentTabIndex = newIndex;
    });
  }

  void _handleTapTabChange(int newIndex) {
    _pageController.animateToPage(
      newIndex,
      duration: const Duration(milliseconds: 200),
      curve: Curves.bounceOut,
    );
  }

  void _addBattleGear(context) async {
    Navigator.pushNamed(context, '/addBattleGear');
  }

  void _addCostume(context) async {
    Navigator.pushNamed(context, '/addCostume');
  }

  IconButton _getAppBarAction(BuildContext context) {
    switch (_currentTabIndex) {
      case 0:
        return IconButton(
          onPressed: () => _addBattleGear(context),
          tooltip: 'Add Battle Gear',
          icon: const Icon(Icons.add),
        );
      case 1:
        return IconButton(
          onPressed: () => _addCostume(context),
          tooltip: 'Add Costume',
          icon: const Icon(Icons.add),
        );
    }
    throw Exception('Invalid index');
  }

  List<Widget> _getPages(BuildContext context) {
    return [
      const BattleGearView(),
      const CostumesView(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Habitica Assistant'),
        actions: [_getAppBarAction(context)],
      ),
      body: PageView(
        controller: _pageController,
        onPageChanged: _handleTabChange,
        children: _getPages(context),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.shield),
            label: 'Battle Gear',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.checkroom),
            label: 'Costume',
          ),
        ],
        currentIndex: _currentTabIndex,
        onTap: _handleTapTabChange,
      ),
    );
  }
}
