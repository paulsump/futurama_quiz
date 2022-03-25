import 'package:flutter/material.dart';
import 'package:futurama_quiz/data/character.dart';
import 'package:futurama_quiz/data/fetcher.dart';
import 'package:futurama_quiz/data/info.dart';
import 'package:futurama_quiz/data/question.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

DataNotifier getDataNotifier(BuildContext context, {required bool listen}) =>
    Provider.of<DataNotifier>(context, listen: listen);

class DataNotifier extends ChangeNotifier {
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
