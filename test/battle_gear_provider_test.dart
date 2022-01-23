// import 'package:flutter_test/flutter_test.dart';
// import 'package:habitica_assistant/models/battle_gear_model.dart';
// import 'package:habitica_assistant/providers/battle_gear_provider.dart';
// import 'package:mockito/annotations.dart';
// import 'package:mockito/mockito.dart';

// @GenerateMocks([BattleGearProvider])
// void main() {
//   group('Inserting entity', () {
//     test('increases total count', () async {
//       TestWidgetsFlutterBinding.ensureInitialized();
//       final provider = BattleGearProvider();
//       // when(provider.totalCount).thenReturn(0);
//       final startingCount = provider.entityCount;
//       final entityToInsert = BattleGearModel(name: 'test');
//       provider.addListener(() {
//         // when(provider.totalCount).thenReturn(1);
//         expect(provider.entityCount, greaterThan(startingCount));
//       });
//       provider.insert(entityToInsert);
//     });

//     test('updates entity list', () async {
//       final provider = BattleGearProvider();
//       final entityToInsert = BattleGearModel(name: 'test');
//       provider.addListener(() {
//         expect(provider.entities.last, equals(entityToInsert));
//       });
//       await provider.insert(entityToInsert);
//     });
//   });

//   group('Updating entity', () {
//     test('updates entity list', () async {
//       final provider = BattleGearProvider();
//       final entityToInsert = BattleGearModel(name: 'test');
//       await provider.insert(entityToInsert);
//       provider.addListener(() {
//         expect(provider.entities.last, equals(entityToInsert));
//       });
//       entityToInsert.armor = 'armor_special_2';
//       await provider.update(entityToInsert);
//     });
//   });
// }
