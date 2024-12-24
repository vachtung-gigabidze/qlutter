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
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

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

  /// Serializes this LevelProgressState to a JSON map.
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

  /// Create a copy of LevelProgressState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$LevelProgressStateEmptyImplCopyWith<$Res> {
  factory _$$LevelProgressStateEmptyImplCopyWith(
          _$LevelProgressStateEmptyImpl value,
          $Res Function(_$LevelProgressStateEmptyImpl) then) =
      __$$LevelProgressStateEmptyImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$LevelProgressStateEmptyImplCopyWithImpl<$Res>
    extends _$LevelProgressStateCopyWithImpl<$Res,
        _$LevelProgressStateEmptyImpl>
    implements _$$LevelProgressStateEmptyImplCopyWith<$Res> {
  __$$LevelProgressStateEmptyImplCopyWithImpl(
      _$LevelProgressStateEmptyImpl _value,
      $Res Function(_$LevelProgressStateEmptyImpl) _then)
      : super(_value, _then);

  /// Create a copy of LevelProgressState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
@JsonSerializable()
class _$LevelProgressStateEmptyImpl implements _LevelProgressStateEmpty {
  _$LevelProgressStateEmptyImpl({final String? $type})
      : $type = $type ?? 'empty';

  factory _$LevelProgressStateEmptyImpl.fromJson(Map<String, dynamic> json) =>
      _$$LevelProgressStateEmptyImplFromJson(json);

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'LevelProgressState.empty()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LevelProgressStateEmptyImpl);
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
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
    return _$$LevelProgressStateEmptyImplToJson(
      this,
    );
  }
}

abstract class _LevelProgressStateEmpty implements LevelProgressState {
  factory _LevelProgressStateEmpty() = _$LevelProgressStateEmptyImpl;

  factory _LevelProgressStateEmpty.fromJson(Map<String, dynamic> json) =
      _$LevelProgressStateEmptyImpl.fromJson;
}

/// @nodoc
abstract class _$$LevelProgressStateLoadedImplCopyWith<$Res> {
  factory _$$LevelProgressStateLoadedImplCopyWith(
          _$LevelProgressStateLoadedImpl value,
          $Res Function(_$LevelProgressStateLoadedImpl) then) =
      __$$LevelProgressStateLoadedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({List<LevelRecord> records});
}

/// @nodoc
class __$$LevelProgressStateLoadedImplCopyWithImpl<$Res>
    extends _$LevelProgressStateCopyWithImpl<$Res,
        _$LevelProgressStateLoadedImpl>
    implements _$$LevelProgressStateLoadedImplCopyWith<$Res> {
  __$$LevelProgressStateLoadedImplCopyWithImpl(
      _$LevelProgressStateLoadedImpl _value,
      $Res Function(_$LevelProgressStateLoadedImpl) _then)
      : super(_value, _then);

  /// Create a copy of LevelProgressState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? records = null,
  }) {
    return _then(_$LevelProgressStateLoadedImpl(
      null == records
          ? _value._records
          : records // ignore: cast_nullable_to_non_nullable
              as List<LevelRecord>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$LevelProgressStateLoadedImpl implements _LevelProgressStateLoaded {
  _$LevelProgressStateLoadedImpl(final List<LevelRecord> records,
      {final String? $type})
      : _records = records,
        $type = $type ?? 'loaded';

  factory _$LevelProgressStateLoadedImpl.fromJson(Map<String, dynamic> json) =>
      _$$LevelProgressStateLoadedImplFromJson(json);

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
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LevelProgressStateLoadedImpl &&
            const DeepCollectionEquality().equals(other._records, _records));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_records));

  /// Create a copy of LevelProgressState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LevelProgressStateLoadedImplCopyWith<_$LevelProgressStateLoadedImpl>
      get copyWith => __$$LevelProgressStateLoadedImplCopyWithImpl<
          _$LevelProgressStateLoadedImpl>(this, _$identity);

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
    return _$$LevelProgressStateLoadedImplToJson(
      this,
    );
  }
}

abstract class _LevelProgressStateLoaded implements LevelProgressState {
  factory _LevelProgressStateLoaded(final List<LevelRecord> records) =
      _$LevelProgressStateLoadedImpl;

  factory _LevelProgressStateLoaded.fromJson(Map<String, dynamic> json) =
      _$LevelProgressStateLoadedImpl.fromJson;

  List<LevelRecord> get records;

  /// Create a copy of LevelProgressState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LevelProgressStateLoadedImplCopyWith<_$LevelProgressStateLoadedImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$LevelProgressStateErrorImplCopyWith<$Res> {
  factory _$$LevelProgressStateErrorImplCopyWith(
          _$LevelProgressStateErrorImpl value,
          $Res Function(_$LevelProgressStateErrorImpl) then) =
      __$$LevelProgressStateErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({dynamic error});
}

/// @nodoc
class __$$LevelProgressStateErrorImplCopyWithImpl<$Res>
    extends _$LevelProgressStateCopyWithImpl<$Res,
        _$LevelProgressStateErrorImpl>
    implements _$$LevelProgressStateErrorImplCopyWith<$Res> {
  __$$LevelProgressStateErrorImplCopyWithImpl(
      _$LevelProgressStateErrorImpl _value,
      $Res Function(_$LevelProgressStateErrorImpl) _then)
      : super(_value, _then);

  /// Create a copy of LevelProgressState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? error = freezed,
  }) {
    return _then(_$LevelProgressStateErrorImpl(
      freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$LevelProgressStateErrorImpl implements _LevelProgressStateError {
  _$LevelProgressStateErrorImpl(this.error, {final String? $type})
      : $type = $type ?? 'error';

  factory _$LevelProgressStateErrorImpl.fromJson(Map<String, dynamic> json) =>
      _$$LevelProgressStateErrorImplFromJson(json);

  @override
  final dynamic error;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'LevelProgressState.error(error: $error)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LevelProgressStateErrorImpl &&
            const DeepCollectionEquality().equals(other.error, error));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(error));

  /// Create a copy of LevelProgressState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LevelProgressStateErrorImplCopyWith<_$LevelProgressStateErrorImpl>
      get copyWith => __$$LevelProgressStateErrorImplCopyWithImpl<
          _$LevelProgressStateErrorImpl>(this, _$identity);

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
    return _$$LevelProgressStateErrorImplToJson(
      this,
    );
  }
}

abstract class _LevelProgressStateError implements LevelProgressState {
  factory _LevelProgressStateError(final dynamic error) =
      _$LevelProgressStateErrorImpl;

  factory _LevelProgressStateError.fromJson(Map<String, dynamic> json) =
      _$LevelProgressStateErrorImpl.fromJson;

  dynamic get error;

  /// Create a copy of LevelProgressState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LevelProgressStateErrorImplCopyWith<_$LevelProgressStateErrorImpl>
      get copyWith => throw _privateConstructorUsedError;
}
