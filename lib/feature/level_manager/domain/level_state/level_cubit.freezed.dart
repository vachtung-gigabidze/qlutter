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
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

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
}

/// @nodoc
abstract class _$$_LevelStateEmptyCopyWith<$Res> {
  factory _$$_LevelStateEmptyCopyWith(
          _$_LevelStateEmpty value, $Res Function(_$_LevelStateEmpty) then) =
      __$$_LevelStateEmptyCopyWithImpl<$Res>;
}

/// @nodoc
class __$$_LevelStateEmptyCopyWithImpl<$Res>
    extends _$LevelStateCopyWithImpl<$Res, _$_LevelStateEmpty>
    implements _$$_LevelStateEmptyCopyWith<$Res> {
  __$$_LevelStateEmptyCopyWithImpl(
      _$_LevelStateEmpty _value, $Res Function(_$_LevelStateEmpty) _then)
      : super(_value, _then);
}

/// @nodoc

class _$_LevelStateEmpty implements _LevelStateEmpty {
  _$_LevelStateEmpty();

  @override
  String toString() {
    return 'LevelState.empty()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$_LevelStateEmpty);
  }

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
}

abstract class _LevelStateEmpty implements LevelState {
  factory _LevelStateEmpty() = _$_LevelStateEmpty;
}

/// @nodoc
abstract class _$$_LevelStateLoadedCopyWith<$Res> {
  factory _$$_LevelStateLoadedCopyWith(
          _$_LevelStateLoaded value, $Res Function(_$_LevelStateLoaded) then) =
      __$$_LevelStateLoadedCopyWithImpl<$Res>;
  @useResult
  $Res call({List<LevelDto> levels});
}

/// @nodoc
class __$$_LevelStateLoadedCopyWithImpl<$Res>
    extends _$LevelStateCopyWithImpl<$Res, _$_LevelStateLoaded>
    implements _$$_LevelStateLoadedCopyWith<$Res> {
  __$$_LevelStateLoadedCopyWithImpl(
      _$_LevelStateLoaded _value, $Res Function(_$_LevelStateLoaded) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? levels = null,
  }) {
    return _then(_$_LevelStateLoaded(
      null == levels
          ? _value._levels
          : levels // ignore: cast_nullable_to_non_nullable
              as List<LevelDto>,
    ));
  }
}

/// @nodoc

class _$_LevelStateLoaded implements _LevelStateLoaded {
  _$_LevelStateLoaded(final List<LevelDto> levels) : _levels = levels;

  final List<LevelDto> _levels;
  @override
  List<LevelDto> get levels {
    if (_levels is EqualUnmodifiableListView) return _levels;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_levels);
  }

  @override
  String toString() {
    return 'LevelState.loaded(levels: $levels)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_LevelStateLoaded &&
            const DeepCollectionEquality().equals(other._levels, _levels));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_levels));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_LevelStateLoadedCopyWith<_$_LevelStateLoaded> get copyWith =>
      __$$_LevelStateLoadedCopyWithImpl<_$_LevelStateLoaded>(this, _$identity);

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
}

abstract class _LevelStateLoaded implements LevelState {
  factory _LevelStateLoaded(final List<LevelDto> levels) = _$_LevelStateLoaded;

  List<LevelDto> get levels;
  @JsonKey(ignore: true)
  _$$_LevelStateLoadedCopyWith<_$_LevelStateLoaded> get copyWith =>
      throw _privateConstructorUsedError;
}
