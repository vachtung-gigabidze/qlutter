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
                          itemBuilder: (context, index) =>
                              Text('Уровень ${snapshot.data![index].levelId}'));
                    } else {
                      return const AppLoader();
                    }
                  },
                ),
              )),
    );
  }
}
