import 'package:api_cuidapet/application/config/database_connection_config.dart';
import 'package:api_cuidapet/application/env/config.dart';
import 'package:api_cuidapet/application/logger/logger.dart';
import 'package:api_cuidapet/application/logger/logger_impl.dart';
import 'package:api_cuidapet/application/routers/router_configure.dart';
import 'package:get_it/get_it.dart';
import 'package:shelf_router/shelf_router.dart';


class ApplicationConfigure {
  final Env env = Env.i..load();

  Future<void> loadConfigApplication(Router router) async {
    await _loadEnv();
    _loadDataBaseConfig();
    _configLogger();
    _loadRoutersConfigure(router);
  }

  Future<void> _loadEnv() async => env.load();

  void _loadDataBaseConfig() async {
    final databaseConfig = DatabaseConnectionConfig(
      host: env['DATABASE_HOST'] ?? env['databaseHost']!,
      user: env['DATABASE_USER'] ?? env['databaseUser']!,
      port: int.tryParse(env['DATABASE_PORT'] ?? env['databaseHost']!) ?? 0,
      password: env['DATABASE_PASSWORD'] ?? env['databasePassword']!,
      databaseName: env['DATABASE_NAME'] ?? env['databaseName']!,
      secure: int.tryParse(env['DATABASE_SECURE'] ?? env['secure']!) ?? 0,
    );

    GetIt.I.registerSingleton(databaseConfig);
    // GetIt.I.registerSingleton<DatabaseConnectionConfig>(databaseConfig,
    //     instanceName: Consts.mysqlInstance);
  }

  void _configLogger() =>
      GetIt.I.registerLazySingleton<Logger>(() => LoggerImpl());

  void _loadRoutersConfigure(Router router) =>
      RouterConfigure(router).configure();
}
