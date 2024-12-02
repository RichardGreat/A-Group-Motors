import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'cat_fact.g.dart';

@HiveType(typeId: 0)
@JsonSerializable()
class CatFact extends HiveObject {
  @HiveField(0)
  final String text;

  @HiveField(1)
  @JsonKey(name: 'createdAt')
  final DateTime createdAt;

  CatFact({required this.text, required this.createdAt});

  factory CatFact.fromJson(Map<String, dynamic> json) => _$CatFactFromJson(json);
  Map<String, dynamic> toJson() => _$CatFactToJson(this);
}