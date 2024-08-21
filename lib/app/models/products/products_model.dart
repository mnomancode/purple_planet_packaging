part of 'products.dart';

@freezed
class ProductsModel with _$ProductsModel {
  const factory ProductsModel({
    required int id,
    required String name,
    required String? slug,
    required List<CategoryImage>? images,
    required Prices prices,
    List<Attribute>? attributes,
    String? description,
    String? sku,
  }) = _ProductsModel;

  factory ProductsModel.fromJson(Map<String, dynamic> json) => _$ProductsModelFromJson(json);

  factory ProductsModel.empty() => ProductsModel(id: 0, name: '', slug: '', images: [], prices: Prices.empty());
}
