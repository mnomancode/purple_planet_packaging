import 'package:purple_planet_packaging/app/models/orders/order_body.dart';
import 'package:retrofit/retrofit.dart';

import '../../../models/orders/order.dart';

abstract class OrdersRepository {
  Future<HttpResponse> getOrders();
  Future<Order> newOrder(OrderBody body);
  Future<Order> completePayment(int id);
}
