// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:qlutter/app/data/main_app_config.dart' as _i836;
import 'package:qlutter/app/domain/app_api.dart' as _i652;
import 'package:qlutter/app/domain/app_config.dart' as _i1025;
import 'package:qlutter/feature/level_manager/data/local_level_repository.dart'
    as _i959;
import 'package:qlutter/feature/level_manager/domain/level_repository.dart'
    as _i906;
import 'package:qlutter/feature/level_manager/level_manager.dart' as _i897;
import 'package:qlutter/feature/level_records/data/network_level_records_repository.dart'
    as _i168;
import 'package:qlutter/feature/level_records/domain/level_record_repository.dart'
    as _i239;
import 'package:qlutter/feature/style/palette.dart' as _i530;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.singleton<_i897.LevelManager>(() => _i897.LevelManager());
    gh.singleton<_i530.Palette>(() => _i530.Palette());
    gh.factory<_i906.LevelRepository>(() => _i959.LocalLevelRepository());
    gh.singleton<_i1025.AppConfig>(() => _i836.ProdAppConfig());
    gh.factory<_i239.LevelRecordRepository>(
        () => _i168.NetworkLevelRecordsRepository(gh<_i652.AppApi>()));
    return this;
  }
}
