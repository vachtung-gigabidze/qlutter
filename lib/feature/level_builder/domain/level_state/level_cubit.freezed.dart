// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'level_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

LevelState _$LevelStateFromJson(Map<String, dynamic> json) {
  switch (json['runtimeType']) {
    case 'empty':
      return _LevelStateEmpty.fromJson(json);
    case 'loaded':
      return _LevelStateLoaded.fromJson(json);

    default:
      throw CheckedFromJsonException(json, 'runtimeType', 'LevelState',
          'Invalid union type "${json['runtimeType']}"!');
  }
}

/// @nodoc
mixin _$LevelState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() empty,
    required TResult Function(List<LevelDto> levels) loaded,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? empty,
    TResult? Function(List<LevelDto> levels)? loaded,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? empty,
    TResult Function(List<LevelDto> levels)? loaded,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LevelStateEmpty value) empty,
    required TResult Function(_LevelStateLoaded value) loaded,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LevelStateEmpty value)? empty,
    TResult? Function(_LevelStateLoaded value)? loaded,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LevelStateEmpty value)? empty,
    TResult Function(_LevelStateLoaded value)? loaded,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  /// Serializes this LevelState to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LevelStateCopyWith<$Res> {
  factory $LevelStateCopyWith(
          LevelState value, $Res Function(LevelState) then) =
      _$LevelStateCopyWithImpl<$Res, LevelState>;
}

/// @nodoc
class _$LevelStateCopyWithImpl<$Res, $Val extends LevelState>
    implements $LevelStateCopyWith<$Res> {
  _$LevelStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of LevelState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$LevelStateEmptyImplCopyWith<$Res> {
  factory _$$LevelStateEmptyImplCopyWith(_$LevelStateEmptyImpl value,
          $Res Function(_$LevelStateEmptyImpl) then) =
      __$$LevelStateEmptyImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$LevelStateEmptyImplCopyWithImpl<$Res>
    extends _$LevelStateCopyWithImpl<$Res, _$LevelStateEmptyImpl>
    implements _$$LevelStateEmptyImplCopyWith<$Res> {
  __$$LevelStateEmptyImplCopyWithImpl(
      _$LevelStateEmptyImpl _value, $Res Function(_$LevelStateEmptyImpl) _then)
      : super(_value, _then);

  /// Create a copy of LevelState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
@JsonSerializable()
class _$LevelStateEmptyImpl implements _LevelStateEmpty {
  _$LevelStateEmptyImpl({final String? $type}) : $type = $type ?? 'empty';

  factory _$LevelStateEmptyImpl.fromJson(Map<String, dynamic> json) =>
      _$$LevelStateEmptyImplFromJson(json);

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'LevelState.empty()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$LevelStateEmptyImpl);
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() empty,
    required TResult Function(List<LevelDto> levels) loaded,
  }) {
    return empty();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? empty,
    TResult? Function(List<LevelDto> levels)? loaded,
  }) {
    return empty?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? empty,
    TResult Function(List<LevelDto> levels)? loaded,
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
    required TResult Function(_LevelStateEmpty value) empty,
    required TResult Function(_LevelStateLoaded value) loaded,
  }) {
    return empty(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LevelStateEmpty value)? empty,
    TResult? Function(_LevelStateLoaded value)? loaded,
  }) {
    return empty?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LevelStateEmpty value)? empty,
    TResult Function(_LevelStateLoaded value)? loaded,
    required TResult orElse(),
  }) {
    if (empty != null) {
      return empty(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$LevelStateEmptyImplToJson(
      this,
    );
  }
}

abstract class _LevelStateEmpty implements LevelState {
  factory _LevelStateEmpty() = _$LevelStateEmptyImpl;

  factory _LevelStateEmpty.fromJson(Map<String, dynamic> json) =
      _$LevelStateEmptyImpl.fromJson;
}

/// @nodoc
abstract class _$$LevelStateLoadedImplCopyWith<$Res> {
  factory _$$LevelStateLoadedImplCopyWith(_$LevelStateLoadedImpl value,
          $Res Function(_$LevelStateLoadedImpl) then) =
      __$$LevelStateLoadedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({List<LevelDto> levels});
}

/// @nodoc
class __$$LevelStateLoadedImplCopyWithImpl<$Res>
    extends _$LevelStateCopyWithImpl<$Res, _$LevelStateLoadedImpl>
    implements _$$LevelStateLoadedImplCopyWith<$Res> {
  __$$LevelStateLoadedImplCopyWithImpl(_$LevelStateLoadedImpl _value,
      $Res Function(_$LevelStateLoadedImpl) _then)
      : super(_value, _then);

  /// Create a copy of LevelState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? levels = null,
  }) {
    return _then(_$LevelStateLoadedImpl(
      null == levels
          ? _value._levels
          : levels // ignore: cast_nullable_to_non_nullable
              as List<LevelDto>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$LevelStateLoadedImpl implements _LevelStateLoaded {
  _$LevelStateLoadedImpl(final List<LevelDto> levels, {final String? $type})
      : _levels = levels,
        $type = $type ?? 'loaded';

  factory _$LevelStateLoadedImpl.fromJson(Map<String, dynamic> json) =>
      _$$LevelStateLoadedImplFromJson(json);

  final List<LevelDto> _levels;
  @override
  List<LevelDto> get levels {
    if (_levels is EqualUnmodifiableListView) return _levels;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_levels);
  }

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'LevelState.loaded(levels: $levels)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LevelStateLoadedImpl &&
            const DeepCollectionEquality().equals(other._levels, _levels));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_levels));

  /// Create a copy of LevelState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LevelStateLoadedImplCopyWith<_$LevelStateLoadedImpl> get copyWith =>
      __$$LevelStateLoadedImplCopyWithImpl<_$LevelStateLoadedImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() empty,
    required TResult Function(List<LevelDto> levels) loaded,
  }) {
    return loaded(levels);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? empty,
    TResult? Function(List<LevelDto> levels)? loaded,
  }) {
    return loaded?.call(levels);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? empty,
    TResult Function(List<LevelDto> levels)? loaded,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(levels);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LevelStateEmpty value) empty,
    required TResult Function(_LevelStateLoaded value) loaded,
  }) {
    return loaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LevelStateEmpty value)? empty,
    TResult? Function(_LevelStateLoaded value)? loaded,
  }) {
    return loaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LevelStateEmpty value)? empty,
    TResult Function(_LevelStateLoaded value)? loaded,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$LevelStateLoadedImplToJson(
      this,
    );
  }
}

abstract class _LevelStateLoaded implements LevelState {
  factory _LevelStateLoaded(final List<LevelDto> levels) =
      _$LevelStateLoadedImpl;

  factory _LevelStateLoaded.fromJson(Map<String, dynamic> json) =
      _$LevelStateLoadedImpl.fromJson;

  List<LevelDto> get levels;

  /// Create a copy of LevelState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LevelStateLoadedImplCopyWith<_$LevelStateLoadedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
