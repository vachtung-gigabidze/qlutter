import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:qlutter/app/ui/app_loader.dart';
import 'package:qlutter/feature/level_records/domain/cubit/level_progress_cubit.dart';
import 'package:qlutter/feature/level_records/domain/entities/level_record.dart';
import 'package:qlutter/feature/style/palette.dart';
import 'package:qlutter/feature/style/responsive_screen.dart';

Widget _gap = const SizedBox(
  width: 10,
);

class LevelRecordsScreen extends StatelessWidget {
  const LevelRecordsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Palette palette = context.watch<Palette>();

    const headFontSize = TextStyle(fontSize: 16);
    const rowFontSize = TextStyle(fontSize: 12);

    return Scaffold(
      body: ResponsiveScreen(
        mainAreaProminence: 0.45,
        squarishMainArea: BlocBuilder<LevelProgressCubit, LevelProgressState>(
            builder: (context, state) => state.when(
                  empty: () {
                    context.read()<LevelProgressCubit>();
                    return const AppLoader();
                  },
                  error: (error) => const Text('error'),
                  loaded: (records) => FutureBuilder<List<LevelRecord>>(
                    future: Future.value(records),
                    builder:
                        (context, AsyncSnapshot<List<LevelRecord>> snapshot) {
                      if (snapshot.hasData) {
                        return Center(
                          child: Column(
                            children: [
                              const SizedBox(
                                  height: 50, child: Text('Лучшие результаты')),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: const [
                                  Text(
                                    'Уровень',
                                    style: headFontSize,
                                  ),
                                  Text(
                                    'Шаги',
                                    style: headFontSize,
                                  ),
                                  Text(
                                    'Время',
                                    style: headFontSize,
                                  ),
                                  Text(
                                    'Дата',
                                    style: headFontSize,
                                  ),
                                ],
                              ),
                              Flexible(
                                child: ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: snapshot.data?.length,
                                    itemBuilder: (context, index) => Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              '${snapshot.data![index].levelId}',
                                              style: rowFontSize,
                                            ),
                                            _gap,
                                            Text(
                                              '${snapshot.data![index].steps}',
                                              style: rowFontSize,
                                            ),
                                            _gap,
                                            Text(
                                              snapshot
                                                  .data![index].formattedTime,
                                              style: rowFontSize,
                                            ),
                                            _gap,
                                            Text(
                                              snapshot.data![index].datetime
                                                  .substring(0, 10),
                                              style: rowFontSize,
                                            ),
                                          ],
                                        )),
                              ),
                            ],
                          ),
                        );
                      } else {
                        return const AppLoader();
                      }
                    },
                  ),
                )),
        rectangularMenuArea: ElevatedButton(
          onPressed: () {
            GoRouter.of(context).go('/');
          },
          child: Text(
            'Назад',
            style: TextStyle(
              fontFamily: palette.fontMain,
              fontSize: 20,
              color: palette.ink,
            ),
          ),
        ),
      ),
    );
  }
}
