// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'level_cubit.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_LevelStateEmpty _$$_LevelStateEmptyFromJson(Map<String, dynamic> json) =>
    _$_LevelStateEmpty(
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$_LevelStateEmptyToJson(_$_LevelStateEmpty instance) =>
    <String, dynamic>{
      'runtimeType': instance.$type,
    };

_$_LevelStateLoaded _$$_LevelStateLoadedFromJson(Map<String, dynamic> json) =>
    _$_LevelStateLoaded(
      (json['levels'] as List<dynamic>)
          .map((e) => LevelDto.fromJson(e as Map<String, dynamic>))
          .toList(),
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$_LevelStateLoadedToJson(_$_LevelStateLoaded instance) =>
    <String, dynamic>{
      'levels': instance.levels,
      'runtimeType': instance.$type,
    };
