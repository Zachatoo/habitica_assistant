class HabiticaAuthDataModel {
  late String? apiToken;
  late String? userID;

  HabiticaAuthDataModel({required this.apiToken, required this.userID});

  HabiticaAuthDataModel.fromMap(Map<String, String> map) {
    apiToken = map["apiToken"];
    userID = map["userID"];
  }
}
