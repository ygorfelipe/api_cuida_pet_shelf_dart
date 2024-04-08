import 'package:api_cuidapet/application/env/config.dart';
import 'package:jaguar_jwt/jaguar_jwt.dart';

sealed class JwtHelper {
  static final String _jwtSecret =
      Env.i.env['JWT_SECRET'] ?? Env.i.env['jwtSecret']!;

  static JwtClaim getClaims(String token) {
    return verifyJwtHS256Signature(token, _jwtSecret);
  }
}
