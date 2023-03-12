// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'level_record.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

LevelRecord _$LevelRecordFromJson(Map<String, dynamic> json) {
  return _LevelRecord.fromJson(json);
}

/// @nodoc
mixin _$LevelRecord {
  int? get id => throw _privateConstructorUsedError;
  int? get levelId => throw _privateConstructorUsedError;
  int? get steps => throw _privateConstructorUsedError;
  String? get datetime => throw _privateConstructorUsedError;
  int? get seconds => throw _privateConstructorUsedError;
  int? get user => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $LevelRecordCopyWith<LevelRecord> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LevelRecordCopyWith<$Res> {
  factory $LevelRecordCopyWith(
          LevelRecord value, $Res Function(LevelRecord) then) =
      _$LevelRecordCopyWithImpl<$Res, LevelRecord>;
  @useResult
  $Res call(
      {int? id,
      int? levelId,
      int? steps,
      String? datetime,
      int? seconds,
      int? user});
}

/// @nodoc
class _$LevelRecordCopyWithImpl<$Res, $Val extends LevelRecord>
    implements $LevelRecordCopyWith<$Res> {
  _$LevelRecordCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? levelId = freezed,
    Object? steps = freezed,
    Object? datetime = freezed,
    Object? seconds = freezed,
    Object? user = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      levelId: freezed == levelId
          ? _value.levelId
          : levelId // ignore: cast_nullable_to_non_nullable
              as int?,
      steps: freezed == steps
          ? _value.steps
          : steps // ignore: cast_nullable_to_non_nullable
              as int?,
      datetime: freezed == datetime
          ? _value.datetime
          : datetime // ignore: cast_nullable_to_non_nullable
              as String?,
      seconds: freezed == seconds
          ? _value.seconds
          : seconds // ignore: cast_nullable_to_non_nullable
              as int?,
      user: freezed == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_LevelRecordCopyWith<$Res>
    implements $LevelRecordCopyWith<$Res> {
  factory _$$_LevelRecordCopyWith(
          _$_LevelRecord value, $Res Function(_$_LevelRecord) then) =
      __$$_LevelRecordCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int? id,
      int? levelId,
      int? steps,
      String? datetime,
      int? seconds,
      int? user});
}

/// @nodoc
class __$$_LevelRecordCopyWithImpl<$Res>
    extends _$LevelRecordCopyWithImpl<$Res, _$_LevelRecord>
    implements _$$_LevelRecordCopyWith<$Res> {
  __$$_LevelRecordCopyWithImpl(
      _$_LevelRecord _value, $Res Function(_$_LevelRecord) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? levelId = freezed,
    Object? steps = freezed,
    Object? datetime = freezed,
    Object? seconds = freezed,
    Object? user = freezed,
  }) {
    return _then(_$_LevelRecord(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      levelId: freezed == levelId
          ? _value.levelId
          : levelId // ignore: cast_nullable_to_non_nullable
              as int?,
      steps: freezed == steps
          ? _value.steps
          : steps // ignore: cast_nullable_to_non_nullable
              as int?,
      datetime: freezed == datetime
          ? _value.datetime
          : datetime // ignore: cast_nullable_to_non_nullable
              as String?,
      seconds: freezed == seconds
          ? _value.seconds
          : seconds // ignore: cast_nullable_to_non_nullable
              as int?,
      user: freezed == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_LevelRecord implements _LevelRecord {
  const _$_LevelRecord(
      {required this.id,
      required this.levelId,
      required this.steps,
      required this.datetime,
      required this.seconds,
      this.user});

  factory _$_LevelRecord.fromJson(Map<String, dynamic> json) =>
      _$$_LevelRecordFromJson(json);

  @override
  final int? id;
  @override
  final int? levelId;
  @override
  final int? steps;
  @override
  final String? datetime;
  @override
  final int? seconds;
  @override
  final int? user;

  @override
  String toString() {
    return 'LevelRecord(id: $id, levelId: $levelId, steps: $steps, datetime: $datetime, seconds: $seconds, user: $user)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_LevelRecord &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.levelId, levelId) || other.levelId == levelId) &&
            (identical(other.steps, steps) || other.steps == steps) &&
            (identical(other.datetime, datetime) ||
                other.datetime == datetime) &&
            (identical(other.seconds, seconds) || other.seconds == seconds) &&
            (identical(other.user, user) || other.user == user));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, levelId, steps, datetime, seconds, user);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_LevelRecordCopyWith<_$_LevelRecord> get copyWith =>
      __$$_LevelRecordCopyWithImpl<_$_LevelRecord>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_LevelRecordToJson(
      this,
    );
  }
}

abstract class _LevelRecord implements LevelRecord {
  const factory _LevelRecord(
      {required final int? id,
      required final int? levelId,
      required final int? steps,
      required final String? datetime,
      required final int? seconds,
      final int? user}) = _$_LevelRecord;

  factory _LevelRecord.fromJson(Map<String, dynamic> json) =
      _$_LevelRecord.fromJson;

  @override
  int? get id;
  @override
  int? get levelId;
  @override
  int? get steps;
  @override
  String? get datetime;
  @override
  int? get seconds;
  @override
  int? get user;
  @override
  @JsonKey(ignore: true)
  _$$_LevelRecordCopyWith<_$_LevelRecord> get copyWith =>
      throw _privateConstructorUsedError;
}
