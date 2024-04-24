//! controladora de todo o login do usuário.

import 'dart:convert';
import 'dart:developer';
import 'package:api_cuidapet/application/exceptions/user_exists_exception.dart';
import 'package:api_cuidapet/application/logger/logger_impl.dart';
import 'package:api_cuidapet/modules/users/services/user_service.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

import '../../../entities/users/user.dart';

class AuthController {
  final UserService _userService;
  final _logger = LoggerImpl();

  AuthController({required UserService userService})
      : _userService = userService;

  Future<Response> getById(Request request) async {
    try {
      final id = int.parse(request.params['id'].toString());
      final user = await _userService.getById(id);
      if (user != null) {
        return Response.ok(user.copyWith(password: ''));
      } else {
        _logger.error('Usuário $id não encontrado');
        return Response.notFound('Usuário $id não encontrado');
      }
    } catch (e, s) {
      _logger.error('Erro ao buscar usuario por ID', e, s);
      return Response.internalServerError(
          body: jsonEncode({'message': 'Erro ao buscar usuario por ID'}));
    }
  }

  Future<Response> save(Request request) async {
    try {
      final data = await request.readAsString();
      final userSaved = await _userService.save(User.fromJson(data));

      if (userSaved == null) {
        return Response.internalServerError(
            body: jsonEncode({'message': 'Erro ao salvar'}));
      }
      return Response.ok(userSaved.toJson());
    } on UserExistsException catch (e) {
      return Response.forbidden(jsonEncode({'message': e.message}));
    } catch (e, s) {
      log('Erro ao cadastrar usuario', error: e, stackTrace: s);
      return Response.internalServerError(
          body: jsonEncode({'message': 'Erro ao salvar usuário'}));
    }
  }

  // Future<Response> save(Request request) async {
  //   final data = await request.readAsString();
  //   final userSaved = await _userService.save(User.fromJson(data));
  //   if (userSaved == null) {
  //     return Response.internalServerError(
  //         body: jsonEncode({'message': 'Erro ao salvar usuário'}));
  //   }
  //   return Response.ok(
  //       jsonEncode({'message': 'Cadastro realizado com sucesso'}));
  // }
}
