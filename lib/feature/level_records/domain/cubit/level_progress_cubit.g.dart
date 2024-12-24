// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'level_progress_cubit.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$LevelProgressStateEmptyImpl _$$LevelProgressStateEmptyImplFromJson(
        Map<String, dynamic> json) =>
    _$LevelProgressStateEmptyImpl(
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$LevelProgressStateEmptyImplToJson(
        _$LevelProgressStateEmptyImpl instance) =>
    <String, dynamic>{
      'runtimeType': instance.$type,
    };

_$LevelProgressStateLoadedImpl _$$LevelProgressStateLoadedImplFromJson(
        Map<String, dynamic> json) =>
    _$LevelProgressStateLoadedImpl(
      (json['records'] as List<dynamic>)
          .map((e) => LevelRecord.fromJson(e as Map<String, dynamic>))
          .toList(),
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$LevelProgressStateLoadedImplToJson(
        _$LevelProgressStateLoadedImpl instance) =>
    <String, dynamic>{
      'records': instance.records,
      'runtimeType': instance.$type,
    };

_$LevelProgressStateErrorImpl _$$LevelProgressStateErrorImplFromJson(
        Map<String, dynamic> json) =>
    _$LevelProgressStateErrorImpl(
      json['error'],
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$LevelProgressStateErrorImplToJson(
        _$LevelProgressStateErrorImpl instance) =>
    <String, dynamic>{
      'error': instance.error,
      'runtimeType': instance.$type,
    };
