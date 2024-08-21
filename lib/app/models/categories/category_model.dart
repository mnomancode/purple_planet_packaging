part of 'category.dart';

@freezed
class CategoryModel with _$CategoryModel {
  const factory CategoryModel({
    required int id,
    required String name,
    required String? slug,
    CategoryImage? image,
    String? description,
    int? parent,
    int? count,
    String? permalink,
  }) = _CategoryModel;

  factory CategoryModel.fromJson(Map<String, dynamic> json) => _$CategoryModelFromJson(json);
}


// part of 'category.dart';

// @freezed
// class CategoryModel with _$CategoryModel {
//   const factory CategoryModel({
//     required int id,
//     required String name,
//     required String? slug,
//     required String? description,
//     int? parent,
//     required int? count,
//     required CategoryImage image,
//     required String? permalink,
//   }) = _CategoryModel;

//   factory CategoryModel.fromJson(Map<String, dynamic> json) => _$CategoryModelFromJson(json);
// }
