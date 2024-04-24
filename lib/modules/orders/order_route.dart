import 'package:get_it/get_it.dart';
import 'package:shelf_router/shelf_router.dart';

import '../../application/constants/consts.dart';
import '../../application/database/database.dart';
import 'controller/order_controller.dart';
import 'data/order_repository.dart';
import 'data/order_repository_impl.dart';
import 'service/order_service.dart';
import 'service/order_service_impl.dart';

class OrderRoute {
  OrderRoute._();

  static Router routes(Router router) {
    GetIt.I.registerSingleton<OrderRepository>(
      OrderRepositoryImpl(
          database: GetIt.I.get<Database>(instanceName: Consts.mysqlInstance)),
      instanceName: Consts.orderRepository,
    );

    GetIt.I.registerSingleton<OrderService>(
      OrderServiceImpl(
          repository: GetIt.I
              .get<OrderRepository>(instanceName: Consts.orderRepository)),
      instanceName: Consts.orderService,
    );
    final orderController = OrderController(
        service: GetIt.I.get<OrderService>(instanceName: Consts.orderService));
    router.add('get', '/orders', orderController.getAll);
    router.add('get', '/order/<id>', orderController.getById);
    router.add('post', '/order', orderController.save);
    router.add('put', '/order/<id>', orderController.update);
    router.add('delete', '/order/<id>', orderController.delete);
    return router;
  }
}
