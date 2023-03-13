// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'level_progress_cubit.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_LevelProgressStateEmpty _$$_LevelProgressStateEmptyFromJson(
        Map<String, dynamic> json) =>
    _$_LevelProgressStateEmpty(
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$_LevelProgressStateEmptyToJson(
        _$_LevelProgressStateEmpty instance) =>
    <String, dynamic>{
      'runtimeType': instance.$type,
    };

_$_LevelProgressStateLoaded _$$_LevelProgressStateLoadedFromJson(
        Map<String, dynamic> json) =>
    _$_LevelProgressStateLoaded(
      (json['records'] as List<dynamic>)
          .map((e) => LevelRecord.fromJson(e as Map<String, dynamic>))
          .toList(),
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$_LevelProgressStateLoadedToJson(
        _$_LevelProgressStateLoaded instance) =>
    <String, dynamic>{
      'records': instance.records,
      'runtimeType': instance.$type,
    };

_$_LevelProgressStateError _$$_LevelProgressStateErrorFromJson(
        Map<String, dynamic> json) =>
    _$_LevelProgressStateError(
      json['error'],
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$_LevelProgressStateErrorToJson(
        _$_LevelProgressStateError instance) =>
    <String, dynamic>{
      'error': instance.error,
      'runtimeType': instance.$type,
    };
