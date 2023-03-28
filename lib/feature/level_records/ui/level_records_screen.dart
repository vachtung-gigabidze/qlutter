import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:qlutter/app/ui/app_loader.dart';
import 'package:qlutter/feature/level_records/domain/cubit/level_progress_cubit.dart';
import 'package:qlutter/feature/level_records/domain/entities/level_record.dart';
import 'package:qlutter/feature/style/palette.dart';
import 'package:qlutter/feature/style/responsive_screen.dart';

// Widget _gap = const SizedBox(
//   width: 10,
// );

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
                        return Column(
                          children: [
                            const Text('Лучшие результаты'),
                            Expanded(
                              child: ListView(
                                children: [
                                  DataTable(
                                    columns: const [
                                      DataColumn(
                                          label: Text('Уровень',
                                              style: headFontSize)),
                                      DataColumn(
                                          label: Text('Шаги',
                                              style: headFontSize)),
                                      DataColumn(
                                          label: Text('Время',
                                              style: headFontSize)),
                                      DataColumn(
                                          label: Text('Дата',
                                              style: headFontSize)),
                                    ],
                                    rows: records
                                        .map((r) => DataRow(
                                              cells: <DataCell>[
                                                DataCell(
                                                  Text(
                                                    '${r.levelId}',
                                                    style: rowFontSize,
                                                  ),
                                                ),
                                                DataCell(
                                                  Text(
                                                    '${r.steps}',
                                                    style: rowFontSize,
                                                  ),
                                                ),
                                                DataCell(
                                                  Text(
                                                    r.formattedTime,
                                                    style: rowFontSize,
                                                  ),
                                                ),
                                                DataCell(
                                                  Text(
                                                    r.datetime.substring(0, 10),
                                                    style: rowFontSize,
                                                  ),
                                                ),
                                              ],
                                            ))
                                        .toList(),
                                  )
                                ],
                              ),
                            ),
                          ],
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
