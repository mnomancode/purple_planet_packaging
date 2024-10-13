import 'dart:math';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'cart_model.freezed.dart';
part 'cart_model.g.dart';

@freezed
class Cart with _$Cart {
  const Cart._();

  const factory Cart({
    required List<CartItem> items,
    required List<Coupon> coupons,
    required List<dynamic> fees,
    required CartTotals totals,
    @JsonKey(name: 'shipping_address') required Address shippingAddress,
    @JsonKey(name: 'billing_address') required Address billingAddress,
    @JsonKey(name: 'needs_payment') bool? needsPayment,
    @JsonKey(name: 'needs_shipping') bool? needsShipping,
    @JsonKey(name: 'payment_requirements') required List<String> paymentRequirements,
    @JsonKey(name: 'has_calculated_shipping') bool? hasCalculatedShipping,
    @JsonKey(name: 'shipping_rates') required List<ShippingPackage> shippingRates,
    @JsonKey(name: 'items_count') required int itemsCount,
    // required List<dynamic> crossSells,
    // required List<dynamic> errors,
    @JsonKey(name: 'payment_methods') required List<String> paymentMethods,
    // required Map<String, dynamic> extensions,
    @Default([]) List<int> loadingItems,
  }) = _Cart;

  factory Cart.fromJson(Map<String, dynamic> json) => _$CartFromJson(json);

  String get formattedTotalPrice => _formatPrice(totals.totalPrice, totals.currencyMinorUnit);

  String _formatPrice(String price, int minorUnit) {
    final intValue = int.parse(price);
    return (intValue / pow(10, minorUnit)).toStringAsFixed(minorUnit);
  }
}

@freezed
class CartItem with _$CartItem {
  const CartItem._();

  const factory CartItem({
    required String key,
    required int id,
    required int quantity,
    QuantityLimits? quantityLimits,
    required String name,
    String? shortDescription,
    required String description,
    required String sku,
    @JsonKey(name: 'low_stock_remaining') dynamic lowStockRemaining,
    String? permalink,
    required List<CartItemImage> images,
    List<dynamic>? variation,
    List<dynamic>? itemData,
    required CartItemPrices prices,
    required CartItemTotals totals,
    String? catalogVisibility,
    Map<String, dynamic>? extensions,
  }) = _CartItem;

  factory CartItem.fromJson(Map<String, dynamic> json) => _$CartItemFromJson(json);

  String get formattedPrice => _formatPrice(prices.price ?? '', prices.currencyMinorUnit ?? 2);
  String get formattedRegularPrice => _formatPrice(prices.regularPrice ?? '', prices.currencyMinorUnit ?? 2);
  String get formattedSalePrice => _formatPrice(prices.salePrice ?? '', prices.currencyMinorUnit ?? 2);

  String _formatPrice(String price, int minorUnit) {
    final intValue = int.parse(price);
    return (intValue / pow(10, minorUnit)).toStringAsFixed(minorUnit);
  }
}

@freezed
class QuantityLimits with _$QuantityLimits {
  const factory QuantityLimits({
    required int minimum,
    required int maximum,
    required int multipleOf,
    required bool editable,
  }) = _QuantityLimits;

  factory QuantityLimits.fromJson(Map<String, dynamic> json) => _$QuantityLimitsFromJson(json);
}

@freezed
class CartItemImage with _$CartItemImage {
  const factory CartItemImage({
    required int id,
    required String src,
    required String thumbnail,
    required String srcset,
    required String sizes,
    required String name,
    required String alt,
  }) = _CartItemImage;

  factory CartItemImage.fromJson(Map<String, dynamic> json) => _$CartItemImageFromJson(json);
}

@freezed
class CartItemPrices with _$CartItemPrices {
  const factory CartItemPrices({
    String? price,
    String? regularPrice,
    String? salePrice,
    @JsonKey(name: 'price_range') dynamic priceRange,
    String? currencyCode,
    String? currencySymbol,
    int? currencyMinorUnit,
    String? currencyDecimalSeparator,
    String? currencyThousandSeparator,
    String? currencyPrefix,
    String? currencySuffix,
    RawPrices? rawPrices,
  }) = _CartItemPrices;

  factory CartItemPrices.fromJson(Map<String, dynamic> json) => _$CartItemPricesFromJson(json);
}

@freezed
class RawPrices with _$RawPrices {
  const factory RawPrices({
    required int precision,
    required String price,
    required String regularPrice,
    required String salePrice,
  }) = _RawPrices;

