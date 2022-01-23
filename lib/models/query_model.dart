class QueryModel {
  OrderBy? orderBy;
  int limit;
  int offset;

  QueryModel({this.orderBy, this.limit = 50, this.offset = 0});
}

class OrderBy {
  String column;
  bool descending;

  OrderBy({required this.column, this.descending = false});

  @override
  String toString() {
    String direction;
    if (descending == true) {
      direction = 'ASC';
    } else {
      direction = 'DESC';
    }
    return "$column $direction";
  }
}
