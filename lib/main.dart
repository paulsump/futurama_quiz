// © 2022, Paul Sumpner <sumpner@hotmail.com>

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:futurama_quiz/data/data_notifier.dart';
import 'package:futurama_quiz/out.dart';
import 'package:futurama_quiz/state/state_notifier.dart';
import 'package:futurama_quiz/view/characters.dart';
import 'package:futurama_quiz/view/home_page.dart';
import 'package:futurama_quiz/view/hue.dart';
import 'package:futurama_quiz/view/quiz_view.dart';
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
        ChangeNotifierProvider(create: (_) => DataNotifier()),
        ChangeNotifierProvider(create: (_) => StateNotifier()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: _buildThemeData(context),
        home: LayoutBuilder(
          builder: (
            BuildContext context,
            BoxConstraints constraints,
          ) {
            if (constraints.maxHeight == 0) {
              return Container();
            } else {
              final dataNotifier = getDataNotifier(context, listen: false);

              // Initialize once only
              if (!dataNotifier.initializeHasBeenCalled) {
                unawaited(dataNotifier.initialize(context));
              }

              return const HomePage();
            }
          },
        ),
        routes: {
          'Home': (context) => const HomePage(),
          'Characters': (context) => const CharacterListView(),
          'CharacterBiography': (context) => const CharacterBiography(),
          'Quiz': (context) => const QuizView(),
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
