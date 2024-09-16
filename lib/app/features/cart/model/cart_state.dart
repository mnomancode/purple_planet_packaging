import 'package:freezed_annotation/freezed_annotation.dart';

import 'cart_model.dart';

part 'cart_state.freezed.dart';

@freezed
class CartState with _$CartState {
  const factory CartState({
    @Default(false) bool isLoading,
    @Default([]) List<CartModel> items,
    @Default(0) int quantity,
    @Default(0) double total,
    @Default(0) double tax,
    @Default(0) double discount,
    double? subTotal,
    double? shipping,
  }) = _CartState;
}
