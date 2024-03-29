import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:qlutter/feature/player_progress/player_progress.dart';
import 'package:qlutter/i18n/strings.g.dart';
import '../style/palette.dart';
import '../style/responsive_screen.dart';
// import 'language_dialog.dart';
import 'settings.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  static const _gap = SizedBox(height: 60);

  @override
  Widget build(BuildContext context) {
    final settings = context.watch<SettingsController>();
    final palette = context.watch<Palette>();
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
        body: ResponsiveScreen(
          squarishMainArea: ListView(
            children: [
              ThemeSwitcher.withTheme(
                builder: (_, switcher, t) => ValueListenableBuilder<String>(
                  valueListenable: settings.theme,
                  builder: (context, theme, child) => _SettingsLine(
                    localization.setting.theme,
                    Icon(
                      settings.theme.value == 'dark'
                          ? Icons.nightlight
                          : Icons.wb_sunny,
                    ),
                    onSelected: () {
                      switcher.changeTheme(
                          theme: t.brightness == Brightness.light
                              ? palette.dark
                              : palette.light);
                      settings.setTheme(
                          t.brightness.name == 'light' ? 'dark' : 'light');
                    },
                  ),
                ),
              ),
              _gap,
              ValueListenableBuilder<String>(
                valueListenable: settings.language,
                builder: (context, language, child) => _SettingsLine(
                  t.setting.language.title,
                  Text(language == 'en'
                      ? t.setting.language.languages.ru
                      : t.setting.language.languages.en),
                  onSelected: () =>
                      settings.setLanguage(language == 'en' ? 'ru' : 'en'),
                ),
              ),
              // Consumer<InAppPurchaseController?>(
              //     builder: (context, inAppPurchase, child) {
              //   if (inAppPurchase == null) {
              //     // In-app purchases are not supported yet.
              //     // Go to lib/main.dart and uncomment the lines that create
              //     // the InAppPurchaseController.
              //     return const SizedBox.shrink();
              //   }

              //   Widget icon;
              //   VoidCallback? callback;
              //   if (inAppPurchase.adRemoval.active) {
              //     icon = const Icon(Icons.check);
              //   } else if (inAppPurchase.adRemoval.pending) {
              //     icon = const CircularProgressIndicator();
              //   } else {
              //     icon = const Icon(Icons.ad_units);
              //     callback = () {
              //       inAppPurchase.buy();
              //     };
              //   }
              //   return _SettingsLine(
              //     'Remove ads',
              //     icon,
              //     onSelected: callback,
              //   );
              // }),
              _gap,
              _SettingsLine(
                t.setting.reset,
                const Icon(Icons.delete),
                onSelected: () {
                  context.read<PlayerProgress>().reset();

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
            child: Text(t.setting.back,
                style: TextStyle(
                  fontFamily: palette.fontMain,
                  fontSize: 26,
                  // color: palette.ink,
                )),
          ),
        ),
      ),
    );
  }
}

// class _LanguageChangeLine extends StatelessWidget {
//   final String title;

//   const _LanguageChangeLine(this.title);

//   @override
//   Widget build(BuildContext context) {
//     final settings = context.watch<SettingsController>();

//     return InkResponse(
//       highlightShape: BoxShape.rectangle,
//       onTap: () => showLanguageDialog(context),
//       child: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 8),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text(title,
//                 style: const TextStyle(
//                   fontSize: 30,
//                 )),
//             const Spacer(),
//             ValueListenableBuilder(
//               valueListenable: settings.language,
//               builder: (context, name, child) => Text(
//                 '‘$name’',
//                 style: const TextStyle(
//                   fontSize: 30,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

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
            Text(title,
                style: const TextStyle(
                  fontSize: 30,
                )),
            const Spacer(),
            icon,
          ],
        ),
      ),
    );
  }
}
