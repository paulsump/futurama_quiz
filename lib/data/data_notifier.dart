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

  final client = http.Client();
  late Info info;

  late Future<List<Character>> characters;
  late Future<List<Question>> questions;

  bool infoReady = false;
  bool charactersReady = false;
  bool questionsReady = false;

  /// The main starting point for the app data.
  /// Called only once.
  Future<void> initialize(BuildContext context) async {
    initializeHasBeenCalled = true;

    final fetcher = Fetcher(client);
    final infoList = await fetcher.getList('info');

    assert(infoList.length == 1);
    info = Info.fromJson(infoList[0]);
    infoReady = true;
    notifyListeners();

    characters = fetchCharacters(fetcher);
    questions = fetchQuestions(fetcher);
  }

  void tryToCloseClient() {
    if (infoReady && charactersReady && questionsReady) {
      client.close();
    }
  }
}
