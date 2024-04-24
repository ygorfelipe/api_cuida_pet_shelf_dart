

import '../../../entities/orders/order.dart';

abstract class OrderRepository {
  Future<List<Order>?> getAll();
  Future<Order?> getById(int id);
  Future<int?> save(Order order);
  Future<bool> delete(int id);
  Future<bool> update(int id, Order order);
}
