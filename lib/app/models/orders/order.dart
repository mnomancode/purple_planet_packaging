import 'package:freezed_annotation/freezed_annotation.dart';

import 'order_body.dart';

part 'order.freezed.dart';
part 'order.g.dart';

@freezed
class Order with _$Order {
  factory Order({
    required int id,
    @JsonKey(name: 'parent_id') required int parentId,
    required String number,
    @JsonKey(name: 'order_key') required String orderKey,
    @JsonKey(name: 'created_via') required String createdVia,
    required String version,
    required String status,
    required String currency,
    @JsonKey(name: 'date_created') required String dateCreated,
    @JsonKey(name: 'date_created_gmt') required String dateCreatedGmt,
    @JsonKey(name: 'date_modified') String? dateModified,
    @JsonKey(name: 'date_modified_gmt') String? dateModifiedGmt,
    @JsonKey(name: 'discount_total') required String discountTotal,
    @JsonKey(name: 'discount_tax') required String discountTax,
    @JsonKey(name: 'shipping_total') required String shippingTotal,
    @JsonKey(name: 'shipping_tax') required String shippingTax,
    @JsonKey(name: 'cart_tax') required String cartTax,
    required String total,
    @JsonKey(name: 'total_tax') required String totalTax,
    @JsonKey(name: 'prices_include_tax') required bool pricesIncludeTax,
    @JsonKey(name: 'customer_id') required int customerId,
    @JsonKey(name: 'customer_ip_address') required String customerIpAddress,
    @JsonKey(name: 'customer_user_agent') required String customerUserAgent,
    @JsonKey(name: 'customer_note') required String customerNote,
    required Billing billing,
    required Shipping shipping,
    @JsonKey(name: 'payment_method') required String paymentMethod,
    @JsonKey(name: 'payment_method_title') required String paymentMethodTitle,
    @JsonKey(name: 'transaction_id') String? transactionId,
    @JsonKey(name: 'date_paid') String? datePaid,
    @JsonKey(name: 'date_paid_gmt') String? datePaidGmt,
    @JsonKey(name: 'date_completed') String? dateCompleted,
    @JsonKey(name: 'date_completed_gmt') String? dateCompletedGmt,
    @JsonKey(name: 'cart_hash') String? cartHash,
    // @JsonKey(name: 'meta_data') List<MetaData>? metaData,
    @JsonKey(name: 'line_items') List<LineItem>? lineItems,
    @JsonKey(name: 'tax_lines') List<TaxLine>? taxLines,
    @JsonKey(name: 'shipping_lines') List<ShippingLine>? shippingLines,
    @JsonKey(name: 'fee_lines') List<dynamic>? feeLines,
    @JsonKey(name: 'coupon_lines') List<dynamic>? couponLines,
    required List<dynamic> refunds,
  }) = _Order;

  factory Order.fromJson(Map<String, dynamic> json) => _$OrderFromJson(json);
}

@freezed
class MetaData with _$MetaData {
  factory MetaData({
    required int id,
    required String key,
    dynamic value,
  }) = _MetaData;

  factory MetaData.fromJson(Map<String, dynamic> json) => _$MetaDataFromJson(json);
}

@freezed
class Tax with _$Tax {
  factory Tax({
    required int id,
    required String total,
    required String subtotal,
  }) = _Tax;

  factory Tax.fromJson(Map<String, dynamic> json) => _$TaxFromJson(json);
}

@freezed
class TaxLine with _$TaxLine {
  factory TaxLine({
    required int id,
    @JsonKey(name: 'rate_code') required String rateCode,
    @JsonKey(name: 'rate_id') required int rateId,
    required String label,
    required bool compound,
    @JsonKey(name: 'tax_total') required String taxTotal,
    @JsonKey(name: 'shipping_tax_total') required String shippingTaxTotal,
    @JsonKey(name: 'meta_data') required List<dynamic> metaData,
  }) = _TaxLine;

  factory TaxLine.fromJson(Map<String, dynamic> json) => _$TaxLineFromJson(json);
}
