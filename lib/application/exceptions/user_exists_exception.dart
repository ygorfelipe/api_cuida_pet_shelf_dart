// ignore_for_file: public_member_api_docs, sort_constructors_first
class UserExistsException implements Exception {
  String message;
  UserExistsException({
    required this.message,
  });
}
