import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:futurama_quiz/fetch_notifier.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:mockito/annotations.dart';

// Generate a MockClient using the Mockito package.
// Create new instances of this class in each test.
@GenerateMocks([http.Client])
void main() {
  group('fetcher.getInfo()', () {
    test('returns a List if the http call completes successfully', () async {
      final client = MockClient((_) async => http.Response(
              '[{"synopsis":"Philip J. Fry is a 25 year old delivery boy living in New York......tax deductions.","yearsAired":"1999–2013","creators":[{"name":"David X. Cohen","url":"http://www.imdb.com/name/nm0169326"},{"name":"Matt Groening","url":"http://www.imdb.com/name/nm0004981"}],"id":1}]',
              200,
              headers: {
                HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'
              }));

      final fetcher = Fetcher(client);
      final infoList = await fetcher.getInfo();

      assert(infoList.length == 1);
      expect(Info.fromJson(infoList[0]), isA<Info>());
    });

    test('throws an exception if the http call completes with an error', () {
      final client = MockClient((_) async => http.Response('Not Found', 404));

      final fetcher = Fetcher(client);
      expect(fetcher.getInfo(), throwsException);
    });
  });
}
