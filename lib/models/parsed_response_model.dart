import 'package:http/http.dart' as http;

class ParsedResponseModel<T> {
  late final int statusCode;
  late final T body;

  ParsedResponseModel(this.statusCode, this.body);
  ParsedResponseModel.fromResponse(http.Response response) {
    statusCode = response.statusCode;
    body = response.body as T;
  }

  bool isOk() {
    return statusCode >= 200 && statusCode < 300;
  }

  bool isUnauthorized() {
    return statusCode == 401;
  }
}
