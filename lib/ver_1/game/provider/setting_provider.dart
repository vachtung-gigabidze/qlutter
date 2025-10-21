import 'package:flutter/material.dart';
import 'package:qlutter/ver_1/game/level_builder/level_builder.dart';
import 'package:qlutter/ver_1/game/models/score.dart';
import 'package:qlutter/ver_1/game/models/setting.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingStateWidget extends StatefulWidget {
  const SettingStateWidget({required this.child, super.key});

  final Widget child;

  @override
  State<SettingStateWidget> createState() => _SettingStateWidgetState();
}

class _SettingStateWidgetState extends State<SettingStateWidget> {
  late Setting setting;

  Future<Setting> loadSetting() async {
    try {
      var preferences = await SharedPreferences.getInstance();
      var v = preferences.getString('setting');
      if (v != null) {
        setting = Setting.fromJson(v);
        return setting;
      }
      levelBuilder = LevelBuilder();
      await levelBuilder.readLevels();
    } catch (e) {}
    setting = Setting(
      theme: 'light',
      lastLevel: 0,
      language: 'ru',
      score: Score(score: 0, duration: const Duration(seconds: 0), level: 0),
    );
    return setting;
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> saveSetting(Setting newSetting) async {
    var preferences = await SharedPreferences.getInstance();
    var result = await preferences.setString('setting', newSetting.toJson());
    if (result) {
      setState(() {
        setting = newSetting;
      });
    }
  }

  Future<void> reset() async {}
  late LevelBuilder levelBuilder;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) => FutureBuilder<Setting>(
    future: loadSetting(),
    builder: (context, snapshot) {
      if (!snapshot.hasData) {
        return const Center(child: CircularProgressIndicator());
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

class SettingProvider extends InheritedWidget {
  const SettingProvider({
    required this.saveSetting,
    required this.reset,
    required this.setting,
    required this.levelBuilder,
    required this.child,
    super.key,
  }) : super(child: child);
  final Setting setting;
  final LevelBuilder levelBuilder;
  final void Function(Setting setting) saveSetting;
  final void Function() reset;

  @override
  final Widget child;

  static SettingProvider? maybeOf(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<SettingProvider>()
          as SettingProvider;

  static SettingProvider of(BuildContext context) {
    final result = maybeOf(context);
    assert(result != null, 'No FrogColor found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(SettingProvider oldWidget) =>
      oldWidget.setting != setting;
}
