import 'package:purple_planet_packaging/app/models/cart/new_cart_model.dart';
import 'package:retrofit/retrofit.dart';

abstract class CartRepository {
  // bool isBasketExpanded = false;

  // void toggleBasket();

  Map<String, dynamic>? responseHeaders;

  Future<NewCartModel> getCart(String cartToken);

  Future<NewCartModel> addToCart(int productId, {int quantity = 1});

  Future<NewCartModel> updateItem(String itemKey, {required int quantity});
  Future<NewCartModel> removeItem(String itemKey);

  Future<HttpResponse> getShippingMethod();
}
