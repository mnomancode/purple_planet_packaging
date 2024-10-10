import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'shipping_methods.freezed.dart';
part 'shipping_methods.g.dart';

@freezed
class ShippingMethod with _$ShippingMethod {
  const factory ShippingMethod({
    required int id,
    @JsonKey(name: 'instance_id') required int instanceId,
    required String title,
    required int order,
    required bool enabled,
    @JsonKey(name: 'method_id') required String methodId,
    @JsonKey(name: 'method_title') required String methodTitle,
    @JsonKey(name: 'method_description') required String methodDescription,
    required ShippingMethodSettings settings,
    @JsonKey(name: '_links') required Links links,
  }) = _ShippingMethod;

  factory ShippingMethod.fromJson(Map<String, dynamic> json) => _$ShippingMethodFromJson(json);
}

@freezed
class ShippingMethodSettings with _$ShippingMethodSettings {
  const factory ShippingMethodSettings({
    required SettingField title,
    @JsonKey(name: 'table_rates') SettingField? tableRates,
    @JsonKey(name: 'tax_status') required SettingField taxStatus,
    @JsonKey(name: 'weight_type') SettingField? weightType,
    @JsonKey(name: 'volume_divisor') SettingField? volumeDivisor,
    @JsonKey(name: 'price_type') SettingField? priceType,
    @JsonKey(name: 'calculation_type') SettingField? calculationType,
    @JsonKey(name: 'comment_title') SettingField? commentTitle,
    SettingField? cost,
  }) = _ShippingMethodSettings;

  factory ShippingMethodSettings.fromJson(Map<String, dynamic> json) => _$ShippingMethodSettingsFromJson(json);
}

@freezed
class SettingField with _$SettingField {
  const factory SettingField({
    required String id,
    required String label,
    required String description,
    required String type,
    @SettingFieldConverter() required dynamic value,
    @JsonKey(name: 'default') @SettingFieldConverter() required dynamic defaultValue,
    required String tip,
    required String placeholder,
    Map<String, String>? options,
  }) = _SettingField;

  factory SettingField.fromJson(Map<String, dynamic> json) => _$SettingFieldFromJson(json);
}

@freezed
class Links with _$Links {
  const factory Links({
    required List<Link> self,
    required List<Link> collection,
    required List<Link> describes,
  }) = _Links;

  factory Links.fromJson(Map<String, dynamic> json) => _$LinksFromJson(json);
}

@freezed
class Link with _$Link {
  const factory Link({
    required String href,
  }) = _Link;

  factory Link.fromJson(Map<String, dynamic> json) => _$LinkFromJson(json);
}

class SettingFieldConverter implements JsonConverter<dynamic, dynamic> {
  const SettingFieldConverter();

  @override
  dynamic fromJson(dynamic json) {
    if (json is int) return json;
    if (json is double) return json;
    if (json is bool) return json;
    if (json is String) {
      if (json == 'yes') return true;
      if (json == 'no') return false;
      // Try parsing as a number if it looks like one
      if (double.tryParse(json) != null) {
        return double.parse(json);
      }
    }
    return json; // Return as is if no conversion applied
  }

  @override
  dynamic toJson(dynamic object) => object;
}
