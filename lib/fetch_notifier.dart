import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:futurama_quiz/character.dart';
import 'package:futurama_quiz/out.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

/// Convenience function to get the [FetchNotifier] '[Provider]'.
FetchNotifier getFetchNotifier(BuildContext context, {required bool listen}) =>
    Provider.of<FetchNotifier>(context, listen: listen);

/// Fetches everything that's used from the api (with http)
/// After fetching the info and notifying,
/// the characters are fetched and an image [Precacher] preloads the
/// character thumbnails.  Then the
/// questions are fetched.
/// The buttons to get to the characters and quiz pages only become enabled
/// when the characters and/or quiz have been fetched.
/// The [HttpClient] is closed when everything has been fetched.
/// This is all done in the [fetchAll]() function.
class FetchNotifier extends ChangeNotifier {
  bool fetchAllHasBeenCalled = false;

  late Info info;
  bool haveInfo = false;

  final characters = <Character>[];
  bool haveCharacters = false;

  final questions = <Question>[];
  bool haveQuestions = false;

  String infoErrorMessage = 'Fetching Futurama info...';

  String charactersErrorMessage = '';
  String questionsErrorMessage = '';

  /// The main starting point for the app data.
  /// Called only once.
  Future<void> fetchAll(BuildContext context, http.Client client) async {
    fetchAllHasBeenCalled = true;

    final fetcher = Fetcher(client);
    try {
      final infoList = await fetcher.getInfo();

      assert(infoList.length == 1);
      info = Info.fromJson(infoList[0]);

      haveInfo = true;
    } catch (error) {
      infoErrorMessage = _formatError(error);

      // Allow app to try again later.
      fetchAllHasBeenCalled = false;
    }

    notifyListeners();
    try {
      final characterList = await fetcher.getCharacters();

      for (final character in characterList) {
        try {
          characters.add(Character.fromJson(character));
        } catch (error) {
          logError('Ignoring bad character');
        }
      }
      haveCharacters = true;
    } catch (error) {
      charactersErrorMessage = _formatError(error);

      // Allow app to try again later.
      fetchAllHasBeenCalled = false;
    }

    notifyListeners();

    try {
      final questionsList = await fetcher.getQuestions();

      for (final question in questionsList) {
        try {
          questions.add(Question.fromJson(question));
        } catch (error) {
          logError('Ignoring bad question');
        }
      }
      haveQuestions = true;
    } catch (error) {
      questionsErrorMessage = _formatError(error);

      // Allow app to try again later.
      fetchAllHasBeenCalled = false;
    }

    notifyListeners();
    client.close();
  }

  String _formatError(Object error) {
    var message = error.toString();

    if (message.startsWith('Exception: ')) {
      message = message.replaceFirst('Exception: ', '');
    }

    out(message);
    return message;
  }
}

/// Helper class to fetch and convert json
/// In this API, JSON lists are returned, so
/// [List]s of [Map] can be got from [getList]
/// It's only public for the tests,
/// including [getInfo](), [getCharacters]() and [getQuestions]()
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
      final n = response.statusCode;
      var message = 'Failed to fetch $url from the API.\n($n';

      if (_friendlyHttpStatus.containsKey(n)) {
        message += ' -  ${_friendlyHttpStatus[n]!}.)';
      } else {
        message += ')';
        logError('Unknown http status code $n');
      }
      throw Exception(message);
    }
  }
}

/// [Map] for converting HTTP status codes to user 'friendly' messages.
const _friendlyHttpStatus = {
  200: 'OK',
  201: 'Created',
  202: 'Accepted',
  203: 'Non-Authoritative Information',
  204: 'No Content',
  205: 'Reset Content',
  206: 'Partial Content',
  300: 'Multiple Choices',
  301: 'Moved Permanently',
  302: 'Found',
  303: 'See Other',
  304: 'Not Modified',
  305: 'Use Proxy',
  306: 'Unused',
  307: 'Temporary Redirect',
  400: 'Bad Request',
  401: 'Unauthorized',
  402: 'Payment Required',
  403: 'Forbidden',
  404: 'Not Found',
  405: 'Method Not Allowed',
  406: 'Not Acceptable',
  407: 'Proxy Authentication Required',
  408: 'Request Timeout',
  409: 'Conflict',
  410: 'Gone',
  411: 'Length Required',
  412: 'Precondition Required',
  413: 'Request Entry Too Large',
  414: 'Request-URI Too Long',
  415: 'Unsupported Media Type',
  416: 'Requested Range Not Satisfiable',
  417: 'Expectation Failed',
  418: 'I\'m a teapot',
  429: 'Too Many Requests',
  500: 'Internal Server Error',
  501: 'Not Implemented',
  502: 'Bad Gateway',
  503: 'Service Unavailable',
  504: 'Gateway Timeout',
  505: 'HTTP Version Not Supported',
};

/// General Futurama information for the homepage.
/// Adapted from the API.
class Info {
  Info.fromJson(Map<String, dynamic> json)
      : yearsAired = json['yearsAired'],
        _creators = json['creators']
            .map<_Creator>(
                (creator) => _Creator(creator['name'], creator['url']))
            .toList(),
        id = json['id'] {
    // Break the long text into paragraphs.
    // This code may seem over specific, but it won't break anything if
    // the app changes, so it's worth it.
    synopsis = json['synopsis'];
    synopsis = synopsis.replaceFirst('2999. T', '2999.\n\nT');
    synopsis = synopsis.replaceFirst('things. E', 'things.\n\nE');
    synopsis = synopsis.replaceFirst('forgetful. F', 'forgetful.\n\nF');
    synopsis = synopsis.replaceFirst('hip. A', 'hip.\n\nA');
    synopsis = synopsis.replaceFirst('look. A', 'look.\n\nA');
    synopsis = synopsis.replaceFirst('humans. F', 'humans.\n\nF');
  }

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

/// The actual inventors/authors/creators of Futurama
/// for [Info]
/// Adapted from the API...
/// I ignore the url because I don't wish people to
/// leave my app and get side tracked on the web!
/// Also, because it goes to a boring website
/// which tells you less than google would.
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
