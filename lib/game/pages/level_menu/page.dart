import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:qlutter/app/ui/components/components.dart';
import 'package:qlutter/feature/level_builder/level_builder.dart';
import 'package:qlutter/game/field_view/field_view_preview.dart';
import 'package:qlutter/game/game_core/game_core.dart';
import 'package:qlutter/game/provider/setting_provider.dart';
import 'dart:math';
import 'package:qlutter/i18n/strings.g.dart';

class LevelMenuScreen extends StatelessWidget {
  const LevelMenuScreen({super.key});

  static double textScaleFactor(
    BuildContext context, {
    double maxTextScaleFactor = 1,
  }) {
    final width = MediaQuery.of(context).size.width;
    double val = (width / 500) * maxTextScaleFactor;
    return min(val, maxTextScaleFactor);
  }

  static int columnCount(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final val = (width ~/ 100);
    return min(val, 6);
  }

  @override
  Widget build(BuildContext context) {
    Palette palette = Palette();
    final t = Translations.of(context);
    final setting = SettingProvider.of(context).setting;
    return Scaffold(
      //backgroundColor: palette.backgroundLevelSelection,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Padding(
          padding: const EdgeInsets.all(16),
          child: Center(
            child: Text(
              t.levels.title,
              style: TextStyle(fontFamily: palette.fontMain, fontSize: 30),
            ),
          ),
        ),
      ),
      body: FutureBuilder(
        future: context.read<LevelBuilder>().readLevels(),
        builder: (context, AsyncSnapshot<Map<int, Level>> snapshot) {
          if (snapshot.hasData) {
            return AppResponsiveScreen(
              squarishMainArea: Column(
                children: [
                  // const SizedBox(height: 40),
                  Expanded(
                    child: GridView.count(
                      crossAxisCount: columnCount(context),
                      children: [
                        for (final level in snapshot.data!.values)
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: AbsorbPointer(
                                  absorbing: level.levelId > setting.lastLevel,
                                  child: FittedBox(
                                    child: InkWell(
                                      onTap: () {
                                        GoRouter.of(
                                          context,
                                        ).go('/play/session/${level.levelId}');
                                      },
                                      child: FieldViewPreview(
                                        //backgroundColor:
                                        //  palette.backgroundLevelSelection,
                                        parentSize: const Size(150, 150),
                                        key: UniqueKey(),
                                        field: Field(level),
                                        enable:
                                            level.levelId <= setting.lastLevel,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Text(
                                level.levelId == 0
                                    ? t.levels.tutorial
                                    : level.levelId.toString(),
                                style: const TextStyle(fontSize: 16),
                                textScaleFactor:
                                    level.levelId == 0
                                        ? textScaleFactor(context)
                                        : 1,
                              ),
                            ],
                          ),
                      ],
                    ),
                  ),
                ],
              ),
              rectangularMenuArea: ElevatedButton(
                onPressed: () {
                  GoRouter.of(context).go('/');
                },
                child: Text(
                  t.levels.back,
                  style: TextStyle(
                    fontFamily: palette.fontMain,
                    fontSize: 20,
                    //color: palette.ink,
                  ),
                ),
              ),
            );
          } else {
            return const AppLoader();
          }
        },
      ),
    );
  }
}
