import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:qlutter/app/di/init_di.dart';
import 'package:qlutter/app/domain/app_builder.dart';
import 'package:qlutter/feature/level_manager/level_manager.dart';
// import 'package:qlutter/feature/app_lifecycle/app_lifecycle.dart';
import 'package:qlutter/feature/games_services/games_services.dart';
import 'package:qlutter/feature/games_services/score.dart';
import 'package:qlutter/feature/level_records/domain/cubit/level_progress_cubit.dart';
import 'package:qlutter/feature/level_records/ui/level_records_screen.dart';
import 'package:qlutter/feature/level_selection/level_selection_screen.dart';
import 'package:qlutter/feature/main_menu/main_menu_screen.dart';
import 'package:qlutter/feature/play_session/play_session_screen.dart';
import 'package:qlutter/feature/player_progress/persistence/local_storage_player_progress_persistence.dart';
import 'package:qlutter/feature/player_progress/persistence/player_progress_persistence.dart';
import 'package:qlutter/feature/player_progress/player_progress.dart';
import 'package:qlutter/feature/settings/persistence/local_storage_settings_persistence.dart';
import 'package:qlutter/feature/settings/persistence/settings_persistence.dart';
import 'package:qlutter/feature/settings/settings.dart';
import 'package:qlutter/feature/settings/settings_screen.dart';
import 'package:qlutter/feature/style/my_transition.dart';
import 'package:qlutter/feature/style/palette.dart';
import 'package:qlutter/feature/style/snack_bar.dart';
import 'package:qlutter/feature/win_game/win_game_screen.dart';

class MainAppBuilder implements AppBuilder {
  static final _router = GoRouter(
    routes: [
      GoRoute(
          path: '/',
          builder: (context, state) =>
              const MainMenuScreen(key: Key('main menu')),
          routes: [
            GoRoute(
                path: 'play',
                pageBuilder: (context, state) => buildMyTransition<void>(
                      child: const LevelSelectionScreen(
                          key: Key('level selection')),
                      color: context.watch<Palette>().backgroundLevelSelection,
                    ),
                routes: [
                  GoRoute(
                    path: 'session/:level',
                    pageBuilder: (context, state) {
                      final levelNumber = int.parse(state.params['level']!);
                      //final level = levelManager.levels![levelNumber];
                      return buildMyTransition<void>(
                        child: PlaySessionScreen(
                          levelNumber,
                          key: const Key('play session'),
                        ),
                        color: context.watch<Palette>().backgroundPlaySession,
                      );
                    },
                  ),
                  GoRoute(
                    path: 'won',
                    pageBuilder: (context, state) {
                      final map = state.extra! as Map<String, dynamic>;
                      final score = map['score'] as Score;

                      return buildMyTransition<void>(
                        child: WinGameScreen(
                          score: score,
                          key: const Key('win game'),
                        ),
                        color: context.watch<Palette>().backgroundPlaySession,
                      );
                    },
                  )
                ]),
            GoRoute(
              path: 'settings',
              builder: (context, state) =>
                  const SettingsScreen(key: Key('settings')),
            ),
            GoRoute(
              path: 'progress',
              builder: (context, state) =>
                  const LevelRecordsScreen(key: Key('progress')),
            ),
          ]),
    ],
  );

  GamesServicesController? gamesServicesController;

  @override
  Widget buildApp() {
    final palette = locator.get<Palette>();
    return _GlobalProviders(
      settingsPersistence: LocalStorageSettingsPersistence(),
      playerProgressPersistence: LocalStoragePlayerProgressPersistence(),
      gamesServicesController: gamesServicesController,
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'Qlutter',
        theme: ThemeData.from(
          colorScheme: ColorScheme.fromSeed(
            seedColor: palette.darkPen,
            background: palette.backgroundMain,
          ),
          textTheme: TextTheme(
            bodyMedium: TextStyle(
              fontFamily: palette.fontMain,
              fontSize: 26,
              color: palette.ink,
            ),
          ),
          useMaterial3: true,
        ),
        routeInformationProvider: _router.routeInformationProvider,
        routeInformationParser: _router.routeInformationParser,
        routerDelegate: _router.routerDelegate,
        scaffoldMessengerKey: scaffoldMessengerKey,
      ),
    );
  }
}

class _GlobalProviders extends StatelessWidget {
  const _GlobalProviders(
      {required this.child,
      required this.playerProgressPersistence,
      required this.settingsPersistence,
      this.gamesServicesController});

  final Widget child;
  final PlayerProgressPersistence playerProgressPersistence;

  final SettingsPersistence settingsPersistence;

  final GamesServicesController? gamesServicesController;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LevelProgressCubit>.value(
          value: locator.get<LevelProgressCubit>()..getRecords(),
        ),
        Provider<LevelManager>.value(
          value: locator.get<LevelManager>()..readLevels(),
        ),
        ChangeNotifierProvider(
          create: (context) {
            var progress = PlayerProgress(playerProgressPersistence);
            progress.getLatestFromStore();
            return progress;
          },
        ),
        Provider<GamesServicesController?>.value(
            value: gamesServicesController),
        Provider<SettingsController>(
          lazy: false,
          create: (context) => SettingsController(
            persistence: settingsPersistence,
          )..loadStateFromPersistence(),
        ),
        Provider(
          create: (context) => Palette(),
        ),
      ],
      child: child,
    );
  }
}
