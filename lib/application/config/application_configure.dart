// import 'package:api_cuidapet/application/constants/consts.dart';
// import 'package:api_cuidapet/application/database/database.dart';
// import 'package:api_cuidapet/application/database/mysql_database.dart';
// import 'package:api_cuidapet/application/env/config.dart';
// import 'package:api_cuidapet/application/logger/logger.dart';
// import 'package:api_cuidapet/application/logger/logger_impl.dart';
// import 'package:api_cuidapet/application/routers/server_requests.dart';
// import 'package:get_it/get_it.dart';
// import 'package:shelf_router/shelf_router.dart';

// class ApplicationConfigure {
//   // final Env env = Env.i..load();

//   Future<void> loadConfigApplication(Router router) async {
//     // GetIt.I.registerSingleton(env);
//     // _loadDataBaseConfig();
//     // _configLogger();
//     _loadRoutersConfigure(router);
//   }

//   // void _loadDataBaseConfig() async {
//   //   final MysqlDatabase mysql = await MysqlDatabase.i.openDatabase(
//   //     {
//   //       'host': env['host'] ?? '',
//   //       'port': env['port'] ?? '',
//   //       'userName': env['userName'] ?? '',
//   //       'password': env['password'] ?? '',
//   //       'databaseName': env['databaseName'] ?? '',
//   //       'secure': env['secure'] ?? '',
//   //     },
//   //   );

//   //   GetIt.I
//   //       .registerSingleton<Database>(mysql, instanceName: Consts.mysqlInstance);
//   // }



//   void _loadRoutersConfigure(Router router) => ServerRequest().load().call;
// }
