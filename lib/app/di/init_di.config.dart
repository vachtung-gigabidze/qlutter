// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:qlutter/app/data/dio_app_api.dart' as _i6;
import 'package:qlutter/app/data/main_app_config.dart' as _i4;
import 'package:qlutter/app/domain/app_api.dart' as _i5;
import 'package:qlutter/app/domain/app_config.dart' as _i3;
import 'package:qlutter/feature/auth/data/network_auth_repository.dart' as _i8;
import 'package:qlutter/feature/auth/domain/auth_repository.dart' as _i7;
import 'package:qlutter/feature/auth/domain/auth_state/auth_cubit.dart' as _i9;

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
    gh.singleton<_i5.AppApi>(_i6.DioAppApi(gh<_i3.AppConfig>()));
    gh.factory<_i7.AuthRepository>(
        () => _i8.NetworkAuthRepository(gh<_i5.AppApi>()));
    gh.singleton<_i9.AuthCubit>(_i9.AuthCubit(gh<_i7.AuthRepository>()));
    return this;
  }
}
