import 'package:purple_planet_packaging/app/core/utils/app_utils.dart';
import 'package:purple_planet_packaging/app/models/orders/order_body.dart';
import 'package:purple_planet_packaging/app/services/service.dart';
import 'package:retrofit/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../models/orders/order.dart';
import '../../../provider/http_provider.dart';
import 'orders_repository.dart';

part 'orders_repository_impl.g.dart';

class OrdersRepositoryImpl extends OrdersRepository {
  OrdersRepositoryImpl({required OrderService ordersService}) : _ordersService = ordersService;
  final OrderService _ordersService;

  @override
  Future<HttpResponse> getOrders() {
    return _ordersService.getOrders();
  }

  @override
  Future<Order> newOrder(OrderBody body) {
    return _ordersService.newOrder(AppUtils.getAuthorizationHeader, body);
  }

  @override
  Future<Order> completePayment(int id, String transactionId) {
    return _ordersService.completePayment(AppUtils.getAuthorizationHeader, id, body: {
      'status': 'processing',
      'set_paid': true,
      'payment_method': 'stripe',
      "payment_method_title": "Stripe",
      "transaction_id": transactionId,
    });
  }
}

@riverpod
OrdersRepository ordersRepository(OrdersRepositoryRef ref) {
  final http = ref.watch(httpProvider).value;

  if (http == null) {
    throw Exception('HTTP client is not initialized yet');
  }

  return OrdersRepositoryImpl(ordersService: OrderService(http));
}
