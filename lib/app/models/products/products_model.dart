// ignore_for_file: invalid_annotation_target

part of 'products.dart';

@freezed
class ProductsModel with _$ProductsModel {
  const factory ProductsModel({
    required int id,
    required String name,
    required List<CategoryImage>? images,
    required Prices prices,
    String? slug,
    List<Attribute>? attributes,
    String? description,
    @JsonKey(name: 'short_description') String? shortDescription,
    String? sku,
    List<Variations>? variations,
  }) = _ProductsModel;

  factory ProductsModel.fromJson(Map<String, dynamic> json) => _$ProductsModelFromJson(json);

  factory ProductsModel.empty() => ProductsModel(id: 0, name: '', slug: '', images: [], prices: Prices.empty());
}
