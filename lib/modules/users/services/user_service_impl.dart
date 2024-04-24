import 'package:api_cuidapet/entities/users/user.dart';
import 'package:api_cuidapet/modules/users/data/user_repository.dart';

import './user_service.dart';

class UserServiceImpl implements UserService {
  final UserRepository _repository;

  UserServiceImpl({required UserRepository repository})
      : _repository = repository;

  @override
  Future<User?> getById(int id) => _repository.getById(id);

  // @override
  // Future<User?> save(User user) async {
  //   final saved = await _repository.save(user.copyWith(typeSignup: 'APP'));
  //   if (saved == null) {
  //     return null;
  //   }
  //   return getById(saved);
  // }

  @override
  Future<User?> save(User user) async {
    final userSave = await _repository.save(user.copyWith(typeSignup: 'APP'));
    if (userSave == null) {
      return null;
    }
    return _repository.save(userSave);
  }
}
