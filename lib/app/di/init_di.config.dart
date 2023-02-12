// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:qlutter/app/data/dio_app_api.dart' as _i8;
import 'package:qlutter/app/data/main_app_config.dart' as _i4;
import 'package:qlutter/app/domain/app_api.dart' as _i7;
import 'package:qlutter/app/domain/app_config.dart' as _i3;
import 'package:qlutter/feature/auth/data/network_auth_repository.dart' as _i10;
import 'package:qlutter/feature/auth/domain/auth_repository.dart' as _i9;
import 'package:qlutter/feature/auth/domain/auth_state/auth_cubit.dart' as _i11;
import 'package:qlutter/feature/level_manager/level_manager.dart' as _i5;
import 'package:qlutter/feature/style/palette.dart' as _i6;

/// ignore_for_file: unnecessary_lambdas
/// ignore_for_file: lines_longer_than_80_chars
extension GetItInjectableX on _i1.GetIt {
  /// initializes the registration of main-scope dependencies inside of [GetIt]
  _i1.GetIt init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.singleton<_i3.AppConfig>(_i4.ProdAppConfig());
    gh.singleton<_i5.LevelManager>(_i5.LevelManager());
    gh.factory<_i6.Palette>(() => _i6.Palette());
    gh.singleton<_i7.AppApi>(_i8.DioAppApi(gh<_i3.AppConfig>()));
    gh.factory<_i9.AuthRepository>(
        () => _i10.NetworkAuthRepository(gh<_i7.AppApi>()));
    gh.singleton<_i11.AuthCubit>(_i11.AuthCubit(gh<_i9.AuthRepository>()));
    return this;
  }
}
