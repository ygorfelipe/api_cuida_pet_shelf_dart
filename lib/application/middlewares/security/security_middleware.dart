// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:api_cuidapet/application/helpers/jwt_helper.dart';
import 'package:jaguar_jwt/jaguar_jwt.dart';
import 'package:shelf/shelf.dart';

import 'package:api_cuidapet/application/logger/logger.dart';
import 'package:api_cuidapet/application/middlewares/middlewares.dart';
import 'package:api_cuidapet/application/middlewares/security/security_skip_url.dart';

class SecurityMiddleware extends Middlewares {
  final Logger log;
  final skypeUrl = <SecuritySkipUrl>[
    SecuritySkipUrl(url: '/auth', method: 'POST'),
    SecuritySkipUrl(url: '/courses', method: 'GET')
  ];

  SecurityMiddleware(this.log);

  @override
  Future<Response> execute(Request request) async {
    try {
      if (skypeUrl.contains(SecuritySkipUrl(
          url: '/${request.url.path}', method: request.method))) {
        return innerHandler(request);
      }

      final authHeader = request.headers['Authorization'];

      if (authHeader == null || authHeader.isEmpty) {
        throw JwtException.invalidToken;
      }

      final authHeaderContent = authHeader.split(' ');
      if (authHeaderContent[0] != 'Bearer') {
        throw JwtException.invalidToken;
      }

      final authorizationToken = authHeaderContent[1];
      final claims = JwtHelper.getClaims(authorizationToken);

      //! refresh token
      if (request.url.path != 'auth/refresh') {
        claims.validate();
      }

      final claimsMap = claims.toJson();
      final userId = claimsMap['sub'];
      final admId = claimsMap['adm'];

      if (userId == null) {
        throw JwtException.invalidToken;
      }

      final securityHeaders = {
        'user': userId,
        'access_token': authorizationToken,
        'adm': admId
      };

      return innerHandler(request.change(headers: securityHeaders));
    } on JwtException catch (e, s) {
      log.error('Erro ao validar token JWT', e, s);
      return Response.forbidden(jsonEncode({}));
    } catch (e, s) {
      log.error('Internal server Error', e, s);
      return Response.forbidden(jsonEncode({}));
    }
  }
}
