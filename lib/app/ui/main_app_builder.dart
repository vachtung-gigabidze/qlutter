// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:go_router/go_router.dart';
// import 'package:qlutter/app/di/init_di.dart';
// import 'package:qlutter/app/domain/app_builder.dart';
// import 'package:qlutter/app/ui/app_loader.dart';
// import 'package:qlutter/app/ui/root_screen.dart';
// import 'package:qlutter/feature/auth/domain/auth_state/auth_cubit.dart';
// import 'package:qlutter/feature/auth/ui/components/auth_builder.dart';
// import 'package:qlutter/feature/auth/ui/auth_screen.dart';
// import 'package:qlutter/feature/favorite/ui/favorites_screen.dart';
// import 'package:qlutter/feature/freezer/domain/state/cubit/freezer_cubit.dart';
// import 'package:qlutter/feature/freezer/freezer_repository.dart';
// import 'package:qlutter/feature/freezer/ui/freezer_screen.dart';
// import 'package:qlutter/feature/internet/domain/internet_state/internet_cubit.dart';
// import 'package:qlutter/feature/logo/logo_screen.dart';
// import 'package:qlutter/feature/navbar/domain/navbar_state/navbar_cubit.dart';
// import 'package:qlutter/feature/navbar/ui/scaffold_with_bottom_navbar.dart';
// import 'package:qlutter/feature/recipe_list/domain/recipe_list_repository.dart';
// import 'package:qlutter/feature/recipe_list/domain/recipe_list_state/recipe_list_cubit.dart';
// import 'package:qlutter/feature/auth/ui/profile_screen.dart';

// class MainAppBuilder implements AppBuilder {
//   final _routes = GoRouter(
//     initialLocation: '/logo',
//     routes: [
//       GoRoute(
//           path: '/logo',
//           builder: (context, state) => const LogoScreen(nextRoute: '/')),
//       ShellRoute(
//           builder: (context, state, child) => ScaffoldWithBottomNavBar(
//                 child: child,
//               ),
//           routes: [
//             GoRoute(
//                 path: '/auth',
//                 builder: (context, state) => AuthBuilder(
//                       isNotAuthorized: (context) => AuthScreen(),
//                       isWaiting: (context) => const AppLoader(),
//                       isAuthorized: (context, value, child) =>
//                           const ProfileScreen(),
//                     )),
//             GoRoute(
//                 path: '/profile',
//                 builder: (context, state) => AuthBuilder(
//                       isNotAuthorized: (context) => AuthScreen(),
//                       isWaiting: (context) => const AppLoader(),
//                       isAuthorized: (context, value, child) =>
//                           const ProfileScreen(),
//                     )),
//             GoRoute(
//                 path: '/favorites',
//                 builder: (context, state) => const FavoritesScreen()),
//             GoRoute(
//                 name: "root",
//                 path: '/',
//                 builder: (context, state) => const RootScreen()),
//             GoRoute(
//                 path: '/favorites',
//                 builder: (context, state) => const FavoritesScreen()),
//             GoRoute(
//                 path: '/freezer',
//                 builder: (context, state) => const FreezerScreen()),
//           ])
//     ],
//   );

//   @override
//   Widget buildApp() {
//     return _GlobalProviders(
//       child: MaterialApp.router(
//         debugShowCheckedModeBanner: false,
//         title: 'Otus Food App',
//         routerConfig: _routes,
//       ),
//     );
//   }
// }

// class _GlobalProviders extends StatelessWidget {
//   const _GlobalProviders({required this.child});

//   final Widget child;

//   @override
//   Widget build(BuildContext context) {
//     return MultiBlocProvider(
//       providers: [
//         BlocProvider(
//           create: (context) => InternetConnectionCubit(),
//         ),
//         BlocProvider(
//           create: (context) =>
//               locator.get<AuthCubit>(), //AuthCubit(locator<AuthRepository>()),
//         ),
//         BlocProvider(
//           create: (context) =>
//               RecipeListCubit(locator<RecipeListRepository>())..getRecipeList(),
//         ),
//         BlocProvider(
//           create: (context) =>
//               FreezerCubit(locator<FreezerRepository>())..fetchFreezer(),
//         ),
//         BlocProvider(create: (context) => NavbarCubit()),
//       ],
//       child: child,
//     );
//   }
// }
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:logging/logging.dart';
import 'package:provider/provider.dart';
import 'package:qlutter/app/di/init_di.dart';
import 'package:qlutter/feature/auth/domain/auth_state/auth_cubit.dart';
import 'package:qlutter/feature/internet_activity/internet_cubit.dart';
import 'package:qlutter/feature/level_manager/level_manager.dart';

