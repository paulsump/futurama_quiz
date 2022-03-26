// © 2022, Paul Sumpner <sumpner@hotmail.com>

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:futurama_quiz/fetch_notifier.dart';
import 'package:futurama_quiz/out.dart';
import 'package:futurama_quiz/quiz_notifier.dart';
import 'package:futurama_quiz/view/biography_page.dart';
import 'package:futurama_quiz/view/characters_page.dart';
import 'package:futurama_quiz/view/hue.dart';
import 'package:futurama_quiz/view/info_page.dart';
import 'package:futurama_quiz/view/quiz_page.dart';
import 'package:provider/provider.dart';

/// prevent 'organise imports' from removing imports
/// when temporarily commenting out.
const noWarn = out;

void main() => runApp(createApp());

Widget createApp() => const _App();

class _App extends StatelessWidget {
  const _App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => FetchNotifier()),
        ChangeNotifierProvider(create: (_) => QuizNotifier()),
      ],
      child: MaterialApp(
        title: 'Futurama',
        theme: _buildThemeData(context),
        home: LayoutBuilder(
          builder: (
            BuildContext context,
            BoxConstraints constraints,
          ) {
            if (constraints.maxHeight == 0) {
              return Container();
            } else {
              final fetchNotifier = getFetchNotifier(context, listen: false);

              if (!fetchNotifier.initializeHasBeenCalled) {
                unawaited(fetchNotifier.initialize(context));
              }

              return const InfoPage();
            }
          },
        ),
        routes: {
          // 'Info': (context) => const InfoPage(),
          'Characters': (context) => const CharactersPage(),
          'Biography': (context) => const BiographyPage(),
          'Quiz': (context) => const QuizPage(),
          'Results': (context) => const ResultsPage(),
        },
      ),
    );
  }

  ThemeData _buildThemeData(BuildContext context) {
    return ThemeData(
      canvasColor: Hue.menu,
      textTheme: Theme.of(context).textTheme.apply(bodyColor: Hue.text),
      // for icon buttons only atm
      iconTheme: Theme.of(context).iconTheme.copyWith(
            color: Hue.enabledIcon,
          ),
      tooltipTheme: TooltipThemeData(
        /// TODO Responsive to screen size - removed magic numbers
        verticalOffset: 55,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(color: Hue.tip),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
        primary: Hue.button,
      )),
    );
  }
}
