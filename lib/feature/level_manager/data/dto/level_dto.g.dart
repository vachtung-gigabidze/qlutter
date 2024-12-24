// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'level_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ItemDto _$ItemDtoFromJson(Map<String, dynamic> json) => ItemDto(
      code: (json['code'] as num?)?.toInt(),
    );

Map<String, dynamic> _$ItemDtoToJson(ItemDto instance) => <String, dynamic>{
      'code': instance.code,
    };

SizeDto _$SizeDtoFromJson(Map<String, dynamic> json) => SizeDto(
      (json['h'] as num).toInt(),
      (json['w'] as num).toInt(),
    );

Map<String, dynamic> _$SizeDtoToJson(SizeDto instance) => <String, dynamic>{
      'h': instance.h,
      'w': instance.w,
    };

LevelDto _$LevelDtoFromJson(Map<String, dynamic> json) => LevelDto(
      field: (json['field'] as List<dynamic>)
          .map((e) => (e as List<dynamic>)
              .map((e) => e == null
                  ? null
                  : ItemDto.fromJson(e as Map<String, dynamic>))
              .toList())
          .toList(),
      levelId: (json['levelId'] as num).toInt(),
    )..size = SizeDto.fromJson(json['size'] as Map<String, dynamic>);

Map<String, dynamic> _$LevelDtoToJson(LevelDto instance) => <String, dynamic>{
      'levelId': instance.levelId,
      'field': instance.field,
      'size': instance.size,
    };
