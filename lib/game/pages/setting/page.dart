import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:qlutter/app/ui/components/components.dart';
import 'package:qlutter/game/provider/setting_provider.dart';
import 'package:qlutter/i18n/strings.g.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  static const _gap = SizedBox(height: 60);

  @override
  Widget build(BuildContext context) {
    final settingProvider = SettingProvider.of(context);
    final setting = settingProvider.setting;
    final palette = Palette();
    final localization = Translations.of(context);

    return ThemeSwitchingArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: Text(
            localization.setting.title,
            style: TextStyle(
              fontFamily: palette.fontMain,
              fontSize: 32,
              height: 1,
            ),
          ),
        ),
        body: AppResponsiveScreen(
          squarishMainArea: ListView(
            children: [
              // ThemeSwitcher.withTheme(
              //   builder:
              //       (_, switcher, t) => ValueListenableBuilder<String>(
              //         valueListenable: settings.theme,
              //         builder:
              //             (context, theme, child) => _SettingsLine(
              //               localization.setting.theme,
              //               Icon(
              //                 settings.theme.value == 'dark'
              //                     ? Icons.nightlight
              //                     : Icons.wb_sunny,
              //               ),
              //               onSelected: () {
              //                 switcher.changeTheme(
              //                   theme:
              //                       t.brightness == Brightness.light
              //                           ? palette.dark
              //                           : palette.light,
              //                 );
              //                 settings.setTheme(
              //                   t.brightness.name == 'light' ? 'dark' : 'light',
              //                 );
              //               },
              //             ),
              //       ),
              // ),
              _gap,

              // ValueListenableBuilder<String>(
              //   valueListenable: settings.language,
              //   builder:
              //       (context, language, child) => _SettingsLine(
              //         t.setting.language.title,
              //         Text(
              //           language == 'en'
              //               ? t.setting.language.languages.ru
              //               : t.setting.language.languages.en,
              //         ),
              //         onSelected:
              //             () => settings.setLanguage(
              //               language == 'en' ? 'ru' : 'en',
              //             ),
              //       ),
              // ),
              _gap,
              _SettingsLine(
                t.setting.reset,
                const Icon(Icons.delete),
                onSelected: () {
                  settingProvider.reset();

                  final messenger = ScaffoldMessenger.of(context);
                  messenger.showSnackBar(
                    SnackBar(content: Text(t.setting.reset)),
                  );
                },
              ),
              // _gap,
            ],
          ),
          rectangularMenuArea: ElevatedButton(
            onPressed: () {
              GoRouter.of(context).pop();
            },
            child: Text(
              t.setting.back,
              style: TextStyle(
                fontFamily: palette.fontMain,
                fontSize: 26,
                // color: palette.ink,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _SettingsLine extends StatelessWidget {
  final String title;

  final Widget icon;

  final VoidCallback? onSelected;

  const _SettingsLine(this.title, this.icon, {this.onSelected});

  @override
  Widget build(BuildContext context) {
    return InkResponse(
      highlightShape: BoxShape.rectangle,
      onTap: onSelected,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(title, style: const TextStyle(fontSize: 30)),
            const Spacer(),
            icon,
          ],
        ),
      ),
    );
  }
}
