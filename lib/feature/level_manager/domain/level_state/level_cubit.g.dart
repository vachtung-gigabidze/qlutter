// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'level_cubit.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$LevelStateEmptyImpl _$$LevelStateEmptyImplFromJson(
        Map<String, dynamic> json) =>
    _$LevelStateEmptyImpl(
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$LevelStateEmptyImplToJson(
        _$LevelStateEmptyImpl instance) =>
    <String, dynamic>{
      'runtimeType': instance.$type,
    };

_$LevelStateLoadedImpl _$$LevelStateLoadedImplFromJson(
        Map<String, dynamic> json) =>
    _$LevelStateLoadedImpl(
      (json['levels'] as List<dynamic>)
          .map((e) => LevelDto.fromJson(e as Map<String, dynamic>))
          .toList(),
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$LevelStateLoadedImplToJson(
        _$LevelStateLoadedImpl instance) =>
    <String, dynamic>{
      'levels': instance.levels,
      'runtimeType': instance.$type,
    };