// import 'game/ads/ads_controller.dart';
import 'feature/app_lifecycle/app_lifecycle.dart';
import 'feature/audio/audio_controller.dart';
// import 'game/crashlytics/crashlytics.dart';
import 'feature/games_services/games_services.dart';
import 'feature/games_services/score.dart';
// import 'game/in_app_purchase/in_app_purchase.dart';
import 'feature/level_selection/level_selection_screen.dart';
import 'feature/main_menu/main_menu_screen.dart';
import 'feature/play_session/play_session_screen.dart';
import 'feature/player_progress/persistence/local_storage_player_progress_persistence.dart';
import 'feature/player_progress/persistence/player_progress_persistence.dart';
import 'feature/player_progress/player_progress.dart';
import 'feature/settings/persistence/local_storage_settings_persistence.dart';
import 'feature/settings/persistence/settings_persistence.dart';
import 'feature/settings/settings.dart';
import 'feature/settings/settings_screen.dart';
import 'feature/style/my_transition.dart';
import 'feature/style/palette.dart';
import 'feature/style/snack_bar.dart';
import 'feature/win_game/win_game_screen.dart';

Future<void> main() async {
  guardedMain();
}

void guardedMain() {
  if (kReleaseMode) {
    Logger.root.level = Level.WARNING;
  }
  Logger.root.onRecord.listen((record) {
    debugPrint('${record.level.name}: ${record.time}: '
        '${record.loggerName}: '
        '${record.message}');
  });

  WidgetsFlutterBinding.ensureInitialized();

  _log.info('Going full screen');
  SystemChrome.setEnabledSystemUIMode(
    SystemUiMode.edgeToEdge,
  );

  GamesServicesController? gamesServicesController;

  LevelManager? levelManager = LevelManager()..readLevels();

  runApp(
    Qlutter(
      settingsPersistence: LocalStorageSettingsPersistence(),
      playerProgressPersistence: LocalStoragePlayerProgressPersistence(),
      gamesServicesController: gamesServicesController,
      levelManager: levelManager,
    ),
  );
}

Logger _log = Logger('main.dart');

class Qlutter extends StatelessWidget {
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
          ]),
    ],
  );

  final PlayerProgressPersistence playerProgressPersistence;

  final SettingsPersistence settingsPersistence;

  final GamesServicesController? gamesServicesController;

  // final InAppPurchaseController? inAppPurchaseController;

  // final AdsController? adsController;

  final LevelManager levelManager;

  const Qlutter({
    required this.playerProgressPersistence,
    required this.settingsPersistence,
    // required this.inAppPurchaseController,
    // required this.adsController,
    required this.gamesServicesController,
    required this.levelManager,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppLifecycleObserver(
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => locator.get<AuthCubit>(),
          ),
          BlocProvider(
            create: (context) => InternetConnectionCubit(),
          ),
          // Provider<LevelManager>.value(value: LevelManager()..readLevels()),
          Provider<LevelManager>.value(value: levelManager),
          // Provider<LevelManager>(
          //     lazy: false, create: (context) => LevelManager()..readLevels()),
          ChangeNotifierProvider(
            create: (context) {
              var progress = PlayerProgress(playerProgressPersistence);
              progress.getLatestFromStore();
              return progress;
            },
          ),
          Provider<GamesServicesController?>.value(
              value: gamesServicesController),
          // Provider<AdsController?>.value(value: adsController),
          // ChangeNotifierProvider<InAppPurchaseController?>.value(
          //     value: inAppPurchaseController),
          Provider<SettingsController>(
            lazy: false,
            create: (context) => SettingsController(
              persistence: settingsPersistence,
            )..loadStateFromPersistence(),
          ),
          ProxyProvider2<SettingsController, ValueNotifier<AppLifecycleState>,
              AudioController>(
            // Ensures that the AudioController is created on startup,
            // and not "only when it's needed", as is default behavior.
            // This way, music starts immediately.
            lazy: false,
            create: (context) => AudioController()..initialize(),
            update: (context, settings, lifecycleNotifier, audio) {
              if (audio == null) throw ArgumentError.notNull();
              audio.attachSettings(settings);
              audio.attachLifecycleNotifier(lifecycleNotifier);
              return audio;
            },
            dispose: (context, audio) => audio.dispose(),
          ),
          Provider(
            create: (context) => Palette(),
          ),
        ],
        child: Builder(builder: (context) {
          final palette = context.watch<Palette>();

          return MaterialApp.router(
            title: 'Qlutter',
            theme: ThemeData.from(
              colorScheme: ColorScheme.fromSeed(
                seedColor: palette.darkPen,
                background: palette.backgroundMain,
              ),
              textTheme: TextTheme(
                bodyMedium: TextStyle(
                  color: palette.ink,
                ),
              ),
              useMaterial3: true,
            ),
            routeInformationProvider: _router.routeInformationProvider,
            routeInformationParser: _router.routeInformationParser,
            routerDelegate: _router.routerDelegate,
            scaffoldMessengerKey: scaffoldMessengerKey,
          );
        }),
      ),
    );
  }
}
