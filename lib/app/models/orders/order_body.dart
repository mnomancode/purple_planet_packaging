import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'order_body.freezed.dart';
part 'order_body.g.dart';

@freezed
class OrderBody with _$OrderBody {
  factory OrderBody({
    @JsonKey(name: 'payment_method') required String paymentMethod,
    @JsonKey(name: 'payment_method_title') required String paymentMethodTitle,
    @JsonKey(name: 'set_paid') required bool setPaid,
    required Billing billing,
    required Shipping shipping,
    @JsonKey(name: 'line_items') required List<LineItem> lineItems,
    @JsonKey(name: 'shipping_lines') required List<ShippingLine> shippingLines,
  }) = _OrderBody;

  factory OrderBody.fromJson(Map<String, dynamic> json) => _$OrderBodyFromJson(json);
}

@freezed
class Billing with _$Billing {
  factory Billing({
    @JsonKey(name: 'first_name') required String firstName,
    @JsonKey(name: 'last_name') required String lastName,
    @JsonKey(name: 'address_1') required String address1,
    @JsonKey(name: 'address_2') String? address2,
    required String city,
    required String state,
    required String postcode,
    required String country,
    required String email,
    String? phone,
  }) = _Billing;

  factory Billing.fromJson(Map<String, dynamic> json) => _$BillingFromJson(json);
}

@freezed
class Shipping with _$Shipping {
  factory Shipping({
    @JsonKey(name: 'first_name') required String firstName,
    @JsonKey(name: 'last_name') required String lastName,
    @JsonKey(name: 'address_1') required String address1,
    @JsonKey(name: 'address_2') String? address2,
    required String city,
    required String state,
    required String postcode,
    required String country,
  }) = _Shipping;

  factory Shipping.fromJson(Map<String, dynamic> json) => _$ShippingFromJson(json);
}

@freezed
class LineItem with _$LineItem {
  factory LineItem({
    @JsonKey(name: 'product_id') required int productId,
    @JsonKey(name: 'variation_id') int? variationId,
    required int quantity,
  }) = _LineItem;

  factory LineItem.fromJson(Map<String, dynamic> json) => _$LineItemFromJson(json);
}

@freezed
class ShippingLine with _$ShippingLine {
  factory ShippingLine({
    @JsonKey(name: 'method_id') required String methodId,
    @JsonKey(name: 'method_title') required String methodTitle,
    required String total,
  }) = _ShippingLine;

  factory ShippingLine.fromJson(Map<String, dynamic> json) => _$ShippingLineFromJson(json);
}
