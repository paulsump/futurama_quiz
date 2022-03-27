// © 2022, Paul Sumpner <sumpner@hotmail.com>

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:futurama_quiz/main.dart';
import 'package:http/testing.dart';
import 'package:http/http.dart' as http;

void main() {
  testWidgets('Info page', (WidgetTester tester) async {
    await tester.pumpWidget(createApp(client: MockClient((_) async =>
        http.Response(
            '[{"synopsis":"Philip J. Fry is a 25 year old delivery boy living in New York......tax deductions.","yearsAired":"1999–2013","creators":[{"name":"David X. Cohen","url":"http://www.imdb.com/name/nm0169326"},{"name":"Matt Groening","url":"http://www.imdb.com/name/nm0004981"}],"id":1}]',
            200,
            headers: {
              HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'
            })));

        // Verify that our counter starts at 0.
        expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    // Tap the '+' icon and trigger a frame.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // Verify that our counter has incremented.
    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);
  });
}
