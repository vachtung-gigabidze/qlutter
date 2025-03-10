import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:qlutter/app/ui/app_loader.dart';
import 'package:qlutter/feature/level_records/domain/cubit/level_progress_cubit.dart';
import 'package:qlutter/feature/level_records/domain/entities/level_record.dart';
import 'package:qlutter/app/ui/components/app_palette.dart';
import 'package:qlutter/app/ui/components/app_responsive.dart';

// Widget _gap = const SizedBox(
//   width: 10,
// );

class LevelRecordsScreen extends StatelessWidget {
  const LevelRecordsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Palette palette = context.watch<Palette>();

    return Scaffold(
      body: AppResponsiveScreen(
        mainAreaProminence: 0.45,
        squarishMainArea: BlocBuilder<LevelProgressCubit, LevelProgressState>(
          builder:
              (context, state) => state.when(
                empty: () {
                  context.read()<LevelProgressCubit>();
                  return const AppLoader();
                },
                error: (error) => const Text('error'),
                loaded:
                    (records) => FutureBuilder<List<LevelRecord>>(
                      future: Future.value(records),
                      builder: (
                        context,
                        AsyncSnapshot<List<LevelRecord>> snapshot,
                      ) {
                        if (snapshot.hasData) {
                          return Column(
                            children: [
                              const Text('Лучшие результаты'),
                              Expanded(
                                child: ListView(
                                  children: [
                                    DataTable(
                                      columns: [
                                        DataColumn(
                                          label: Text(
                                            'Уровень',
                                            style: palette.headTableStyle,
                                          ),
                                        ),
                                        DataColumn(
                                          label: Text(
                                            'Шаги',
                                            style: palette.headTableStyle,
                                          ),
                                        ),
                                        DataColumn(
                                          label: Text(
                                            'Время',
                                            style: palette.headTableStyle,
                                          ),
                                        ),
                                        DataColumn(
                                          label: Text(
                                            'Дата',
                                            style: palette.headTableStyle,
                                          ),
                                        ),
                                      ],
                                      rows:
                                          records
                                              .map(
                                                (r) => DataRow(
                                                  cells: <DataCell>[
                                                    DataCell(
                                                      Text(
                                                        '${r.levelId}',
                                                        style:
                                                            palette
                                                                .rowTableStyle,
                                                      ),
                                                    ),
                                                    DataCell(
                                                      Text(
                                                        '${r.steps}',
                                                        style:
                                                            palette
                                                                .rowTableStyle,
                                                      ),
                                                    ),
                                                    DataCell(
                                                      Text(
                                                        r.formattedTime,
                                                        style:
                                                            palette
                                                                .rowTableStyle,
                                                      ),
                                                    ),
                                                    DataCell(
                                                      Text(
                                                        r.datetime.substring(
                                                          0,
                                                          10,
                                                        ),
                                                        style:
                                                            palette
                                                                .rowTableStyle,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              )
                                              .toList(),
                                    ),
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
              ),
        ),
        rectangularMenuArea: ElevatedButton(
          onPressed: () {
            GoRouter.of(context).go('/');
          },
          child: Text(
            'Назад',
            style: TextStyle(
              fontFamily: palette.fontMain,
              fontSize: 20,
              // color: palette.ink,
            ),
          ),
        ),
      ),
    );
  }
}
