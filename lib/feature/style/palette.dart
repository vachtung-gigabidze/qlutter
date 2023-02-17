// Copyright 2022, the Flutter project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

/// A palette of colors to be used in the game.
///
/// The reason we're not going with something like Material Design's
/// `Theme` is simply that this is simpler to work with and yet gives
/// us everything we need for a game.
///
/// Games generally have more radical color palettes than apps. For example,
/// every level of a game can have radically different colors.
/// At the same time, games rarely support dark mode.
///
/// Colors taken from this fun palette:
/// https://lospec.com/palette-list/crayola84
///
/// Colors here are implemented as getters so that hot reloading works.
/// In practice, we could just as easily implement the colors
/// as `static const`. But this way the palette is more malleable:
/// we could allow players to customize colors, for example,
/// or even get the colors from the network.

@Singleton()
class Palette {
  Color get pen => const Color(0xff1d75fb);
  Color get darkPen => const Color(0xFF0050bc);
  Color get redPen => const Color(0xFFd10841);
  Color get inkFullOpacity => const Color(0xff352b42);
  Color get ink => const Color(0xee352b42);
  Color get backgroundMain => const Color(0xffffffd1);
  Color get backgroundField => const Color(0xffffffff);
  Color get backgroundAuth => const Color(0xffffffb1);
  Color get backgroundLevelSelection => const Color(0xffa2dcc7);
  Color get backgroundPlaySession => const Color(0xffffebb5);
  Color get background4 => const Color(0xffffd7ff);
  Color get backgroundSettings => const Color(0xffbfc8e3);
  Color get trueWhite => const Color(0xffffffff);

  Color get blockColor => Colors.grey;
  Color get cellColor1 => Colors.green;
  Color get cellColor2 => Colors.red;
  Color get cellColor3 => Colors.blue;
  Color get cellColor4 => Colors.yellow;
  Color get cellColor5 => Colors.purple;
  Color get cellColor6 => Colors.cyan;
  String get fontMain => 'DS Goose';
  /*
  Color get cellColor1 => const Color(0xfff5bfd2);
  Color get cellColor2 => const Color(0xffa1cdce);
  Color get cellColor3 => const Color(0xffe5db9c);
  Color get cellColor4 => const Color(0xffbeb4c5);
  Color get cellColor5 => const Color(0xffe6a57e);
  Color get cellColor6 => const Color(0xff218b82);
  */
}
