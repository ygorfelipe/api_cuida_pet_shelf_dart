import 'dart:io';

import 'package:api_cuidapet/application/config/application_configure.dart';
import 'package:api_cuidapet/application/middlewares/cors/cors_middlewares.dart';
import 'package:api_cuidapet/application/middlewares/defaultContentType/default_content_type.dart';
import 'package:api_cuidapet/application/middlewares/security/security_middleware.dart';
import 'package:get_it/get_it.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as io;
import 'package:shelf_router/shelf_router.dart';

void main(List<String> args) async {
  final router = Router();
  final appConfig = ApplicationConfigure();
  await appConfig.loadConfigApplication(router);

  final getIt = GetIt.I;

  final ip = InternetAddress.anyIPv4;
  final handler = Pipeline()
      .addMiddleware(CorsMiddlewares().handler)
      .addMiddleware(
          // .addMiddleware(DefaultContentType(HttpHeaders.contentTypeHeader).handler)
          DefaultContentType('application/json;charset=utf-8').handler)
      .addMiddleware(SecurityMiddleware(getIt.get()).handler)
      .addMiddleware(logRequests())
      .addHandler(router.call);

  final port = int.parse(Platform.environment['PORT'] ?? '8080');
  final server = await io.serve(handler, ip, port);
  print('Server listening on port ${server.port}');
}
