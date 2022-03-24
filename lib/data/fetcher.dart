// © 2022, Paul Sumpner <sumpner@hotmail.com>

import 'dart:convert';

import 'package:futurama_quiz/out.dart';
import 'package:http/http.dart' as http;

const noWarn = out;

class Fetcher {
  final http.Client client;

  Fetcher(this.client);

  Future<List<dynamic>> getList(String url) async {
    final json = await _getJson(url);

    return jsonDecode(json);
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
