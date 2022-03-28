// © 2022, Paul Sumpner <sumpner@hotmail.com>

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:futurama_quiz/main.dart';
import 'package:futurama_quiz/out.dart';
import 'package:futurama_quiz/view/background.dart';
import 'package:futurama_quiz/view/biography_page.dart';
import 'package:futurama_quiz/view/characters_page.dart';
import 'package:futurama_quiz/view/info_page.dart';
import 'package:futurama_quiz/view/quiz_page.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';

const noWarn = [out, CharactersPage, BiographyPage, QuizPage];

void main() {
  String fixture(String name) => File('test_data/$name').readAsStringSync();

  final app = createApp(client: MockClient((url) async {
    const base = 'GET https://api.sampleapis.com/futurama/';
    switch (url.toString()) {
      case base + 'info':
        return http.Response(
            '[{"synopsis":"Philip J. Fry is...","yearsAired":"1999–2013","creators":[{"name":"David X. Cohen","url":"http://www.imdb.com/name/nm0169326"},{"name":"Matt Groening","url":"http://www.imdb.com/name/nm0004981"}],"id":1}]',
            200,
            headers: {
              HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'
            });
      case base + 'characters':
        return http.Response(fixture('characters.json'), 200, headers: {
          HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'
        });
      case base + 'questions':
        return http.Response(fixture('questions.json'), 200, headers: {
          HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'
        });
    }
    throw 'huh?';
  }));

  testWidgets('Info page', (WidgetTester tester) async {
    await tester.pumpWidget(app);

    expect(find.byType(Background), findsOneWidget);
    expect(find.byType(ListView), findsOneWidget);
    expect(find.text('Please connect to the internet.'), findsOneWidget);

    // before rebuild
    expect(find.textContaining('Philip J. Fry is...'), findsNothing);
    await tester.pump();
    //after rebuild!
    expect(find.textContaining('Philip J. Fry is...'), findsOneWidget);
  });

  testWidgets('Navigate from Info page to Characters Page',
      (WidgetTester tester) async {
    await tester.pumpWidget(app);
    await tester.pump();
    expect(find.textContaining('Philip J. Fry is...'), findsOneWidget);
    expect(find.textContaining('Characters'), findsOneWidget);
    expect(find.textContaining('Quiz'), findsOneWidget);
    expect(find.byType(TextButton), findsNWidgets(2));
    await tester.tap(find.widgetWithText(TextButton, 'Characters'));
    await tester.pump();
    expect(find.byType(InfoPage), findsOneWidget);

    await tester.pump();
    expect(find.byType(InfoPage), findsOneWidget);
    expect(find.byType(CharactersPage), findsOneWidget);
  });

  testWidgets('Navigate Info => Characters => Biography Page',
      (WidgetTester tester) async {
    await tester.pumpWidget(app);
    await tester.pump();
    expect(find.textContaining('Philip J. Fry is...'), findsOneWidget);
    expect(find.textContaining('Characters'), findsOneWidget);
    expect(find.textContaining('Quiz'), findsOneWidget);
    expect(find.byType(TextButton), findsNWidgets(2));
    await tester.tap(find.widgetWithText(TextButton, 'Characters'));
    await tester.pump();
    expect(find.byType(InfoPage), findsOneWidget);

    await tester.pump();
    expect(find.byType(CharactersPage), findsOneWidget);
    await tester.tap(find.widgetWithText(TextButton, 'Philip Jay Fry.'));

    await tester.pump();
    //warning doesn't get to BiographyPage
    // expect(find.byType(BiographyPage), findsOneWidget);
    // expect(find.textContaining('Human Male'), findsOneWidget);
    expect(find.textContaining('Philip Jay Fry.'), findsOneWidget);
  });

  testWidgets('Navigate from Info to Quiz Page', (WidgetTester tester) async {
    await tester.pumpWidget(app);
    await tester.pump();
    expect(find.textContaining('Philip J. Fry is...'), findsOneWidget);
    expect(find.textContaining('Characters'), findsOneWidget);
    expect(find.textContaining('Quiz'), findsOneWidget);

    expect(find.byType(TextButton), findsNWidgets(2));
    await tester.tap(find.widgetWithText(TextButton, 'Quiz'));
    await tester.pump();
    expect(find.byType(InfoPage), findsOneWidget);

    await tester.pump();
    expect(find.byType(QuizPage), findsOneWidget);
  });

  testWidgets('Info => Quiz => Answer Correctly.', (WidgetTester tester) async {
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
    await tester.pumpAndSettle();

    expect(find.textContaining('Philip J. Fry is...'), findsOneWidget);
    expect(find.textContaining('Characters'), findsOneWidget);
    expect(find.textContaining('Quiz'), findsOneWidget);

    expect(find.byType(TextButton), findsNWidgets(2));
    await tester.tap(find.widgetWithText(TextButton, 'Quiz'));
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
