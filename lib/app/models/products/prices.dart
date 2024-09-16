// ignore_for_file: invalid_annotation_target

part of 'products.dart';

@freezed
class Prices with _$Prices {
  const factory Prices({
    required String? price,
    @JsonKey(name: 'regular_price') String? regularPrice,
    @JsonKey(name: 'sale_price') String? salePrice,
    @JsonKey(name: 'price_range') PriceRange? priceRange,
    @JsonKey(name: 'currency_code') String? currencyCode,
    @JsonKey(name: 'currency_symbol') String? currencySymbol,
    @JsonKey(name: 'currency_minor_unit') @Default(2) int? currencyMinorUnit,
    @JsonKey(name: 'currency_decimal_separator') @Default('.') String? currencyDecimalSeparator,
    @JsonKey(name: 'currency_thousand_separator') @Default(',') String? currencyThousandSeparator,
    @JsonKey(name: 'currency_prefix') String? currencyPrefix,
    @JsonKey(name: 'currency_suffix') String? currencySuffix,
  }) = _Prices;

  factory Prices.fromJson(Map<String, dynamic> json) => _$PricesFromJson(json);

  factory Prices.empty() => const Prices(price: '');
}

@freezed
class PriceRange with _$PriceRange {
  const factory PriceRange({
    @JsonKey(name: 'min_amount') String? minAmount,
    @JsonKey(name: 'max_amount') String? maxAmount,
  }) = _PriceRange;

  factory PriceRange.fromJson(Map<String, dynamic> json) => _$PriceRangeFromJson(json);
}

extension PricesX on Prices {
  double get doublePrice {
    return double.tryParse(price ?? '') ?? 0.0;
  }
}
