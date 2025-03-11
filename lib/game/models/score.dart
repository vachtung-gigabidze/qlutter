// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class Score {
  final int score;
  final Duration duration;
  final int level;
  Score({required this.score, required this.duration, required this.level});

  String get formattedTime {
    final buf = StringBuffer();
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
    buf.write(
      (duration.inSeconds % Duration.secondsPerMinute).toString().padLeft(
        2,
        '0',
      ),
    );
    return buf.toString();
  }

  @override
  String toString() =>
      'Score(score: $score, duration: $duration, level: $level)';

  Score copyWith({int? score, Duration? duration, int? level}) {
    return Score(
      score: score ?? this.score,
      duration: duration ?? this.duration,
      level: level ?? this.level,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'score': score,
      'duration': duration.inSeconds,
      'level': level,
    };
  }

  factory Score.fromMap(Map<String, dynamic> map) {
    return Score(
      score: map['score'] as int,
      duration: Duration(seconds: map['duration'] as int),
      level: map['level'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory Score.fromJson(String source) =>
      Score.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool operator ==(covariant Score other) {
    if (identical(this, other)) return true;

    return other.score == score &&
        other.duration == duration &&
        other.level == level;
  }

  @override
  int get hashCode => score.hashCode ^ duration.hashCode ^ level.hashCode;
}
