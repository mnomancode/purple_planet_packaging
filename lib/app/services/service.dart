import 'package:dio/dio.dart';
import 'package:purple_planet_packaging/app/models/categories/category.dart';
import 'package:retrofit/retrofit.dart';

import '../core/utils/app_utils.dart';
import '../features/auth/model/auth_response.dart';
import '../features/cart/model/shipping_methods.dart';
import '../features/cart/repository/cart_repository_impl.dart';
import '../models/cart/cart_model.dart';
import '../models/categories/term.dart';
import '../models/orders/order.dart';
import '../models/orders/order_body.dart';
import '../models/products/product.dart';

part 'service.g.dart';

part 'auth_service.dart';
part 'shop_service.dart';
part 'cart_service.dart';
part 'order_service.dart';
