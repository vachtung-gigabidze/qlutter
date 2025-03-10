import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:qlutter/app/ui/components/app_transition.dart';
import 'package:qlutter/game/pages/pages.dart';

class GameRouter {
  static final router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder:
            (context, state) => const MainMenuScreen(key: Key('main_menu')),
        routes: [
          GoRoute(
            path: 'play',
            pageBuilder:
                (context, state) => buildMyTransition<void>(
                  child: const LevelMenuScreen(key: Key('level selection')),
                  color: Theme.of(context).colorScheme.surface,
                  // context.watch<Palette>().backgroundLevelSelection,
                ),
            routes: [
              GoRoute(
                path: 'session/:level',
                pageBuilder: (context, state) {
                  final levelNumber = int.parse(state.pathParameters['level']!);
                  //final level = levelManager.levels![levelNumber];
                  return buildMyTransition<void>(
                    child: PlayScreen(
                      levelNumber,
                      key: const Key('play session'),
                    ),
                    color: Theme.of(context).colorScheme.surface,
                    //context.watch<Palette>().backgroundPlaySession,
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
                    color:
                        Theme.of(context)
                            .colorScheme
                            .surface, //context.watch<Palette>().backgroundPlaySession,
                  );
                },
              ),
            ],
          ),
          GoRoute(
            path: 'settings',
            builder:
                (context, state) => const SettingsScreen(key: Key('settings')),
          ),
        ],
      ),
    ],
  );
}
