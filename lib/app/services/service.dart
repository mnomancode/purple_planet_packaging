import 'package:dio/dio.dart';
import 'package:purple_planet_packaging/app/models/categories/category.dart';
import 'package:retrofit/http.dart';
import 'package:retrofit/retrofit.dart';

import '../features/auth/model/auth_response.dart';
import '../features/cart/model/shipping_methods.dart';
import '../models/cart/new_cart_model.dart';
import '../models/products/products.dart';

part 'service.g.dart';

part 'auth_service.dart';
part 'shop_service.dart';
part 'cart_service.dart';
