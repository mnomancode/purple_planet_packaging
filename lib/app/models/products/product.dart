import 'package:freezed_annotation/freezed_annotation.dart';

part 'product.freezed.dart';
part 'product.g.dart';

enum StockStatus {
  @JsonValue('instock')
  instock,
  @JsonValue('outofstock')
  outofstock,
  @JsonValue('onbackorder')
  onbackorder
}

@freezed
class Product with _$Product {
  factory Product({
    required int id,
    required String name,
    required String slug,
    required String permalink,
    @JsonKey(name: 'date_created') required String dateCreated,
    @JsonKey(name: 'date_created_gmt') required String dateCreatedGmt,
    @JsonKey(name: 'date_modified') required String dateModified,
    @JsonKey(name: 'date_modified_gmt') required String dateModifiedGmt,
    required String type,
    required String status,
    required bool featured,
    @JsonKey(name: 'catalog_visibility') required String catalogVisibility,
    required String description,
    @JsonKey(name: 'short_description') required String shortDescription,
    required String sku,
    required String price,
    @JsonKey(name: 'regular_price') required String regularPrice,
    @JsonKey(name: 'sale_price') required String salePrice,
    @JsonKey(name: 'date_on_sale_from') DateTime? dateOnSaleFrom,
    @JsonKey(name: 'date_on_sale_from_gmt') DateTime? dateOnSaleFromGmt,
    @JsonKey(name: 'date_on_sale_to') DateTime? dateOnSaleTo,
    @JsonKey(name: 'date_on_sale_to_gmt') DateTime? dateOnSaleToGmt,
    @JsonKey(name: 'on_sale') required bool onSale,
    required bool purchasable,
    @JsonKey(name: 'total_sales') required int totalSales,
    required bool virtual,
    required bool downloadable,
    required List<dynamic> downloads,
    @JsonKey(name: 'download_limit') required int downloadLimit,
    @JsonKey(name: 'download_expiry') required int downloadExpiry,
    @JsonKey(name: 'external_url') required String externalUrl,
    @JsonKey(name: 'button_text') required String buttonText,
    @JsonKey(name: 'tax_status') required String taxStatus,
    @JsonKey(name: 'tax_class') required String taxClass,
    @JsonKey(name: 'manage_stock') required bool manageStock,
    @JsonKey(name: 'stock_quantity') int? stockQuantity,
    required String backorders,
    @JsonKey(name: 'backorders_allowed') required bool backordersAllowed,
    required bool backordered,
    @JsonKey(name: 'low_stock_amount') int? lowStockAmount,
    @JsonKey(name: 'sold_individually') required bool soldIndividually,
    required String weight,
    required Dimensions dimensions,
    @JsonKey(name: 'shipping_required') required bool shippingRequired,
    @JsonKey(name: 'shipping_taxable') required bool shippingTaxable,
    @JsonKey(name: 'shipping_class') required String shippingClass,
    @JsonKey(name: 'shipping_class_id') required int shippingClassId,
    @JsonKey(name: 'reviews_allowed') required bool reviewsAllowed,
    @JsonKey(name: 'average_rating') required String averageRating,
    @JsonKey(name: 'rating_count') required int ratingCount,
    @JsonKey(name: 'upsell_ids') required List<int> upsellIds,
    @JsonKey(name: 'cross_sell_ids') required List<int> crossSellIds,
    @JsonKey(name: 'parent_id') required int parentId,
    @JsonKey(name: 'purchase_note') required String purchaseNote,
    required List<Category> categories,
    required List<dynamic> tags,
    required List<Image> images,
    required List<Attribute> attributes,
    @JsonKey(name: 'default_attributes') required List<DefaultAttribute> defaultAttributes,
    required List<int> variations,
    @JsonKey(name: 'grouped_products') required List<dynamic> groupedProducts,
    @JsonKey(name: 'menu_order') required int menuOrder,
    @JsonKey(name: 'price_html') required String priceHtml,
    @JsonKey(name: 'related_ids') required List<int> relatedIds,
    @JsonKey(name: 'stock_status') required StockStatus stockStatus,
    @JsonKey(name: 'has_options') required bool hasOptions,
  }) = _Product;

  factory Product.fromJson(Map<String, dynamic> json) => _$ProductFromJson(json);
}

@freezed
class Dimensions with _$Dimensions {
  factory Dimensions({
    required String length,
    required String width,
    required String height,
  }) = _Dimensions;

  factory Dimensions.fromJson(Map<String, dynamic> json) => _$DimensionsFromJson(json);
}

@freezed
class Category with _$Category {
  factory Category({
    required int id,
    required String name,
    required String slug,
  }) = _Category;

  factory Category.fromJson(Map<String, dynamic> json) => _$CategoryFromJson(json);
}

@freezed
class Image with _$Image {
  factory Image({
    required int id,
    @JsonKey(name: 'date_created') required String dateCreated,
    @JsonKey(name: 'date_created_gmt') required String dateCreatedGmt,
    @JsonKey(name: 'date_modified') required String dateModified,
    @JsonKey(name: 'date_modified_gmt') required String dateModifiedGmt,
    required String src,
    required String name,
    required String alt,
  }) = _Image;

  factory Image.fromJson(Map<String, dynamic> json) => _$ImageFromJson(json);
}

@freezed
class Attribute with _$Attribute {
  factory Attribute({
    required int id,
    required String name,
    required String slug,
    required int position,
    required bool visible,
    required bool variation,
    required List<String> options,
  }) = _Attribute;

  factory Attribute.fromJson(Map<String, dynamic> json) => _$AttributeFromJson(json);
}

@freezed
class DefaultAttribute with _$DefaultAttribute {
  factory DefaultAttribute({
    required int id,
    required String name,
    required String option,
  }) = _DefaultAttribute;

  factory DefaultAttribute.fromJson(Map<String, dynamic> json) => _$DefaultAttributeFromJson(json);
}
