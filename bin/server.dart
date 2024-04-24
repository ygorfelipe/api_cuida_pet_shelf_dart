import 'dart:io';

import 'package:api_cuidapet/application/constants/consts.dart';
import 'package:api_cuidapet/application/database/database.dart';
import 'package:api_cuidapet/application/database/mysql_database.dart';
import 'package:api_cuidapet/application/env/config.dart';
import 'package:api_cuidapet/application/logger/logger.dart';
import 'package:api_cuidapet/application/logger/logger_impl.dart';
import 'package:api_cuidapet/application/middlewares/cors/cors_middlewares.dart';
import 'package:api_cuidapet/application/middlewares/defaultContentType/default_content_type.dart';
import 'package:api_cuidapet/application/middlewares/security/security_middleware.dart';
import 'package:api_cuidapet/application/routers/server_requests.dart';
import 'package:get_it/get_it.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as io;

void main(List<String> args) async {
  final Env env = Env.i..load();
  GetIt.I.registerSingleton(env);

  final getIt = GetIt.I;

  final MysqlDatabase mysql = await MysqlDatabase.i.openDatabase(
    {
      'host': env['host'] ?? '',
      'port': env['port'] ?? '',
      'userName': env['userName'] ?? '',
      'password': env['password'] ?? '',
      'databaseName': env['databaseName'] ?? '',
      'secure': env['secure'] ?? '',
    },
  );

  GetIt.I
      .registerSingleton<Database>(mysql, instanceName: Consts.mysqlInstance);
  GetIt.I.registerLazySingleton<Logger>(() => LoggerImpl());

  final ip = InternetAddress.anyIPv4;
  final handler = Pipeline()
      .addMiddleware(CorsMiddlewares().handler)
      .addMiddleware(
          // .addMiddleware(DefaultContentType(HttpHeaders.contentTypeHeader).handler)
          DefaultContentType('application/json;charset=utf-8').handler)
      .addMiddleware(SecurityMiddleware(getIt.get()).handler)
      .addMiddleware(logRequests())
      .addHandler(ServerRequest().load().call);

  final port = int.parse(Platform.environment['PORT'] ?? '8080');
  final server = await io.serve(handler, ip, port);
  print(
      'Server listening on port http://${server.address.host}:${server.port}');
}
