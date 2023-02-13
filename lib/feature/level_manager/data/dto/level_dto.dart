import 'package:freezed_annotation/freezed_annotation.dart';

part 'level_dto.g.dart';

@JsonSerializable()
class Item {
  Item({required this.code});
  int? code;

  factory Item.fromJson(Map<String, dynamic> json) => _$ItemFromJson(json);

  Map<String, dynamic> toJson() => _$ItemToJson(this);
}

@JsonSerializable()
class Size {
  Size(this.h, this.w);
  final int h;
  final int w;

  factory Size.fromJson(Map<String, dynamic> json) => _$SizeFromJson(json);

  Map<String, dynamic> toJson() => _$SizeToJson(this);
}

@JsonSerializable()
class LevelDto {
  LevelDto({required this.field, required this.levelId});

  int levelId;
  late List<List<Item?>> field;
  late Size size;

  factory LevelDto.fromJson(Map<String, dynamic> json) =>
      _$LevelDtoFromJson(json);

  Map<String, dynamic> toJson() => _$LevelDtoToJson(this);
}