  factory RawPrices.fromJson(Map<String, dynamic> json) => _$RawPricesFromJson(json);
}

@freezed
class CartItemTotals with _$CartItemTotals {
  const CartItemTotals._();

  const factory CartItemTotals({
    @JsonKey(name: 'line_subtotal') required String lineSubtotal,
    @JsonKey(name: 'line_subtotal_tax') required String lineSubtotalTax,
    @JsonKey(name: 'line_total') required String lineTotal,
    @JsonKey(name: 'line_total_tax') required String lineTotalTax,
    @JsonKey(name: 'currency_code') required String currencyCode,
    @JsonKey(name: 'currency_symbol') required String currencySymbol,
    @JsonKey(name: 'currency_minor_unit') required int currencyMinorUnit,
    @JsonKey(name: 'currency_decimal_separator') required String currencyDecimalSeparator,
    @JsonKey(name: 'currency_thousand_separator') required String currencyThousandSeparator,
    @JsonKey(name: 'currency_prefix') required String currencyPrefix,
    @JsonKey(name: 'currency_suffix') required String currencySuffix,
  }) = _CartItemTotals;

  factory CartItemTotals.fromJson(Map<String, dynamic> json) => _$CartItemTotalsFromJson(json);

  String get formattedLineSubtotal => _formatPrice(lineSubtotal);
  String get formattedLineSubtotalTax => _formatPrice(lineSubtotalTax);
  String get formattedLineTotal => _formatPrice(lineTotal);
  String get formattedLineTotalTax => _formatPrice(lineTotalTax);

  String _formatPrice(String price) {
    final intValue = int.parse(price);
    return (intValue / pow(10, currencyMinorUnit)).toStringAsFixed(currencyMinorUnit);
  }
}

@freezed
class Coupon with _$Coupon {
  const factory Coupon({
    required String code,
    required String discountType,
    required CouponTotals totals,
  }) = _Coupon;

  factory Coupon.fromJson(Map<String, dynamic> json) => _$CouponFromJson(json);
}

@freezed
class CouponTotals with _$CouponTotals {
  const CouponTotals._();

  const factory CouponTotals({
    required String totalDiscount,
    required String totalDiscountTax,
    required String currencyCode,
    required String currencySymbol,
    required int currencyMinorUnit,
    required String currencyDecimalSeparator,
    required String currencyThousandSeparator,
    required String currencyPrefix,
    required String currencySuffix,
  }) = _CouponTotals;

  factory CouponTotals.fromJson(Map<String, dynamic> json) => _$CouponTotalsFromJson(json);

  String get formattedTotalDiscount => _formatPrice(totalDiscount);
  String get formattedTotalDiscountTax => _formatPrice(totalDiscountTax);

  String _formatPrice(String price) {
    final intValue = int.parse(price);
    return (intValue / pow(10, currencyMinorUnit)).toStringAsFixed(currencyMinorUnit);
  }
}

@freezed
class CartTotals with _$CartTotals {
  const CartTotals._();

  const factory CartTotals({
    @JsonKey(name: 'total_items') required String totalItems,
    @JsonKey(name: 'total_items_tax') required String totalItemsTax,
    @JsonKey(name: 'total_fees') required String totalFees,
    @JsonKey(name: 'total_fees_tax') required String totalFeesTax,
    @JsonKey(name: 'total_discount') required String totalDiscount,
    @JsonKey(name: 'total_discount_tax') required String totalDiscountTax,
    @JsonKey(name: 'total_shipping') String? totalShipping,
    @JsonKey(name: 'total_shipping_tax') String? totalShippingTax,
    @JsonKey(name: 'total_price') required String totalPrice,
    @JsonKey(name: 'total_tax') required String totalTax,
    @JsonKey(name: 'tax_lines') required List<TaxLine> taxLines,
    @JsonKey(name: 'currency_code') required String currencyCode,
    @JsonKey(name: 'currency_symbol') required String currencySymbol,
    @JsonKey(name: 'currency_minor_unit') required int currencyMinorUnit,
    @JsonKey(name: 'currency_decimal_separator') required String currencyDecimalSeparator,
    @JsonKey(name: 'currency_thousand_separator') required String currencyThousandSeparator,
    @JsonKey(name: 'currency_prefix') required String currencyPrefix,
    @JsonKey(name: 'currency_suffix') required String currencySuffix,
  }) = _CartTotals;

