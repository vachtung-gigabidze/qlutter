import 'package:freezed_annotation/freezed_annotation.dart';

part 'level_dto.g.dart';

@JsonSerializable()
class ItemDto {
  ItemDto({required this.code});
  int? code;

  factory ItemDto.fromJson(Map<String, dynamic> json) =>
      _$ItemDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ItemDtoToJson(this);
}

@JsonSerializable()
class SizeDto {
  SizeDto(this.h, this.w);
  final int h;
  final int w;

  factory SizeDto.fromJson(Map<String, dynamic> json) => _$SizeFromJson(json);

  Map<String, dynamic> toJson() => _$SizeToJson(this);
}

@JsonSerializable()
class LevelDto {
  LevelDto({required this.field, required this.levelId});

  int levelId;
  late List<List<ItemDto?>> field;
  late SizeDto size;

  factory LevelDto.fromJson(Map<String, dynamic> json) =>
      _$LevelDtoFromJson(json);

  Map<String, dynamic> toJson() => _$LevelDtoToJson(this);
}
