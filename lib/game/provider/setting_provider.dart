import 'package:flutter/material.dart';
import 'package:qlutter/game/level_builder/level_builder.dart';
import 'package:qlutter/game/models/score.dart';
import 'package:qlutter/game/models/setting.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingStateWidget extends StatefulWidget {
  const SettingStateWidget({super.key, required this.child});

  final Widget child;

  @override
  State<SettingStateWidget> createState() => _SettingStateWidgetState();
}

class _SettingStateWidgetState extends State<SettingStateWidget> {
  late Setting setting;

  Future<Setting> loadSetting() async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      String? v = preferences.getString("setting");
      if (v != null) {
        setting = Setting.fromJson(v);
        return setting;
      }
      levelBuilder = LevelBuilder();
      await levelBuilder.readLevels();
    } catch (e) {}
    setting = Setting(
      theme: "light",
      lastLevel: 0,
      language: "ru",
      score: Score(score: 0, duration: Duration(seconds: 0), level: 0),
    );
    return setting;
  }

  @override
  void dispose() {
    super.dispose();
  }

  void saveSetting(Setting newSetting) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    bool result = await preferences.setString("setting", newSetting.toJson());
    if (result) {
      setState(() {
        setting = newSetting;
      });
    }
  }

  void reset() async {}
  late LevelBuilder levelBuilder;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Setting>(
      future: loadSetting(),
      builder: (context, AsyncSnapshot<Setting> snapshot) {
        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        } else {
          final s = snapshot.data;
          return SettingProvider(
            saveSetting: saveSetting,
            reset: reset,
            setting: s ?? setting,
            levelBuilder: levelBuilder,
            child: widget.child,
          );
        }
      },
    );
  }
}

class SettingProvider extends InheritedWidget {
  const SettingProvider({
    required this.saveSetting,
    required this.reset,
    required this.setting,
    required this.levelBuilder,
    super.key,
    required this.child,
  }) : super(child: child);
  final Setting setting;
  final LevelBuilder levelBuilder;
  final void Function(Setting setting) saveSetting;
  final void Function() reset;

  @override
  final Widget child;

  static SettingProvider? maybeOf(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<SettingProvider>()
        as SettingProvider;
  }

  static SettingProvider of(BuildContext context) {
    final SettingProvider? result = maybeOf(context);
    assert(result != null, 'No FrogColor found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(SettingProvider oldWidget) {
    return oldWidget.setting != setting;
  }
}
