part of 'products.dart';

@freezed
class Variations with _$Variations {
  const factory Variations({
    required int id,
    required List<VariationAttribute> attributes,
  }) = _Variations;

  factory Variations.fromJson(Map<String, dynamic> json) => _$VariationsFromJson(json);
}

@freezed
class VariationAttribute with _$VariationAttribute {
  const factory VariationAttribute({
    String? name,
    String? value,
  }) = _VariationAttribute;

  factory VariationAttribute.fromJson(Map<String, dynamic> json) => _$VariationAttributeFromJson(json);
}
