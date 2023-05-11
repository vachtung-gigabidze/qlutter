import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:qlutter/i18n/strings.g.dart';
import '../style/palette.dart';
import '../style/responsive_screen.dart';
import 'language_dialog.dart';
import 'settings.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  static const _gap = SizedBox(height: 60);

  @override
  Widget build(BuildContext context) {
    final settings = context.watch<SettingsController>();
    final palette = context.watch<Palette>();
    final t = Translations.of(context);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(
          t.setting.title,
          //textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: palette.fontMain,
            fontSize: 32,
            height: 1,
          ),
        ),
      ),
      // backgroundColor: palette.backgroundSettings,
      body: ResponsiveScreen(
        squarishMainArea: ListView(
          children: [
            // const _NameChangeLine(
            //   'Тема',
            // ),
            ValueListenableBuilder<String>(
              valueListenable: settings.theme,
              builder: (context, soundsOn, child) => _SettingsLine(
                t.setting.theme,
                const Icon(Icons.lightbulb_outline_rounded),
                onSelected: () => settings.setLanguage('light'),
              ),
            ),
            ValueListenableBuilder<String>(
              valueListenable: settings.language,
              builder: (context, musicOn, child) => _LanguageChangeLine(
                t.setting.language,
                //const Icon(Icons.language),
                //onSelected: () => settings.setLanguage('russian'),
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
            // _SettingsLine(
            //   'Сброс прогресса',
            //   const Icon(Icons.delete),
            //   onSelected: () {
            //     context.read<PlayerProgress>().reset();

            //     final messenger = ScaffoldMessenger.of(context);
            //     messenger.showSnackBar(
            //       const SnackBar(content: Text('Прогресс сброшен')),
            //     );
            //   },
            // ),
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
                color: palette.ink,
              )),
        ),
      ),
    );
  }
}

class _LanguageChangeLine extends StatelessWidget {
  final String title;

  const _LanguageChangeLine(this.title);

  @override
  Widget build(BuildContext context) {
    final settings = context.watch<SettingsController>();

    return InkResponse(
      highlightShape: BoxShape.rectangle,
      onTap: () => showLanguageDialog(context),
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
            ValueListenableBuilder(
              valueListenable: settings.language,
              builder: (context, name, child) => Text(
                '‘$name’',
                style: const TextStyle(
                  fontSize: 30,
                ),
              ),
            ),
          ],
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
