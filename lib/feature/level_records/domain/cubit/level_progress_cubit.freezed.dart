// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'level_progress_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

LevelProgressState _$LevelProgressStateFromJson(Map<String, dynamic> json) {
  switch (json['runtimeType']) {
    case 'empty':
      return _LevelProgressStateEmpty.fromJson(json);
    case 'loaded':
      return _LevelProgressStateLoaded.fromJson(json);
    case 'error':
      return _LevelProgressStateError.fromJson(json);

    default:
      throw CheckedFromJsonException(json, 'runtimeType', 'LevelProgressState',
          'Invalid union type "${json['runtimeType']}"!');
  }
}

/// @nodoc
mixin _$LevelProgressState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() empty,
    required TResult Function(List<LevelRecord> records) loaded,
    required TResult Function(dynamic error) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? empty,
    TResult? Function(List<LevelRecord> records)? loaded,
    TResult? Function(dynamic error)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? empty,
    TResult Function(List<LevelRecord> records)? loaded,
    TResult Function(dynamic error)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LevelProgressStateEmpty value) empty,
    required TResult Function(_LevelProgressStateLoaded value) loaded,
    required TResult Function(_LevelProgressStateError value) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LevelProgressStateEmpty value)? empty,
    TResult? Function(_LevelProgressStateLoaded value)? loaded,
    TResult? Function(_LevelProgressStateError value)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LevelProgressStateEmpty value)? empty,
    TResult Function(_LevelProgressStateLoaded value)? loaded,
    TResult Function(_LevelProgressStateError value)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LevelProgressStateCopyWith<$Res> {
  factory $LevelProgressStateCopyWith(
          LevelProgressState value, $Res Function(LevelProgressState) then) =
      _$LevelProgressStateCopyWithImpl<$Res, LevelProgressState>;
}

/// @nodoc
class _$LevelProgressStateCopyWithImpl<$Res, $Val extends LevelProgressState>
    implements $LevelProgressStateCopyWith<$Res> {
  _$LevelProgressStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$_LevelProgressStateEmptyCopyWith<$Res> {
  factory _$$_LevelProgressStateEmptyCopyWith(_$_LevelProgressStateEmpty value,
          $Res Function(_$_LevelProgressStateEmpty) then) =
      __$$_LevelProgressStateEmptyCopyWithImpl<$Res>;
}

/// @nodoc
class __$$_LevelProgressStateEmptyCopyWithImpl<$Res>
    extends _$LevelProgressStateCopyWithImpl<$Res, _$_LevelProgressStateEmpty>
    implements _$$_LevelProgressStateEmptyCopyWith<$Res> {
  __$$_LevelProgressStateEmptyCopyWithImpl(_$_LevelProgressStateEmpty _value,
      $Res Function(_$_LevelProgressStateEmpty) _then)
      : super(_value, _then);
}

/// @nodoc
@JsonSerializable()
class _$_LevelProgressStateEmpty implements _LevelProgressStateEmpty {
  _$_LevelProgressStateEmpty({final String? $type}) : $type = $type ?? 'empty';

  factory _$_LevelProgressStateEmpty.fromJson(Map<String, dynamic> json) =>
      _$$_LevelProgressStateEmptyFromJson(json);

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'LevelProgressState.empty()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_LevelProgressStateEmpty);
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() empty,
    required TResult Function(List<LevelRecord> records) loaded,
    required TResult Function(dynamic error) error,
  }) {
    return empty();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? empty,
    TResult? Function(List<LevelRecord> records)? loaded,
    TResult? Function(dynamic error)? error,
  }) {
    return empty?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? empty,
    TResult Function(List<LevelRecord> records)? loaded,
    TResult Function(dynamic error)? error,
    required TResult orElse(),
  }) {
    if (empty != null) {
      return empty();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LevelProgressStateEmpty value) empty,
    required TResult Function(_LevelProgressStateLoaded value) loaded,
    required TResult Function(_LevelProgressStateError value) error,
  }) {
    return empty(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LevelProgressStateEmpty value)? empty,
    TResult? Function(_LevelProgressStateLoaded value)? loaded,
    TResult? Function(_LevelProgressStateError value)? error,
  }) {
    return empty?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LevelProgressStateEmpty value)? empty,
    TResult Function(_LevelProgressStateLoaded value)? loaded,
    TResult Function(_LevelProgressStateError value)? error,
    required TResult orElse(),
  }) {
    if (empty != null) {
      return empty(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$_LevelProgressStateEmptyToJson(
      this,
    );
  }
}

abstract class _LevelProgressStateEmpty implements LevelProgressState {
  factory _LevelProgressStateEmpty() = _$_LevelProgressStateEmpty;

  factory _LevelProgressStateEmpty.fromJson(Map<String, dynamic> json) =
      _$_LevelProgressStateEmpty.fromJson;
}

/// @nodoc
abstract class _$$_LevelProgressStateLoadedCopyWith<$Res> {
  factory _$$_LevelProgressStateLoadedCopyWith(
          _$_LevelProgressStateLoaded value,
          $Res Function(_$_LevelProgressStateLoaded) then) =
      __$$_LevelProgressStateLoadedCopyWithImpl<$Res>;
  @useResult
  $Res call({List<LevelRecord> records});
}

/// @nodoc
class __$$_LevelProgressStateLoadedCopyWithImpl<$Res>
    extends _$LevelProgressStateCopyWithImpl<$Res, _$_LevelProgressStateLoaded>
    implements _$$_LevelProgressStateLoadedCopyWith<$Res> {
  __$$_LevelProgressStateLoadedCopyWithImpl(_$_LevelProgressStateLoaded _value,
      $Res Function(_$_LevelProgressStateLoaded) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? records = null,
  }) {
    return _then(_$_LevelProgressStateLoaded(
      null == records
          ? _value._records
          : records // ignore: cast_nullable_to_non_nullable
              as List<LevelRecord>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_LevelProgressStateLoaded implements _LevelProgressStateLoaded {
  _$_LevelProgressStateLoaded(final List<LevelRecord> records,
      {final String? $type})
      : _records = records,
        $type = $type ?? 'loaded';

  factory _$_LevelProgressStateLoaded.fromJson(Map<String, dynamic> json) =>
      _$$_LevelProgressStateLoadedFromJson(json);

  final List<LevelRecord> _records;
  @override
  List<LevelRecord> get records {
    if (_records is EqualUnmodifiableListView) return _records;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_records);
  }

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'LevelProgressState.loaded(records: $records)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_LevelProgressStateLoaded &&
            const DeepCollectionEquality().equals(other._records, _records));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_records));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_LevelProgressStateLoadedCopyWith<_$_LevelProgressStateLoaded>
      get copyWith => __$$_LevelProgressStateLoadedCopyWithImpl<
          _$_LevelProgressStateLoaded>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() empty,
    required TResult Function(List<LevelRecord> records) loaded,
    required TResult Function(dynamic error) error,
  }) {
    return loaded(records);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? empty,
    TResult? Function(List<LevelRecord> records)? loaded,
    TResult? Function(dynamic error)? error,
  }) {
    return loaded?.call(records);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? empty,
    TResult Function(List<LevelRecord> records)? loaded,
    TResult Function(dynamic error)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(records);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LevelProgressStateEmpty value) empty,
    required TResult Function(_LevelProgressStateLoaded value) loaded,
    required TResult Function(_LevelProgressStateError value) error,
  }) {
    return loaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LevelProgressStateEmpty value)? empty,
    TResult? Function(_LevelProgressStateLoaded value)? loaded,
    TResult? Function(_LevelProgressStateError value)? error,
  }) {
    return loaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LevelProgressStateEmpty value)? empty,
    TResult Function(_LevelProgressStateLoaded value)? loaded,
    TResult Function(_LevelProgressStateError value)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$_LevelProgressStateLoadedToJson(
      this,
    );
  }
}

