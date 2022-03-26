import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:futurama_quiz/api/character.dart';
import 'package:futurama_quiz/api/info.dart';
import 'package:futurama_quiz/api/question.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

ApiNotifier getApiNotifier(BuildContext context, {required bool listen}) =>
    Provider.of<ApiNotifier>(context, listen: listen);

/// Fetches everything that's used from the api (with http)
/// After fetching the info and notifying,
/// the characters are fetched and an image [Precacher] preloads the
/// character thumbnails.  Then the
/// questions are fetched.
/// The buttons to get to the characters and quiz pages only appear
/// when the characters and/or quiz have been fetched.
/// The HttpClient is closed when everything has been fetched.
/// This is all done in the initialize() function.
class ApiNotifier extends ChangeNotifier {
  bool initializeHasBeenCalled = false;

  late Info info;
  bool haveInfo = false;

  late List<Character> characters;
  bool haveCharacters = false;

  late List<Question> questions;
  bool haveQuestions = false;

  /// The main starting point for the app data.
  /// Called only once.
  Future<void> initialize(BuildContext context) async {
    initializeHasBeenCalled = true;

    final client = http.Client();

    final fetcher = _Fetcher(client);
    final infoList = await fetcher.getList('info');

    assert(infoList.length == 1);
    info = Info.fromJson(infoList[0]);

    haveInfo = true;
    notifyListeners();

    final characterList = await fetcher.getList('characters');
    characters = characterList
        .map((character) => Character.fromJson(character))
        .toList();

    haveCharacters = true;
    notifyListeners();

    final questionsList = await fetcher.getList('questions');
    questions =
        questionsList.map((character) => Question.fromJson(character)).toList();

    haveQuestions = true;
    notifyListeners();

    client.close();
  }
}

/// Helper class to fetch and convert json
/// In this api, json lists are returned, so
/// Lists of Map can be got from getList
class _Fetcher {
  final http.Client client;

  _Fetcher(this.client);

  /// url = the last bit of the endpoint
  /// i.e. 'info', 'questions' or 'characters'
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
