// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Setting {
  String theme;
  String lastLevel;
  String language;
  Setting({
    required this.theme,
    required this.lastLevel,
    required this.language,
  });

  Setting copyWith({String? theme, String? lastLevel, String? language}) {
    return Setting(
      theme: theme ?? this.theme,
      lastLevel: lastLevel ?? this.lastLevel,
      language: language ?? this.language,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'theme': theme,
      'lastLevel': lastLevel,
      'language': language,
    };
  }

  factory Setting.fromMap(Map<String, dynamic> map) {
    return Setting(
      theme: map['theme'] as String,
      lastLevel: map['lastLevel'] as String,
      language: map['language'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Setting.fromJson(String source) =>
      Setting.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'Setting(theme: $theme, lastLevel: $lastLevel, language: $language)';

  @override
  bool operator ==(covariant Setting other) {
    if (identical(this, other)) return true;

    return other.theme == theme &&
        other.lastLevel == lastLevel &&
        other.language == language;
  }

  @override
  int get hashCode => theme.hashCode ^ lastLevel.hashCode ^ language.hashCode;
}
