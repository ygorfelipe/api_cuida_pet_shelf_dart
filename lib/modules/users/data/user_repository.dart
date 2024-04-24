import 'package:api_cuidapet/entities/users/user.dart';

abstract class UserRepository {
  Future<User?> getById(int id);
  // Future<int?> save(User user);
  Future<User?> save(User user);
}
