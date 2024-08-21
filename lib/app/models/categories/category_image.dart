part of 'category.dart';

@freezed
class CategoryImage with _$CategoryImage {
  const factory CategoryImage({
    required int id,
    required String src,
    required String? thumbnail,
    required String? name,
  }) = _CategoryImage;

  factory CategoryImage.fromJson(Map<String, dynamic> json) => _$CategoryImageFromJson(json);
}
