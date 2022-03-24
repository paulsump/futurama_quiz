// © 2022, Paul Sumpner <sumpner@hotmail.com>

import 'package:flutter/material.dart';
import 'package:futurama_quiz/data/character.dart';
import 'package:futurama_quiz/data/fetcher.dart';
import 'package:futurama_quiz/data/info.dart';
import 'package:futurama_quiz/data/question.dart';
import 'package:futurama_quiz/view/question_view.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final client = http.Client();

  late Future<Info> info;
  late Future<List<Character>> characters;

  late Future<List<Question>> questions;

  @override
  void initState() {
    final fetcher = Fetcher(client);

    info = fetchInfo(fetcher);
    characters = fetchCharacters(fetcher);

    questions = fetchQuestions(fetcher);
    super.initState();
  }

  @override
  void dispose() {
    client.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Futurama'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // InfoView(info: info),
            // CharacterListView(characters: characters),
            FutureBuilder<List<Question>>(
              future: questions,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return QuestionView(question: snapshot.data![0]);
                } else if (snapshot.hasError) {
                  return Text('${snapshot.error}');
                }

                return const CircularProgressIndicator();
              },
            ),
          ],
        ),
      ),
    );
  }
}
