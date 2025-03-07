// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Setting {
  String theme;
  String currentDialogueId;
  Setting({required this.selectedStory, required this.currentDialogueId});

  Setting copyWith({String? selectedStory, String? currentDialogueId}) {
    return Setting(
      selectedStory: selectedStory ?? this.selectedStory,
      currentDialogueId: currentDialogueId ?? this.currentDialogueId,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'selectedStory': selectedStory,
      'currentDialogueId': currentDialogueId,
    };
  }

  factory Setting.fromMap(Map<String, dynamic> map) {
    return Setting(
      selectedStory: map['selectedStory'] as String,
      currentDialogueId: map['currentDialogueId'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Setting.fromJson(String source) =>
      Setting.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'Setting(selectedStory: $selectedStory, currentDialogueId: $currentDialogueId)';

  @override
  bool operator ==(covariant Setting other) {
    if (identical(this, other)) return true;

    return other.selectedStory == selectedStory &&
        other.currentDialogueId == currentDialogueId;
  }

  @override
  int get hashCode => selectedStory.hashCode ^ currentDialogueId.hashCode;
}