abstract class _LevelProgressStateLoaded implements LevelProgressState {
  factory _LevelProgressStateLoaded(final List<LevelRecord> records) =
      _$_LevelProgressStateLoaded;

  factory _LevelProgressStateLoaded.fromJson(Map<String, dynamic> json) =
      _$_LevelProgressStateLoaded.fromJson;

  List<LevelRecord> get records;
  @JsonKey(ignore: true)
  _$$_LevelProgressStateLoadedCopyWith<_$_LevelProgressStateLoaded>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$_LevelProgressStateErrorCopyWith<$Res> {
  factory _$$_LevelProgressStateErrorCopyWith(_$_LevelProgressStateError value,
          $Res Function(_$_LevelProgressStateError) then) =
      __$$_LevelProgressStateErrorCopyWithImpl<$Res>;
  @useResult
  $Res call({dynamic error});
}

/// @nodoc
class __$$_LevelProgressStateErrorCopyWithImpl<$Res>
    extends _$LevelProgressStateCopyWithImpl<$Res, _$_LevelProgressStateError>
    implements _$$_LevelProgressStateErrorCopyWith<$Res> {
  __$$_LevelProgressStateErrorCopyWithImpl(_$_LevelProgressStateError _value,
      $Res Function(_$_LevelProgressStateError) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? error = freezed,
  }) {
    return _then(_$_LevelProgressStateError(
      freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_LevelProgressStateError implements _LevelProgressStateError {
  _$_LevelProgressStateError(this.error, {final String? $type})
      : $type = $type ?? 'error';

  factory _$_LevelProgressStateError.fromJson(Map<String, dynamic> json) =>
      _$$_LevelProgressStateErrorFromJson(json);

  @override
  final dynamic error;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'LevelProgressState.error(error: $error)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_LevelProgressStateError &&
            const DeepCollectionEquality().equals(other.error, error));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(error));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_LevelProgressStateErrorCopyWith<_$_LevelProgressStateError>
      get copyWith =>
          __$$_LevelProgressStateErrorCopyWithImpl<_$_LevelProgressStateError>(
              this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() empty,
    required TResult Function(List<LevelRecord> records) loaded,
    required TResult Function(dynamic error) error,
  }) {
    return error(this.error);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? empty,
    TResult? Function(List<LevelRecord> records)? loaded,
    TResult? Function(dynamic error)? error,
  }) {
    return error?.call(this.error);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? empty,
    TResult Function(List<LevelRecord> records)? loaded,
    TResult Function(dynamic error)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this.error);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LevelProgressStateEmpty value) empty,
    required TResult Function(_LevelProgressStateLoaded value) loaded,
    required TResult Function(_LevelProgressStateError value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LevelProgressStateEmpty value)? empty,
    TResult? Function(_LevelProgressStateLoaded value)? loaded,
    TResult? Function(_LevelProgressStateError value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LevelProgressStateEmpty value)? empty,
    TResult Function(_LevelProgressStateLoaded value)? loaded,
    TResult Function(_LevelProgressStateError value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$_LevelProgressStateErrorToJson(
      this,
    );
  }
}

abstract class _LevelProgressStateError implements LevelProgressState {
  factory _LevelProgressStateError(final dynamic error) =
      _$_LevelProgressStateError;

  factory _LevelProgressStateError.fromJson(Map<String, dynamic> json) =
      _$_LevelProgressStateError.fromJson;

  dynamic get error;
  @JsonKey(ignore: true)
  _$$_LevelProgressStateErrorCopyWith<_$_LevelProgressStateError>
      get copyWith => throw _privateConstructorUsedError;
}
