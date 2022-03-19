String _kApiToken = 'apiToken';
String _kUserID = 'userID';

class HabiticaAuthDataModel {
  late String? apiToken;
  late String? userID;

  HabiticaAuthDataModel({required this.apiToken, required this.userID});

  HabiticaAuthDataModel.fromMap(Map<String, String> map) {
    apiToken = map[_kApiToken];
    userID = map[_kUserID];
  }

  @override
  String toString() {
    return '''$runtimeType
      $_kApiToken: $apiToken,
      $_kUserID: $userID,
    ''';
  }
}
