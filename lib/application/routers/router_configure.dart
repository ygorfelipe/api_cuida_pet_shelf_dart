import 'package:api_cuidapet/modules/courses/courses_route.dart';
import 'package:api_cuidapet/modules/test/test_route.dart';
import 'package:api_cuidapet/application/routers/i_router.dart';
import 'package:shelf_router/shelf_router.dart';

class RouterConfigure {
  final Router _router;
  RouterConfigure(this._router);
  final List<IRouter> _routers = [
    TestRoute(),
    CoursesRoute(),
  ];

  // ignore: avoid_function_literals_in_foreach_calls
  void configure() => _routers.forEach((r) => r.configure(_router));
}
