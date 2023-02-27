// Copyright 2022, the Flutter project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

// import '../in_app_purchase/in_app_purchase.dart';
import '../player_progress/player_progress.dart';
import '../style/palette.dart';
import '../style/responsive_screen.dart';
import 'custom_name_dialog.dart';
import 'settings.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  static const _gap = SizedBox(height: 60);

  @override
  Widget build(BuildContext context) {
    final settings = context.watch<SettingsController>();
    final palette = context.watch<Palette>();

    return Scaffold(
      backgroundColor: palette.backgroundSettings,
      body: ResponsiveScreen(
        squarishMainArea: ListView(
          children: [
            _gap,
            const Text(
              'Настройки',
              textAlign: TextAlign.center,
              style: TextStyle(
                // fontFamily: font,
                fontSize: 55,
                height: 1,
              ),
            ),
            _gap,
            // const _NameChangeLine(
            //   'Тема',
            // ),
            ValueListenableBuilder<String>(
              valueListenable: settings.theme,
              builder: (context, soundsOn, child) => _SettingsLine(
                'Тема',
                const Icon(Icons.theater_comedy),
                onSelected: () => settings.setLanguage('light'),
              ),
            ),
            ValueListenableBuilder<String>(
              valueListenable: settings.language,
              builder: (context, musicOn, child) => _SettingsLine(
                'Язык',
                const Icon(Icons.language),
                onSelected: () => settings.setLanguage('russian'),
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
            _SettingsLine(
              'Сброс прогресса',
              const Icon(Icons.delete),
              onSelected: () {
                context.read<PlayerProgress>().reset();

                final messenger = ScaffoldMessenger.of(context);
                messenger.showSnackBar(
                  const SnackBar(content: Text('Прогресс сброшен')),
                );
              },
            ),
            _gap,
          ],
        ),
        rectangularMenuArea: ElevatedButton(
          onPressed: () {
            GoRouter.of(context).pop();
          },
          child: Text('Назад',
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

class _NameChangeLine extends StatelessWidget {
  final String title;

  const _NameChangeLine(this.title);

  @override
  Widget build(BuildContext context) {
    final settings = context.watch<SettingsController>();

    return InkResponse(
      highlightShape: BoxShape.rectangle,
      onTap: () => showCustomNameDialog(context),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(title,
                style: const TextStyle(
                  fontFamily: 'Permanent Marker',
                  fontSize: 30,
                )),
            const Spacer(),
            ValueListenableBuilder(
              valueListenable: settings.theme,
              builder: (context, name, child) => Text(
                '‘$name’',
                style: const TextStyle(
                  fontFamily: 'Permanent Marker',
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
                  fontFamily: 'Permanent Marker',
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
