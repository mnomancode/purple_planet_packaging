import 'package:freezed_annotation/freezed_annotation.dart';

part 'new_cart_model.freezed.dart';
part 'new_cart_model.g.dart';

@freezed
class NewCartModel with _$NewCartModel {
  const factory NewCartModel({
    List<Item>? items,
    List<Coupon>? coupons,
    @JsonKey(name: 'totals') CartTotals? cartTotals,
    Address? shippingAddress,
    Address? billingAddress,
    bool? needsPayment,
    bool? needsShipping,
    List<String>? paymentMethods,
    @Default([]) List<int> loadingItems,
  }) = _NewCartModel;

  factory NewCartModel.fromJson(Map<String, dynamic> json) => _$NewCartModelFromJson(json);
}

@freezed
class Item with _$Item {
  const factory Item({
    String? key,
    int? id,
    int? quantity,
    QuantityLimits? quantityLimits,
    String? name,
    String? shortDescription,
    String? description,
    String? sku,
    Prices? prices,
    Totals? totals,
    List<ImageData>? images,
  }) = _Item;

  factory Item.fromJson(Map<String, dynamic> json) => _$ItemFromJson(json);
}

@freezed
class QuantityLimits with _$QuantityLimits {
  const factory QuantityLimits({
    int? minimum,
    int? maximum,
    int? multipleOf,
    bool? editable,
  }) = _QuantityLimits;

  factory QuantityLimits.fromJson(Map<String, dynamic> json) => _$QuantityLimitsFromJson(json);
}

@freezed
class Prices with _$Prices {
  const factory Prices({
    String? price,
    @JsonKey(name: 'regular_price') String? regularPrice,
    String? salePrice,
    String? currencyCode,
    @JsonKey(name: 'currency_minor_unit') @Default(2) int? currencyMinorUnit,
    @JsonKey(name: 'currency_prefix') String? currencyPrefix,
    String? currencySymbol,
  }) = _Prices;

  factory Prices.fromJson(Map<String, dynamic> json) => _$PricesFromJson(json);
}

@freezed
class Totals with _$Totals {
  const factory Totals({
    @JsonKey(name: 'line_subtotal') String? lineSubtotal,
    @JsonKey(name: 'line_subtotal_tax') String? lineSubtotalTax,
    @JsonKey(name: 'line_total') String? lineTotal,
    @JsonKey(name: 'line_total_tax') String? lineTotalTax,
    @JsonKey(name: 'currency_code') String? currencyCode,
    @JsonKey(name: 'currency_symbol') String? currencySymbol,
  }) = _Totals;

  factory Totals.fromJson(Map<String, dynamic> json) => _$TotalsFromJson(json);
}

@freezed
class CartTotals with _$CartTotals {
  const factory CartTotals({
    @JsonKey(name: 'total_items') String? totalItems,
    @JsonKey(name: 'total_items_tax') String? totalItemsTax,
    @JsonKey(name: 'total_fees') String? totalFees,
    @JsonKey(name: 'total_fees_tax') String? totalFeesTax,
    @JsonKey(name: 'total_discount') String? totalDiscount,
    @JsonKey(name: 'total_discount_tax') String? totalDiscountTax,
    @JsonKey(name: 'total_shipping') String? totalShipping,
    @JsonKey(name: 'total_shipping_tax') String? totalShippingTax,
    @JsonKey(name: 'total_price') String? totalPrice,
    @JsonKey(name: 'total_tax') String? totalTax,
    @JsonKey(name: 'currency_code') String? currencyCode,
    @JsonKey(name: 'currency_symbol') String? currencySymbol,
    @JsonKey(name: 'currency_minor_unit') int? currencyMinorUnit,
    @JsonKey(name: 'currency_prefix') String? currencyPrefix,
  }) = _CartTotals;

  factory CartTotals.fromJson(Map<String, dynamic> json) => _$CartTotalsFromJson(json);
}

@freezed
class ImageData with _$ImageData {
  const factory ImageData({
    String? src,
    String? thumbnail,
    String? name,
  }) = _ImageData;

  factory ImageData.fromJson(Map<String, dynamic> json) => _$ImageDataFromJson(json);
}

@freezed
class Coupon with _$Coupon {
  const factory Coupon({
    String? code,
    String? discountType,
    CouponTotals? totals,
  }) = _Coupon;

  factory Coupon.fromJson(Map<String, dynamic> json) => _$CouponFromJson(json);
}

@freezed
class CouponTotals with _$CouponTotals {
  const factory CouponTotals({
    String? totalDiscount,
    String? totalDiscountTax,
    String? currencyCode,
    String? currencySymbol,
  }) = _CouponTotals;

  factory CouponTotals.fromJson(Map<String, dynamic> json) => _$CouponTotalsFromJson(json);
}

@freezed
class Address with _$Address {
  const factory Address({
    String? firstName,
    String? lastName,
    String? address1,
    String? address2,
    String? city,
    String? state,
    String? postcode,
    String? country,
    String? phone,
  }) = _Address;

  factory Address.fromJson(Map<String, dynamic> json) => _$AddressFromJson(json);
}
