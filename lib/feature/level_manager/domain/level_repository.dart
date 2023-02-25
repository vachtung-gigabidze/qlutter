abstract class LevelRepository {
  Future<dynamic> getLevels();

  Future<dynamic> sendProcess(
      {int levelId, int steps, int seconds, DateTime dateTime});
}
