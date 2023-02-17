// Copyright 2022, the Flutter project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

// import '../ads/ads_controller.dart';
// import '../ads/banner_ad_widget.dart';
import '../games_services/score.dart';
// import '../in_app_purchase/in_app_purchase.dart';
import '../style/palette.dart';
import '../style/responsive_screen.dart';

class WinGameScreen extends StatelessWidget {
  final Score score;

  const WinGameScreen({
    super.key,
    required this.score,
  });

  @override
  Widget build(BuildContext context) {
    // final adsControllerAvailable = context.watch<AdsController?>() != null;
    // final adsRemoved =
    //     context.watch<InAppPurchaseController?>()?.adRemoval.active ?? false;
    Palette palette = context.watch<Palette>();

    const gap = SizedBox(height: 10);

    return Scaffold(
      backgroundColor: palette.backgroundPlaySession,
      body: ResponsiveScreen(
        squarishMainArea: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // if (adsControllerAvailable && !adsRemoved) ...[
            //   const Expanded(
            //     child: Center(
            //       child: BannerAdWidget(),
            //     ),
            //   ),
            //],
            gap,
            Center(
              child: Text(
                'Победа!',
                style: TextStyle(fontFamily: palette.fontMain, fontSize: 50),
              ),
            ),
            gap,
            Center(
              child: Text(
                'Ход: ${score.score}\n'
                'Время: ${score.formattedTime}',
                style: TextStyle(fontFamily: palette.fontMain, fontSize: 20),
              ),
            ),
          ],
        ),
        rectangularMenuArea: ElevatedButton(
          onPressed: () {
            // GoRouter.of(context).go('/play');
            GoRouter.of(context).go('/play/session/${score.level + 1}');
          },
          child: Text(
            'Вперед',
            style: TextStyle(
              fontFamily: palette.fontMain,
              fontSize: 20,
              color: palette.ink,
            ),
          ),
        ),
      ),
    );
  }
}
