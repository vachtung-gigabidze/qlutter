import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qlutter/app/ui/app_loader.dart';
import 'package:qlutter/feature/level_records/domain/cubit/level_progress_cubit.dart';
import 'package:qlutter/feature/level_records/domain/entities/level_record.dart';

Widget _gap = const SizedBox(
  width: 10,
);

class LevelRecordsScreen extends StatelessWidget {
  const LevelRecordsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<LevelProgressCubit, LevelProgressState>(
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
                      return ListView.builder(
                          itemCount: snapshot.data?.length,
                          itemBuilder: (context, index) => Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Уровень ${snapshot.data![index].levelId}',
                                    style: const TextStyle(fontSize: 12),
                                  ),
                                  _gap,
                                  Text(
                                    'Шагов ${snapshot.data![index].steps}',
                                    style: const TextStyle(fontSize: 12),
                                  ),
                                  _gap,
                                  Text(
                                    'Время ${snapshot.data![index].formattedTime}',
                                    style: const TextStyle(fontSize: 12),
                                  ),
                                  // Text(
                                  //   'Дата ${snapshot.data![index].datetime}',
                                  //   style: TextStyle(fontSize: 12),
                                  // ),
                                ],
                              ));
                    } else {
                      return const AppLoader();
                    }
                  },
                ),
              )),
    );
  }
}
