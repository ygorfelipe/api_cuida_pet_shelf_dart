class DatabaseException implements Exception {
  DatabaseException({this.message, this.exception});
  final String? message;
  Exception? exception;

@override
String toString() {
    return 'DatabaseException{message=$message, exception=$exception}';
  }
}
