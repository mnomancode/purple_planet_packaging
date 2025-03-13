import 'dart:math';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:purple_planet_packaging/app/models/orders/order_body.dart';

part 'cart_model.freezed.dart';
part 'cart_model.g.dart';

@freezed
class Cart with _$Cart {
  const factory Cart({
    @JsonKey(name: 'cart_hash') required String cartHash,
    @JsonKey(name: 'cart_key') required String cartKey,
    required Currency currency,
    required Customer customer,
    required List<Item>? items,
    @JsonKey(name: 'item_count') required int itemCount,
    @JsonKey(name: 'items_weight') required String itemsWeight,
    @JsonKey(name: 'needs_payment') required bool needsPayment,
    @JsonKey(name: 'needs_shipping') required bool needsShipping,
    required Shipping shipping,
    @JsonKey(name: 'totals') required CartTotal totals,
    @Default([]) List<int> loadingItems,
  }) = _Cart;

  factory Cart.fromJson(Map<String, dynamic> json) => _$CartFromJson(json);
  // // ✅ Getter to format the total price using the currency minor unit
  // String get formattedTotalPrice => _formatPrice(totals.total, currency.currencyMinorUnit);

  // // ✅ Function to format the price based on the currency minor unit
  // String _formatPrice(String price, int minorUnit) {
  //   final intValue = int.parse(price);
  //   return (intValue / pow(10, minorUnit)).toStringAsFixed(minorUnit);
  // }
}

@freezed
class Currency with _$Currency {
  const factory Currency({
    @JsonKey(name: 'currency_code') required String currencyCode,
    @JsonKey(name: 'currency_symbol') required String currencySymbol,
    @JsonKey(name: 'currency_minor_unit') required int currencyMinorUnit,
    @JsonKey(name: 'currency_decimal_separator') required String currencyDecimalSeparator,
    @JsonKey(name: 'currency_thousand_separator') required String currencyThousandSeparator,
    @JsonKey(name: 'currency_prefix') required String currencyPrefix,
    @JsonKey(name: 'currency_suffix') required String currencySuffix,
  }) = _Currency;

  factory Currency.fromJson(Map<String, dynamic> json) => _$CurrencyFromJson(json);
}

@freezed
class Customer with _$Customer {
  const factory Customer({
    @JsonKey(name: 'billing_address') required BillingAddress billingAddress,
    @JsonKey(name: 'shipping_address') required ShippingAddress shippingAddress,
  }) = _Customer;

  factory Customer.fromJson(Map<String, dynamic> json) => _$CustomerFromJson(json);
}

@freezed
class BillingAddress with _$BillingAddress {
  const factory BillingAddress({
    @JsonKey(name: 'billing_first_name') String? firstName,
    @JsonKey(name: 'billing_last_name') String? lastName,
    @JsonKey(name: 'billing_company') String? company,
    @JsonKey(name: 'billing_country') String? country,
    @JsonKey(name: 'billing_address_1') String? address1,
    @JsonKey(name: 'billing_address_2') String? address2,
    @JsonKey(name: 'billing_postcode') String? postcode,
    @JsonKey(name: 'billing_city') String? city,
    @JsonKey(name: 'billing_state') String? state,
    @JsonKey(name: 'billing_phone') String? phone,
    @JsonKey(name: 'billing_email') String? email,
  }) = _BillingAddress;

  factory BillingAddress.fromJson(Map<String, dynamic> json) => _$BillingAddressFromJson(json);
}

@freezed
class ShippingAddress with _$ShippingAddress {
  const factory ShippingAddress({
    @JsonKey(name: 'shipping_first_name') String? firstName,
    @JsonKey(name: 'shipping_last_name') String? lastName,
    @JsonKey(name: 'shipping_company') String? company,
    @JsonKey(name: 'shipping_country') String? country,
    @JsonKey(name: 'shipping_address_1') String? address1,
    @JsonKey(name: 'shipping_address_2') String? address2,
    @JsonKey(name: 'shipping_postcode') String? postcode,
    @JsonKey(name: 'shipping_city') String? city,
    @JsonKey(name: 'shipping_state') String? state,
  }) = _ShippingAddress;

  factory ShippingAddress.fromJson(Map<String, dynamic> json) => _$ShippingAddressFromJson(json);
}

