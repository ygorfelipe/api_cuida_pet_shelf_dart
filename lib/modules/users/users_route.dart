import 'package:api_cuidapet/application/constants/consts.dart';
import 'package:api_cuidapet/application/database/database.dart';
import 'package:api_cuidapet/modules/users/controller/auth_controller.dart';
import 'package:api_cuidapet/modules/users/data/user_repository.dart';
import 'package:api_cuidapet/modules/users/data/user_repository_impl.dart';
import 'package:api_cuidapet/modules/users/services/user_service.dart';
import 'package:api_cuidapet/modules/users/services/user_service_impl.dart';
import 'package:get_it/get_it.dart';
import 'package:shelf_router/shelf_router.dart';

sealed class UsersRoute {
  static Router routes(Router router) {
    final getIt = GetIt.I;

    getIt.registerSingleton<UserRepository>(
      UserRepositoryImpl(
        database: getIt.get<Database>(instanceName: Consts.mysqlInstance),
      ),
      instanceName: Consts.userRepository,
    );

    getIt.registerSingleton<UserService>(
        UserServiceImpl(
            repository:
                getIt.get<UserRepository>(instanceName: Consts.userRepository)),
        instanceName: Consts.userService);

    final authController = AuthController(
      userService: getIt.get<UserService>(instanceName: Consts.userService),
    );

    router.add('POST', '/auth/register', authController.save);
    router.add('GET', '/user/<id>', authController.getById);
    return router;
  }
}
