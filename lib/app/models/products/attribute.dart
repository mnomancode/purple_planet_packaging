part of 'products.dart';

@freezed
class Attribute with _$Attribute {
  const factory Attribute(
      {int? id,
      String? name,
      String? taxonomy,
      @JsonKey(name: 'has_variations') @Default(false) bool hasVariations,
      List<Term>? terms}) = _Attribute;

  factory Attribute.fromJson(Map<String, dynamic> json) => _$AttributeFromJson(json);
}
