import 'package:flutter/material.dart';
import 'package:futurama_quiz/api/character.dart';
import 'package:futurama_quiz/api/fetcher.dart';
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

    final fetcher = Fetcher(client);
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
