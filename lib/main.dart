// © 2022, Paul Sumpner <sumpner@hotmail.com>

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:futurama_quiz/data/data_notifier.dart';
import 'package:futurama_quiz/out.dart';
import 'package:futurama_quiz/view/home_page.dart';
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
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
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
      ),
    );
  }
}
