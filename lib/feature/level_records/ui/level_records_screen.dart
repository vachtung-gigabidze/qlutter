import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qlutter/app/ui/app_loader.dart';
import 'package:qlutter/feature/level_records/domain/cubit/level_progress_cubit.dart';
import 'package:qlutter/feature/level_records/domain/entities/level_record.dart';

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
                                children: [
                                  Text(
                                    'Уровень ${snapshot.data![index].levelId}',
                                    style: TextStyle(fontSize: 12),
                                  ),
                                  Text(
                                    'Шагов ${snapshot.data![index].steps}',
                                    style: TextStyle(fontSize: 12),
                                  ),
                                  Text(
                                    'Время ${snapshot.data![index].seconds}',
                                    style: TextStyle(fontSize: 12),
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
