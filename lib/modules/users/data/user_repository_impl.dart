import 'dart:developer';

import 'package:api_cuidapet/application/database/database.dart';
import 'package:api_cuidapet/application/exceptions/database_exception.dart';

import 'package:api_cuidapet/application/helpers/cripty_helper.dart';
import 'package:api_cuidapet/entities/users/user.dart';
import 'package:mysql_client/exception.dart';

import '../../../application/exceptions/user_exists_exception.dart';
import './user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final Database _database;

  UserRepositoryImpl({required Database database}) : _database = database;

  @override
  Future<User?> getById(int id) async {
    final data =
        await _database.getUnique("SELECT * FROM TB_USERS WHERE ID = $id");
    if (data != null) {
      return User.fromMap(data).copyWith(password: '');
    }
    return null;
  }

  @override
  Future<User?> save(User user) async {
    try {
      final dataUser = user.copyWith(
        password: CriptyHelper.generateSha256Hash(user.password),
      );
      final data = await _database.insert(
          tableName: 'TB_USERS', value: dataUser.toDataBase());
      if (data != 0) {
        return user.copyWith(id: data, password: '');
        // return user.copyWith(id: data, password: '');
      }
    } on MySQLServerException catch (e, s) {
      if (e.message.contains('tb_users.email_UNIQUE')) {
        log('Usuario ja cadastrado na base de dados', error: e, stackTrace: s);
        throw UserExistsException(
            message: 'Usuário ja cadastrado. Por favor tente outro.');
      }
    } catch (e) {
      throw DatabaseException(message: 'Erro ao criar usuario');
    }
    return null;
  }

  // @override
  // Future<int?> save(User user) async {
  //   try {
  //     final dataUser = user.copyWith(
  //       password: CriptyHelper.generateSha256Hash(user.password),
  //       typeSignup: 'APP',
  //     );

  //     final data = await _database.insert(
  //         tableName: 'TB_USERS', value: dataUser.toDataBase());

  //     if (data != 0) {
  //       return data;
  //     }
  //   } on MySQLException catch (e, s) {
  //     if (e.message.contains('tb_users.email_UNIQUE')) {
  //       _logger.error('Usuario ja cadastrado na base de dados', e, s);
  //       throw UserExistsException(
  //           message: 'Usuário ja cadastrado. Por favor tente outro.');
  //     }
  //   }
  //   return null;
  // }
}
