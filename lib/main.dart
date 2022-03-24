// © 2022, Paul Sumpner <sumpner@hotmail.com>

import 'package:flutter/material.dart';
import 'package:futurama_quiz/data/data_notifier.dart';
import 'package:futurama_quiz/out.dart';
import 'package:futurama_quiz/view/home_page.dart';
import 'package:provider/provider.dart';

/// prevent 'organise imports' from removing imports
/// when temporarily commenting out.
const noWarn = out;

void main() => runApp(createApp());

Widget createApp() => const MyApp();

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

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
        home: const HomePage(title: 'Flutter Demo Home Page'),
      ),
    );
  }
}
