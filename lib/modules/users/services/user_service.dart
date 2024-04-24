import 'package:api_cuidapet/entities/users/user.dart';

abstract class UserService {
  Future<User?> getById(int id);
  Future<User?> save(User user);
}
