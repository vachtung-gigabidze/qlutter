class LevelRecord {
  int? id;
  int? levelId;
  int? steps;
  String? datetime;
  int? seconds;
  int? user;

  LevelRecord(
      {this.id,
      this.levelId,
      this.steps,
      this.datetime,
      this.seconds,
      this.user});

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