@freezed
class Item with _$Item {
  const factory Item({
    @JsonKey(name: 'item_key') required String itemKey,
    required int id,
    required String name,
    required String title,
    required String price,
    required Quantity quantity,
    required ItemTotals totals,
    required String slug,
    // required Meta meta,
    @JsonKey(name: 'cart_item_data') required List<dynamic> cartItemData,
    @JsonKey(name: 'featured_image') required String featuredImage,
  }) = _Item;

  factory Item.fromJson(Map<String, dynamic> json) => _$ItemFromJson(json);
}

@freezed
class ItemTotals with _$ItemTotals {
  const factory ItemTotals({
    @JsonKey(name: 'subtotal') required String subtotal,
    @JsonKey(name: 'subtotal_tax') required double subtotalTax,
    required double total,
    required double tax,
  }) = _ItemTotals;

  factory ItemTotals.fromJson(Map<String, dynamic> json) => _$ItemTotalsFromJson(json);
}

@freezed
class Quantity with _$Quantity {
  const factory Quantity({
    required int value,
    @JsonKey(name: 'min_purchase') required int minPurchase,
    @JsonKey(name: 'max_purchase') required int maxPurchase,
  }) = _Quantity;

  factory Quantity.fromJson(Map<String, dynamic> json) => _$QuantityFromJson(json);
}

@freezed
class TaxData with _$TaxData {
  const factory TaxData({
    required List<dynamic> subtotal,
    required List<dynamic> total,
  }) = _TaxData;

  factory TaxData.fromJson(Map<String, dynamic> json) => _$TaxDataFromJson(json);
}

@freezed
class CartTotal with _$CartTotal {
  const factory CartTotal({
    @JsonKey(name: 'subtotal') required String subtotal,
    @JsonKey(name: 'subtotal_tax') required String subtotalTax,
    @JsonKey(name: 'fee_total') String? feeTotal,
    @JsonKey(name: 'fee_tax') String? feeTax,
    @JsonKey(name: 'discount_total') String? discountTotal,
    @JsonKey(name: 'discount_tax') String? discountTax,
    @JsonKey(name: 'shipping_total') String? shippingTotal,
    @JsonKey(name: 'shipping_tax') String? shippingTax,
    required String total,
    @JsonKey(name: 'total_tax') String? totalTax,
  }) = _CartTotal;

  factory CartTotal.fromJson(Map<String, dynamic> json) => _$CartTotalFromJson(json);
}

@freezed
class Meta with _$Meta {
  const factory Meta({
    @JsonKey(name: 'product_type') required String productType,
    required String sku,
    required Dimensions dimensions,
    required double weight,
    required List<dynamic> variation,
  }) = _Meta;

  factory Meta.fromJson(Map<String, dynamic> json) => _$MetaFromJson(json);
}

@freezed
class Dimensions with _$Dimensions {
  const factory Dimensions({
    required String length,
    required String width,
    required String height,
    required String unit,
  }) = _Dimensions;

  factory Dimensions.fromJson(Map<String, dynamic> json) => _$DimensionsFromJson(json);
}

@freezed
class Shipping with _$Shipping {
  const factory Shipping({
    @JsonKey(name: 'total_packages') required int totalPackages,
    @JsonKey(name: 'show_package_details') required bool showPackageDetails,
    @JsonKey(name: 'has_calculated_shipping') required bool hasCalculatedShipping,
    @JsonKey(name: 'packages') required Package package,
  }) = _Shipping;

  factory Shipping.fromJson(Map<String, dynamic> json) => _$ShippingFromJson(json);
}

@freezed
class Package with _$Package {
  const factory Package({
    @JsonKey(name: 'package_name') String? packageName,
    Map<String, Rate>? rates,
    @JsonKey(name: 'package_details') String? packageDetails,
    int? index,
    @JsonKey(name: 'chosen_method') String? chosenMethod,
    @JsonKey(name: 'formatted_destination') String? formattedDestination,
  }) = _Package;

  factory Package.fromJson(Map<String, dynamic> json) => _$PackageFromJson(json);
}

@freezed
class Rate with _$Rate {
  const factory Rate({
    required String key,
    @JsonKey(name: 'method_id') required String methodId,
    @JsonKey(name: 'instance_id') required int instanceId,
    required String label,
    required String cost,
    required String html,
    required String taxes,
    @JsonKey(name: 'chosen_method') required bool chosenMethod,
  }) = _Rate;

  factory Rate.fromJson(Map<String, dynamic> json) => _$RateFromJson(json);
}
