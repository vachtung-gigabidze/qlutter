import 'dart:async';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:qlutter/game/core.dart';
import 'package:qlutter/game/level_manager.dart';
import 'package:qlutter/game/styles.dart';
import 'package:qlutter/game/ui/alerts/about.dart';
import 'package:qlutter/game/ui/alerts/accent_colors.dart';
import 'package:qlutter/game/ui/block_item.dart';
import 'package:shared_preferences/shared_preferences.dart';

// import 'dart:html';

class FieldView extends StatefulWidget {
  const FieldView({super.key});

  @override
  State<FieldView> createState() => FieldViewState();
}

class FieldViewState extends State<FieldView> {
  int paddingSize = 0;
  late double elementSize;
  Field? field;
  Field? fieldCopy;
  late Size fieldSize;
  late Size maxViewSize;
  late Future<Level?> level;
  Ball? selectedItem;
  late int? selectedLevel;
  bool showHover = false;
  late LevelManager lm;
  List<Widget> walls = [];
  List<Widget> holes = [];
  List<Widget> balls = [];
  late bool refresh;
  late String? currentTheme;
  late String? currentAccentColor;

  @override
  void initState() {
    super.initState();
    refresh = false;
    selectedLevel = null;
    elementSize = 45;
    maxViewSize = const Size(0, 0);
    fieldSize = Size(elementSize, elementSize);
    lm = LevelManager();

    getPrefs().whenComplete(() {
      if (currentTheme == null) {
        if (MediaQuery.maybeOf(context)?.platformBrightness != null) {
          currentTheme =
              MediaQuery.of(context).platformBrightness == Brightness.light
                  ? 'light'
                  : 'dark';
        } else {
          currentTheme = 'dark';
        }
        setPrefs('currentTheme');
      }
      if (currentAccentColor == null) {
        currentAccentColor = 'Blue';
        setPrefs('currentAccentColor');
      }
      if (selectedLevel == null) {
        selectedLevel = 0;
        setPrefs('selectedLevel');
      }

      changeTheme('set');
      changeAccentColor(currentAccentColor!, true);
    });
  }

  Widget _buildBall(Item item, double t, double r, Key? key) {
    return AnimatedPositioned(
      key: key,
      top: (t * fieldSize.height),
      right: (r * fieldSize.height),
      duration: const Duration(seconds: 1),
      curve: Curves.bounceOut,
      onEnd: () {
        if ((field!.acceptHole(Coordinates(t.toInt(), r.toInt())))) {
          setState(() {
            //   if (field!.checkWin()) {}
          });
        }
      },
      child: BlockItem(
        item: item,
        elementSize: elementSize,
        selected: false,
        //onHover: (bool value) {},
        onTap: () {
          if (kIsWeb) {
            if (item is Ball) {
              setState(() {
                selectedItem = item;
              });
            }
          }
        },
      ),
    );
  }

  Widget _buildItem(Item item, double t, double r) {
    return Positioned(
      top: (t * fieldSize.height),
      right: (r * fieldSize.height),
      child: BlockItem(
        item: item,
        elementSize: elementSize,
        selected: false,
        onHover: null,
        onTap: null,
      ),
    );
  }

