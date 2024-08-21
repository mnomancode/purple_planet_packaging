part of 'products.dart';

@freezed
class Term with _$Term {
  const factory Term({
    required int id,
    String? name,
    String? slug,
  }) = _Term;

  factory Term.fromJson(Map<String, dynamic> json) => _$TermFromJson(json);
}
