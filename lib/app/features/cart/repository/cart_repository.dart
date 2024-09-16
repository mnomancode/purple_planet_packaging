import 'package:retrofit/retrofit.dart';

abstract class CartRepository {
  // bool isBasketExpanded = false;

  // void toggleBasket();

  Map<String, dynamic>? responseHeaders;

  Future<HttpResponse> getCart(String cartToken);

  Future<HttpResponse> addToCart(int productId);
}
