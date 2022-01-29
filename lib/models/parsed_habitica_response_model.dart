class ParsedHabiticaResponseModel {
  late final bool success;
  late final String error;
  late final String message;

  ParsedHabiticaResponseModel(this.success, this.error, this.message);
  ParsedHabiticaResponseModel.fromMap(Map<String, dynamic> map) {
    success = map['success'];
    error = map['error'];
    message = map['message'];
  }

  bool isOk() {
    return success;
  }

  bool isRateLimited() {
    return error == 'TooManyRequests';
  }
}
