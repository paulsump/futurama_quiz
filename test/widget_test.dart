// © 2022, Paul Sumpner <sumpner@hotmail.com>

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:futurama_quiz/main.dart';
import 'package:futurama_quiz/out.dart';
import 'package:futurama_quiz/view/cage.dart';
import 'package:http/testing.dart';
import 'package:http/http.dart' as http;

const noWarn = out;

void main() {
  String fixture(String name) => File('test_data/$name').readAsStringSync();

  testWidgets('Info page', (WidgetTester tester) async {
    await tester.pumpWidget(createApp(client: MockClient((url) async {
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
    })));

    expect(find.byType(Cage), findsOneWidget);
    expect(find.byType(ListView), findsOneWidget);
    // expect(find.byType(AssetImage), findsOneWidget);
    // expect(find.byType(_InfoView), findsOneWidget);
    expect(find.byType(Text), findsOneWidget);
    expect(find.text('Please connect to the internet.'), findsOneWidget);

    expect(find.text('1'), findsNothing);

    // await tester.tap(find.byIcon(Icons.add));
    // before rebuild
    expect(find.textContaining('Philip J. Fry is...'), findsNothing);
    await tester.pump();
    //after rebuild!
    expect(find.textContaining('Philip J. Fry is...'), findsOneWidget);
    // expect(find.byType(TextButton), findsOneWidget);
  });
}
