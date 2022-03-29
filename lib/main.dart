// © 2022, Paul Sumpner <sumpner@hotmail.com>

import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:futurama_quiz/fetch_notifier.dart';
import 'package:futurama_quiz/out.dart';
import 'package:futurama_quiz/quiz_notifier.dart';
import 'package:futurama_quiz/view/biography_page.dart';
import 'package:futurama_quiz/view/characters_page.dart';
import 'package:futurama_quiz/view/info_page.dart';
import 'package:futurama_quiz/view/quiz_page.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

// For setting HttpOverrides.global = MyHttpOverrides();
// This removes the CERTIFICATE_VERIFY_FAILED when running certain emulators.
// TODO remove this for release
// class MyHttpOverrides extends HttpOverrides {
//   @override
//   HttpClient createHttpClient(SecurityContext? context) {
//     return super.createHttpClient(context)
//       ..badCertificateCallback =
//           (X509Certificate cert, String host, int port) => true;
//   }
// }

/// The main entry point for the flutter app
void main() {
  if (!kReleaseMode) {
    // TODO remove this for release
    // This removes the CERTIFICATE_VERIFY_FAILED when running certain emulators.
    // In release, might see "SocketException: Failed host lookup: 'api.sampleapis.com' (OS Error: No address associated with hostname, errno = 7)"
    out('TODO REMOVE THIS FOR PRODUCTION CODE!');
    // HttpOverrides.global = MyHttpOverrides();
  }
  runApp(createApp(client: http.Client()));
}

/// Create the app instance (uses in tests too)
/// This allow the app to be private
Widget createApp({required http.Client client}) => _App(client: client);

/// The only app.  Has all the notifiers and navigator routes.
/// Calls fetchAll() once on the FetchNotifier.
class _App extends StatelessWidget {
  const _App({Key? key, required http.Client client})
      : _client = client,
        super(key: key);

  final http.Client _client;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => FetchNotifier()),
        ChangeNotifierProvider(create: (_) => QuizNotifier()),
      ],
      child: MaterialApp(
        title: 'Futurama',
        // theme: ThemeData(
        //     textTheme: Theme.of(context).textTheme.apply(bodyColor: Hue.text)),
        home: LayoutBuilder(
          builder: (
            BuildContext context,
            BoxConstraints constraints,
          ) {
            if (constraints.maxHeight == 0) {
              return Container();
            } else {
              final fetchNotifier = getFetchNotifier(context, listen: false);

              if (!fetchNotifier.fetchAllHasBeenCalled) {
                unawaited(fetchNotifier.fetchAll(context, _client));
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
}
