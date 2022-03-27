import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:futurama_quiz/character.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

FetchNotifier getFetchNotifier(BuildContext context, {required bool listen}) =>
    Provider.of<FetchNotifier>(context, listen: listen);

/// Fetches everything that's used from the api (with http)
/// After fetching the info and notifying,
/// the characters are fetched and an image [Precacher] preloads the
/// character thumbnails.  Then the
/// questions are fetched.
/// The buttons to get to the characters and quiz pages only appear
/// when the characters and/or quiz have been fetched.
/// The HttpClient is closed when everything has been fetched.
/// This is all done in the fetchAll() function.
class FetchNotifier extends ChangeNotifier {
  bool fetchAllHasBeenCalled = false;

  late Info info;
  bool haveInfo = false;

  late List<Character> characters;
  bool haveCharacters = false;

  late List<Question> questions;
  bool haveQuestions = false;

  /// The main starting point for the app data.
  /// Called only once.
  Future<void> fetchAll(BuildContext context, http.Client client) async {
    fetchAllHasBeenCalled = true;

    final fetcher = Fetcher(client);
    final infoList = await fetcher.getInfo();

    assert(infoList.length == 1);
    info = Info.fromJson(infoList[0]);

    haveInfo = true;
    notifyListeners();

    final characterList = await fetcher.getCharacters();
    characters = characterList
        .map((character) => Character.fromJson(character))
        .toList();

    haveCharacters = true;
    notifyListeners();

    final questionsList = await fetcher.getQuestions();
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
/// Public for tests only, including getCharacters() etc
class Fetcher {
  final http.Client client;

  Fetcher(this.client);

  Future<List<dynamic>> getInfo() async => _getList('info');

  Future<List<dynamic>> getCharacters() async => _getList('characters');

  Future<List<dynamic>> getQuestions() async => _getList('questions');

  /// url = the last bit of the endpoint
  /// i.e. 'info', 'questions' or 'characters'
  Future<List<dynamic>> _getList(String url) async {
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

/// General Futurama information for the homepage.
class Info {
  Info.fromJson(Map<String, dynamic> json)
      //TODO CHeck if containsKey()
      : _synopsis = json['synopsis'],
        yearsAired = json['yearsAired'],
        _creators = json['creators']
            .map<_Creator>(
                (creator) => _Creator(creator['name'], creator['url']))
            .toList(),
        id = json['id'] {
    // TODO PIC for each paragraph?
    // Probably not in case the api data changed.
    synopsis = _synopsis.replaceFirst('2999. ', '2999.\n\n');
    synopsis = synopsis.replaceFirst('things. ', 'things.\n\n');
    synopsis = synopsis.replaceFirst('things. ', 'things.\n\n');
    synopsis = synopsis.replaceFirst('forgetful. ', 'forgetful.\n\n');
    synopsis = synopsis.replaceFirst('hip. ', 'hip.\n\n');
    synopsis = synopsis.replaceFirst('look. ', 'look.\n\n');
    synopsis = synopsis.replaceFirst('humans. ', 'humans.\n\n');
  }

  final String _synopsis;
  late String synopsis;
  final String yearsAired;

  Iterable<String> get creatorNames sync* {
    for (final creator in _creators) {
      yield creator.name;
    }
  }

  final int id;

  final List<_Creator> _creators;
}

/// for [Info]
class _Creator {
  _Creator(this.name, this.url);

  final String name;
  final String url;
}

/// For the quiz, this has everything you need for a question
/// including question number (id), multiple choice
/// and the correct answer.
class Question {
  Question.fromJson(Map<String, dynamic> json)
      //TODO containsKey
      : id = json['id'],
        question = json['question'],
        possibleAnswers = json['possibleAnswers']
            .map<String>((answer) => answer.toString())
            .toList(),
        correctAnswer = json['correctAnswer'].toString();

  final int id;
  final String question;
  final List<String> possibleAnswers;
  final String correctAnswer;
}
