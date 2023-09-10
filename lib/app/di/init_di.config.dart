// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:qlutter/feature/level_manager/data/local_level_repository.dart'
    as _i5;
import 'package:qlutter/feature/level_manager/domain/level_repository.dart'
    as _i4;
import 'package:qlutter/feature/level_manager/level_manager.dart' as _i3;
import 'package:qlutter/feature/style/palette.dart' as _i6;

extension GetItInjectableX on _i1.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i1.GetIt init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.singleton<_i3.LevelManager>(_i3.LevelManager());
    gh.factory<_i4.LevelRepository>(() => _i5.LocalLevelRepository());
    gh.singleton<_i6.Palette>(_i6.Palette());
    return this;
  }
}
