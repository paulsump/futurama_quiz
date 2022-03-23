// © 2022, Paul Sumpner <sumpner@hotmail.com>

import 'dart:convert';

import 'package:futurama_quiz/out.dart';
import 'package:http/http.dart' as http;

class Fetcher {
  final http.Client client;

  Fetcher(this.client);

  Future<Map<String, dynamic>> getMap(String url) async {
    final json = await _getJson(url);

    final list = jsonDecode(json);

    int count = 0;
    for (var j in list) {
      out(j);
      count += 1;
    }
    out(count);
    out(list.length);
    assert(list.length == 1);
    final map = list[0];
    out(map.keys.toList());
    return map;
  }

  Future<String> _getJson(String url) async {
    final response = await client.get(
      Uri.parse('https://api.sampleapis.com/futurama/$url'),
    );

    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Fetch failed. (${response.statusCode})($url)');
    }
  }
}
