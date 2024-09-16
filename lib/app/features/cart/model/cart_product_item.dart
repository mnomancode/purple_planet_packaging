import 'package:freezed_annotation/freezed_annotation.dart';

part 'cart_product_item.freezed.dart';

@freezed
class CartProductItem with _$CartProductItem {
  factory CartProductItem({
    required int id,
    required String name,
    required String price,
    required String image,
    required int quantity,
  }) = _CartProductItem;
}
