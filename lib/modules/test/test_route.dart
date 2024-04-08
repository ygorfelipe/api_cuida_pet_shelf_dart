import 'package:api_cuidapet/modules/test/controller/test_controller.dart';
import 'package:api_cuidapet/application/routers/i_router.dart';
import 'package:shelf_router/shelf_router.dart';

class TestRoute implements IRouter {
  @override
  void configure(Router router) {
    final testController = TestController();
    router.add('get', '/tests', testController.getAll);
    router.add('get', '/tests/secondpage', testController.getSecondPage);
  }
}
