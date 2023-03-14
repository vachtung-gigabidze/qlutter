class LevelRecord {
  late int id;
  late int levelId;
  late int steps;
  late String datetime;
  late int seconds;
  int? user;

  LevelRecord(
      {required id,
      required levelId,
      required steps,
      required datetime,
      required seconds,
      this.user});

  String get formattedTime {
    final buf = StringBuffer();
    Duration duration = Duration(seconds: seconds);
    if (duration.inHours > 0) {
      buf.write('${duration.inHours}');
      buf.write(':');
    }
    final minutes = duration.inMinutes % Duration.minutesPerHour;
    if (minutes > 9) {
      buf.write('$minutes');
    } else {
      buf.write('0');
      buf.write('$minutes');
    }
    buf.write(':');
    buf.write((duration.inSeconds % Duration.secondsPerMinute)
        .toString()
        .padLeft(2, '0'));
    return buf.toString();
  }

  LevelRecord.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    levelId = json['levelId'];
    steps = json['steps'];
    datetime = json['datetime'];
    seconds = json['seconds'];
    user = json['user'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['levelId'] = levelId;
    data['steps'] = steps;
    data['datetime'] = datetime;
    data['seconds'] = seconds;
    data['user'] = user;
    return data;
  }
}
