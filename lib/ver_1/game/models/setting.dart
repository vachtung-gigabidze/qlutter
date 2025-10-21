// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:qlutter/ver_1/game/models/score.dart';

class Setting {
  String theme;
  int lastLevel;
  String language;
  Score score;
  Setting({
    required this.theme,
    required this.lastLevel,
    required this.language,
    required this.score,
  });

  Setting copyWith({
    String? theme,
    int? lastLevel,
    String? language,
    Score? score,
  }) => Setting(
    theme: theme ?? this.theme,
    lastLevel: lastLevel ?? this.lastLevel,
    language: language ?? this.language,
    score: score ?? this.score,
  );

  Map<String, dynamic> toMap() => <String, dynamic>{
    'theme': theme,
    'lastLevel': lastLevel,
    'language': language,
    'score': score.toMap(),
  };

  factory Setting.fromMap(Map<String, dynamic> map) => Setting(
    theme: map['theme'] as String,
    lastLevel: map['lastLevel'] as int,
    language: map['language'] as String,
    score: Score.fromMap(map['score'] as Map<String, dynamic>),
  );

  String toJson() => json.encode(toMap());

  factory Setting.fromJson(String source) =>
      Setting.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'Setting(theme: $theme, lastLevel: $lastLevel, language: $language, score: $score)';

  @override
  bool operator ==(covariant Setting other) {
    if (identical(this, other)) return true;

    return other.theme == theme &&
        other.lastLevel == lastLevel &&
        other.language == language &&
        other.score == score;
  }

  @override
  int get hashCode =>
      theme.hashCode ^ lastLevel.hashCode ^ language.hashCode ^ score.hashCode;
}
