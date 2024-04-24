import 'package:api_cuidapet/modules/users/users_route.dart';
import 'package:shelf_router/shelf_router.dart';

import '../../modules/courses/courses_route.dart';
import '../../modules/orders/order_route.dart';

class ServerRequest {
  Router load() {
    final router = Router();
    CoursesRoute.routes(router);
    OrderRoute.routes(router);
    UsersRoute.routes(router);
    return router;
  }
}
