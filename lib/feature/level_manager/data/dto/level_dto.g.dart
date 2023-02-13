// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'level_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Item _$ItemFromJson(Map<String, dynamic> json) => Item(
      code: json['code'] as int?,
    );

Map<String, dynamic> _$ItemToJson(Item instance) => <String, dynamic>{
      'code': instance.code,
    };

Size _$SizeFromJson(Map<String, dynamic> json) => Size(
      json['h'] as int,
      json['w'] as int,
    );

Map<String, dynamic> _$SizeToJson(Size instance) => <String, dynamic>{
      'h': instance.h,
      'w': instance.w,
    };

LevelDto _$LevelDtoFromJson(Map<String, dynamic> json) => LevelDto(
      field: (json['field'] as List<dynamic>)
          .map((e) => (e as List<dynamic>)
              .map((e) =>
                  e == null ? null : Item.fromJson(e as Map<String, dynamic>))
              .toList())
          .toList(),
      levelId: json['levelId'] as int,
    )..size = Size.fromJson(json['size'] as Map<String, dynamic>);

Map<String, dynamic> _$LevelDtoToJson(LevelDto instance) => <String, dynamic>{
      'levelId': instance.levelId,
      'field': instance.field,
      'size': instance.size,
    };
