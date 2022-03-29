// © 2022, Paul Sumpner <sumpner@hotmail.com>

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:futurama_quiz/main.dart';
import 'package:futurama_quiz/strings.dart';
import 'package:futurama_quiz/view/background.dart';
import 'package:futurama_quiz/view/characters_page.dart';
import 'package:futurama_quiz/view/info_page.dart';
import 'package:futurama_quiz/view/quiz_page.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';

Future<http.Response> _getGoodResponse(http.Request url) async {
  String fixture(String name) => File('test_data/$name').readAsStringSync();

  const base = 'GET https://api.sampleapis.com/futurama/';

  final headers = {
    HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'
  };

  switch (url.toString()) {
    case base + 'info':
      return http.Response(fixture('info.json'), 200, headers: headers);
    case base + 'characters':
      return http.Response(fixture('characters.json'), 200, headers: headers);
    case base + 'questions':
      return http.Response(fixture('questions.json'), 200, headers: headers);
  }
  throw 'huh?';
}

Future<http.Response> _getEmptyListResponse(http.Request url) async {
  return http.Response('[]', 200);
}

void main() {
  final app = createApp(client: MockClient(_getGoodResponse));
  final emptyListApp = createApp(client: MockClient(_getEmptyListResponse));

  testWidgets('Info page', (WidgetTester tester) async {
    await tester.pumpWidget(app);

    expect(find.byType(Background), findsOneWidget);
    expect(find.byType(ListView), findsOneWidget);

    // before rebuild
    expect(find.textContaining('Philip J. Fry is'), findsNothing);
    await tester.pump();
    //after rebuild!
    expect(find.textContaining('Philip J. Fry is'), findsOneWidget);
  });

  testWidgets('Info page - Empty list', (WidgetTester tester) async {
    await tester.pumpWidget(emptyListApp);

    expect(find.byType(Background), findsOneWidget);
    expect(find.byType(ListView), findsOneWidget);

    // before rebuild
    expect(find.textContaining('Failed'), findsNothing);
    await tester.pump();
    //after rebuild!
    expect(find.textContaining('Failed'), findsOneWidget);
  });

  testWidgets('Navigate from Info page to Characters Page',
      (WidgetTester tester) async {
        await tester.pumpWidget(app);
    await tester.pump();
    expect(find.textContaining('Philip J. Fry is'), findsOneWidget);
    expect(find.textContaining(Strings.characters), findsOneWidget);
    expect(find.textContaining(Strings.quiz), findsOneWidget);
    expect(find.byType(TextButton), findsNWidgets(2));
    await tester.tap(find.widgetWithText(TextButton, Strings.characters));
    await tester.pump();
    expect(find.byType(InfoPage), findsOneWidget);

    await tester.pump();
    expect(find.byType(InfoPage), findsOneWidget);
    expect(find.byType(CharactersPage), findsOneWidget);
    expect(find.textContaining('Bender Bending Rodriguez'), findsOneWidget);
  });

  testWidgets('Navigate from Info page to Characters Page - Empty List',
      (WidgetTester tester) async {
        await tester.pumpWidget(emptyListApp);
    await tester.pump();
    expect(find.textContaining('Failed'), findsOneWidget);
    expect(find.textContaining(Strings.characters), findsOneWidget);
    expect(find.textContaining(Strings.quiz), findsOneWidget);
    expect(find.byType(TextButton), findsNWidgets(2));
    await tester.tap(find.widgetWithText(TextButton, Strings.characters));
    await tester.pump();
    expect(find.byType(InfoPage), findsOneWidget);

    await tester.pump();
    expect(find.byType(InfoPage), findsOneWidget);
    expect(find.byType(CharactersPage), findsOneWidget);
    expect(find.textContaining('Bender Bending Rodriguez'), findsNothing);
  });

  // TODO add more Empty List ones from this one onwards.
  testWidgets('Navigate Info => Characters => Biography Page',
      (WidgetTester tester) async {
        await tester.pumpWidget(app);
    await tester.pump();
    expect(find.textContaining('Philip J. Fry is'), findsOneWidget);
    expect(find.textContaining(Strings.characters), findsOneWidget);
    expect(find.textContaining(Strings.quiz), findsOneWidget);
    expect(find.byType(TextButton), findsNWidgets(2));
    await tester.tap(find.widgetWithText(TextButton, Strings.characters));
    await tester.pump();
    expect(find.byType(InfoPage), findsOneWidget);

    await tester.pump();
    expect(find.byType(CharactersPage), findsOneWidget);
    await tester.tap(find.widgetWithText(TextButton, 'Philip Jay Fry.'));

    await tester.pump();
    //TODO warning doesn't get to BiographyPage
    // expect(find.byType(BiographyPage), findsOneWidget);
    // expect(find.textContaining('Human Male'), findsOneWidget);
    expect(find.textContaining('Philip Jay Fry.'), findsOneWidget);
  });

  testWidgets('Navigate from Info to Quiz Page', (WidgetTester tester) async {
    await tester.pumpWidget(app);
    await tester.pump();
    expect(find.textContaining('Philip J. Fry is'), findsOneWidget);
    expect(find.textContaining(Strings.characters), findsOneWidget);
    expect(find.textContaining(Strings.quiz), findsOneWidget);

    expect(find.byType(TextButton), findsNWidgets(2));
    await tester.tap(find.widgetWithText(TextButton, Strings.quiz));
    await tester.pump();
    expect(find.byType(InfoPage), findsOneWidget);

    await tester.pump();
    expect(find.byType(QuizPage), findsOneWidget);
  });

  testWidgets('Info => Quiz => Answer Correctly.', (WidgetTester tester) async {
    // TODO Landscape tests
    const double portraitWidth = 400.0;
    const double portraitHeight = 1200.0;
    const double landscapeWidth = portraitHeight;
    const double landscapeHeight = portraitWidth;

    final binding = TestWidgetsFlutterBinding.ensureInitialized()
        as TestWidgetsFlutterBinding;

    // await binding.setSurfaceSize(const Size(portraitWidth, portraitHeight));

    await tester.pumpWidget(app);
    await tester.pump();

    await binding.setSurfaceSize(const Size(landscapeWidth, landscapeHeight));
    await tester.pump();

    expect(find.textContaining('Philip J. Fry is'), findsOneWidget);
    expect(find.textContaining(Strings.characters), findsOneWidget);
    expect(find.textContaining(Strings.quiz), findsOneWidget);

    expect(find.byType(TextButton), findsNWidgets(2));
    await tester.tap(find.widgetWithText(TextButton, Strings.quiz));
    await tester.pump();
    expect(find.byType(InfoPage), findsOneWidget);

    await tester.pump();
    expect(find.byType(QuizPage), findsOneWidget);
    expect(find.textContaining('0 correct'), findsOneWidget);

    await tester.tap(find.byWidgetPredicate(
        (widget) => widget is Radio && widget.value == Answer.two));
    await tester.pump();

    expect(find.textContaining('1 correct'), findsOneWidget);
  });
}
