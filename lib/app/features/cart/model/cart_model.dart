import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:purple_planet_packaging/app/extensions/string_extensions.dart';

import '../../../models/products/products.dart';

part 'cart_model.freezed.dart';

@freezed
class CartModel with _$CartModel {
  const factory CartModel({
    required ProductsModel product,
    @Default(1) int quantity,
    @Default(0.0) double subTotal,
  }) = _CartModel;
}

extension CartModelX on CartModel {
  double? get getPrice =>
      double.tryParse(product.prices.regularPrice?.addDecimalFromEnd(product.prices.currencyMinorUnit!) ?? '') ?? 0.0;
}