  Widget _buildHover(Coordinates c) {
    List<bool> directionMask =
        field!.canMove(Coordinates(c.horizontal, c.vertical));
    return Positioned(
      top: (c.horizontal - 1) * fieldSize.height,
      right: (c.vertical - 1) * fieldSize.height,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
            hoverColor: Colors.transparent,
            splashColor: Colors.transparent,
            splashFactory: NoSplash.splashFactory,
            onHover: (bool value) {},
            onTap: () {},
            child: SizedBox(
              height: elementSize * 3,
              width: elementSize * 3,
              child: Stack(
                  children: [
                Positioned(
                  top: elementSize,
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        field?.moveItem(c, Direction.right);
                        selectedItem = null;
                      });
                    },
                    child: Icon(
                      Icons.arrow_back_outlined,
                      color: Styles.foregroundColor,
                      size: elementSize,
                    ),
                  ),
                ),
                Positioned(
                  top: elementSize,
                  right: 0,
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        field?.moveItem(c, Direction.left);
                        selectedItem = null;
                      });
                    },
                    child: Icon(
                      Icons.arrow_forward_outlined,
                      color: Styles.foregroundColor,
                      size: elementSize,
                    ),
                  ),
                ),
                Positioned(
                  top: elementSize * 2,
                  right: elementSize,
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        field?.moveItem(c, Direction.down);
                        selectedItem = null;
                      });
                    },
                    child: Icon(
                      Icons.arrow_downward,
                      color: Styles.foregroundColor,
                      size: elementSize,
                    ),
                  ),
                ),
                Positioned(
                  top: 0,
                  right: elementSize,
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        field?.moveItem(c, Direction.up);
                        selectedItem = null;
                        // showHover = false;
                      });
                    },
                    child: Icon(
                      Icons.arrow_upward,
                      color: Styles.foregroundColor,
                      size: elementSize,
                    ),
                  ),
                ),
              ]
                      .asMap()
                      .entries
                      .where((e) => directionMask[e.key])
                      .map((e) => e.value)
                      .toList()),
            )),
      ),
    );
  }

  List<Widget> generateFieldItem(List<List<Item?>> fields) {
    balls = [];
    holes = [];
    walls = [];
    Widget? hover;

    double t = 0, r = 0;
    for (var row in fields) {
      for (Item? i in row) {
        if (i != null) {
          if (i is Ball) {
            balls.add(_buildBall(i, t, r, Key('Ball${i.id}')));
            if (i.id == selectedItem?.id) {
              hover = _buildHover(
                Coordinates(t.toInt(), r.toInt()),
              );
            }
          } else if (i is Hole) {
            holes.add(_buildItem(i, t, r));
          } else {
            walls.add(_buildItem(i, t, r));
          }
        }
        r++;
      }
      t++;
      r = 0;
    }
    if (hover != null && selectedItem != null) {
      walls.add(hover);
    }
    walls.addAll(holes);
    if (balls.isNotEmpty) {
      walls.addAll(balls);
    }
    return walls;
  }

  Future<Field?> _getField() async {
    if (refresh) {
      refresh = false;
      return Future.value(lm.copyField(fieldCopy!));
    }

    if (field == null || field?.level.levelId != selectedLevel) {
      field = await lm.getFiled(selectedLevel!);
      fieldCopy = lm.copyField(field!);
    }

    return Future.value(field);
  }

  void setSize(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    double m = min<double>(width, height);
    m *= .9;
    double i = max<double>(field!.level.size.height, field!.level.size.width);

    elementSize = m / i;
    fieldSize = Size(elementSize, elementSize);
    maxViewSize = Size(field!.level.size.height * elementSize,
        field!.level.size.width * elementSize);
  }

  Future<void> getPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      selectedLevel = prefs.getInt('selectedLevel');
      currentTheme = prefs.getString('currentTheme');
      currentAccentColor = prefs.getString('currentAccentColor');
    });
  }

  setPrefs(String property) async {
    final prefs = await SharedPreferences.getInstance();
    if (property == 'currentTheme') {
      prefs.setString('currentTheme', currentTheme ?? "");
    } else if (property == 'currentAccentColor') {
      prefs.setString('currentAccentColor', currentAccentColor ?? "");
    } else if (property == 'selectedLevel') {
      prefs.setInt('selectedLevel', selectedLevel ?? 0);
    }
  }

  void changeAccentColor(String color, [bool firstRun = false]) {
    setState(() {
      if (Styles.accentColors.keys.contains(color)) {
        Styles.primaryColor = Styles.accentColors[color]!;
      } else {
        currentAccentColor = 'Blue';
        Styles.primaryColor = Styles.accentColors[color]!;
      }
      if (color == 'Red') {
        Styles.secondaryColor = Styles.orange;
      } else {
        Styles.secondaryColor = Styles.lightRed;
      }
      if (!firstRun) {
        setPrefs('currentAccentColor');
      }
    });
  }

  showOptionModalSheet(BuildContext context) {
    BuildContext outerContext = context;
    showModalBottomSheet(
        context: context,
        backgroundColor: Styles.secondaryBackgroundColor,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(10),
          ),
        ),
        builder: (context) {
          final TextStyle customStyle =
              TextStyle(inherit: false, color: Styles.foregroundColor);
          return Wrap(
            children: [
              ListTile(
                leading: Icon(Icons.refresh, color: Styles.foregroundColor),
                title: Text('Restart Level', style: customStyle),
                onTap: () {
                  Navigator.pop(context);
                  Timer(
                      const Duration(milliseconds: 200), () => restartLevel());
                },
              ),
              ListTile(
                leading: Icon(Icons.invert_colors_on_rounded,
                    color: Styles.foregroundColor),
                title: Text('Switch Theme', style: customStyle),
                onTap: () {
                  Navigator.pop(context);
                  Timer(const Duration(milliseconds: 200), () {
                    changeTheme('switch');
                  });
                },
              ),
              ListTile(
                leading: Icon(Icons.color_lens_outlined,
                    color: Styles.foregroundColor),
                title: Text('Change Accent Color', style: customStyle),
                onTap: () {
                  Navigator.pop(context);
                  Timer(
                      const Duration(milliseconds: 200),
                      () => showAnimatedDialog<void>(
                              animationType: DialogTransitionType.fadeScale,
                              barrierDismissible: true,
                              duration: const Duration(milliseconds: 350),
                              context: outerContext,
                              builder: (_) => AlertAccentColorsState(
                                  currentAccentColor!)).whenComplete(() {
                            if (AlertAccentColorsState.accentColor != null) {
                              Timer(const Duration(milliseconds: 300), () {
                                currentAccentColor =
                                    AlertAccentColorsState.accentColor;
                                changeAccentColor(
                                    currentAccentColor.toString());
                                AlertAccentColorsState.accentColor = null;
                                setPrefs('currentAccentColor');
                              });
                            }
                          }));
                },
              ),
              ListTile(
                leading: Icon(Icons.info_outline_rounded,
                    color: Styles.foregroundColor),
                title: Text('About', style: customStyle),
                onTap: () {
                  Navigator.pop(context);
                  Timer(
                      const Duration(milliseconds: 200),
                      () => showAnimatedDialog<void>(
                          animationType: DialogTransitionType.fadeScale,
                          barrierDismissible: true,
                          duration: const Duration(milliseconds: 350),
                          context: outerContext,
                          builder: (_) => const AlertAbout()));
                },
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(56.0),
          child: AppBar(
            centerTitle: true,
            title: const Text('Qlutter'),
            backgroundColor: Styles.primaryColor,
          )),
      floatingActionButton: FloatingActionButton(
        foregroundColor: Styles.primaryBackgroundColor,
        backgroundColor: Styles.primaryColor,
        onPressed: () => showOptionModalSheet(context),
        child: const Icon(Icons.menu_rounded),
      ),
      backgroundColor: Styles.primaryBackgroundColor,
      body: Column(
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
            IconButton(
              onPressed: () {
                setState(() {
                  selectedLevel = selectedLevel! - 1;
                  setPrefs('selectedLevel');
                });
              },
              icon: const Icon(Icons.keyboard_arrow_left),
              color: Styles.foregroundColor,
            ),
            Text("Уровень: $selectedLevel",
                style: TextStyle(color: Styles.foregroundColor)),
            IconButton(
                onPressed: () {
                  setState(() {
                    selectedLevel = selectedLevel! + 1;
                    setPrefs('selectedLevel');
                  });
                },
                icon: const Icon(Icons.keyboard_arrow_right),
                color: Styles.foregroundColor)
          ]),
          FutureBuilder<Field?>(
              initialData: field,
              future: _getField(),
              builder: (BuildContext context, AsyncSnapshot<Field?> snapshot) {
                if (snapshot.hasData) {
                  field = snapshot.data!;

                  setSize(context);
                  return Column(
                    children: [
                      const SizedBox(
                        height: 30,
                      ),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                      //   children: [
                      //     Text("Шаров: ${field?.ballsCount ?? 0}",
                      //         style: TextStyle(color: Styles.foregroundColor)),
                      //   ],
                      // ),
                      // const SizedBox(
                      //   height: 30,
                      // ),
                      SizedBox(
                        height: maxViewSize.height,
                        width: maxViewSize.width,
                        child: Stack(
                          children:
                              generateFieldItem(snapshot.data!.level.field),
                        ),
                      ),
                    ],
                  );
                } else {
                  return const Text('No data');
                }
              }),
        ],
      ),
    );
  }

  restartLevel() {
    setState(() {
      refresh = true;
    });
  }

  void changeTheme(String mode) {
    setState(() {
      if (currentTheme == 'light') {
        if (mode == 'switch') {
          Styles.primaryBackgroundColor = Styles.darkGrey;
          Styles.secondaryBackgroundColor = Styles.grey;
          Styles.foregroundColor = Styles.white;
          currentTheme = 'dark';
        } else if (mode == 'set') {
          Styles.primaryBackgroundColor = Styles.white;
          Styles.secondaryBackgroundColor = Styles.white;
          Styles.foregroundColor = Styles.darkGrey;
        }
      } else if (currentTheme == 'dark') {
        if (mode == 'switch') {
          Styles.primaryBackgroundColor = Styles.white;
          Styles.secondaryBackgroundColor = Styles.white;
          Styles.foregroundColor = Styles.darkGrey;
          currentTheme = 'light';
        } else if (mode == 'set') {
          Styles.primaryBackgroundColor = Styles.darkGrey;
          Styles.secondaryBackgroundColor = Styles.grey;
          Styles.foregroundColor = Styles.white;
        }
      }
      setPrefs('currentTheme');
    });
  }
}