  factory CartTotals.fromJson(Map<String, dynamic> json) => _$CartTotalsFromJson(json);

  String get formattedTotalItems => _formatPrice(totalItems);
  String get formattedTotalItemsTax => _formatPrice(totalItemsTax);
  String get formattedTotalFees => _formatPrice(totalFees);
  String get formattedTotalFeesTax => _formatPrice(totalFeesTax);
  String get formattedTotalDiscount => _formatPrice(totalDiscount);
  String get formattedTotalDiscountTax => _formatPrice(totalDiscountTax);
  String get formattedTotalShipping => _formatPrice(totalShipping ?? '');
  String get formattedTotalShippingTax => _formatPrice(totalShippingTax ?? '');
  String get formattedTotalPrice => _formatPrice(totalPrice);
  String get formattedTotalTax => _formatPrice(totalTax);

  String _formatPrice(String price) {
    final intValue = int.parse(price);
    return (intValue / pow(10, currencyMinorUnit)).toStringAsFixed(currencyMinorUnit);
  }
}

@freezed
class TaxLine with _$TaxLine {
  const factory TaxLine({
    required String name,
    required String price,
    required String rate,
  }) = _TaxLine;

  factory TaxLine.fromJson(Map<String, dynamic> json) => _$TaxLineFromJson(json);
}

@freezed
class Address with _$Address {
  const factory Address({
    @JsonKey(name: 'first_name') String? firstName,
    @JsonKey(name: 'last_name') String? lastName,
    String? company,
    @JsonKey(name: 'address_1') String? address1,
    @JsonKey(name: 'address_2') String? address2,
    String? city,
    String? state,
    String? postcode,
    String? country,
    String? email,
    String? phone,
  }) = _Address;

  factory Address.fromJson(Map<String, dynamic> json) => _$AddressFromJson(json);
}

@freezed
class ShippingPackage with _$ShippingPackage {
  const factory ShippingPackage({
    @JsonKey(name: 'package_id') required int packageId,
    required String name,
    required Address destination,
    required List<ShippingItem> items,
    @JsonKey(name: 'shipping_rates') required List<ShippingRate> shippingRates,
  }) = _ShippingPackage;

  factory ShippingPackage.fromJson(Map<String, dynamic> json) => _$ShippingPackageFromJson(json);
}

@freezed
class ShippingItem with _$ShippingItem {
  const factory ShippingItem({
    required String key,
    required String name,
    required int quantity,
  }) = _ShippingItem;

  factory ShippingItem.fromJson(Map<String, dynamic> json) => _$ShippingItemFromJson(json);
}

@freezed
class ShippingRate with _$ShippingRate {
  const ShippingRate._();

  const factory ShippingRate({
    @JsonKey(name: 'rate_id') required String rateId,
    required String name,
    required String description,
    @JsonKey(name: 'delivery_time') required String deliveryTime,
    required String price,
    required String taxes,
    @JsonKey(name: 'instance_id') required int instanceId,
    @JsonKey(name: 'method_id') required String methodId,
    @JsonKey(name: 'meta_data') required List<MetaData> metaData,
    required bool selected,
    @JsonKey(name: 'currency_code') required String currencyCode,
    @JsonKey(name: 'currency_symbol') required String currencySymbol,
    @JsonKey(name: 'currency_minor_unit') required int currencyMinorUnit,
    @JsonKey(name: 'currency_decimal_separator') required String currencyDecimalSeparator,
    @JsonKey(name: 'currency_thousand_separator') required String currencyThousandSeparator,
    @JsonKey(name: 'currency_prefix') required String currencyPrefix,
    @JsonKey(name: 'currency_suffix') String? currencySuffix,
  }) = _ShippingRate;

  factory ShippingRate.fromJson(Map<String, dynamic> json) => _$ShippingRateFromJson(json);

  String get formattedPrice => _formatPrice(price);
  String get formattedTaxes => _formatPrice(taxes);

  String _formatPrice(String price) {
    final intValue = int.parse(price);
    return (intValue / pow(10, currencyMinorUnit)).toStringAsFixed(currencyMinorUnit);
  }
}

@freezed
class MetaData with _$MetaData {
  const factory MetaData({
    required String key,
    required String value,
  }) = _MetaData;

  factory MetaData.fromJson(Map<String, dynamic> json) => _$MetaDataFromJson(json);
}
