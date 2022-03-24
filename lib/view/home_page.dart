// © 2022, Paul Sumpner <sumpner@hotmail.com>

import 'package:flutter/material.dart';
import 'package:futurama_quiz/data/data_notifier.dart';
import 'package:futurama_quiz/data/question.dart';
import 'package:futurama_quiz/view/question_view.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final dataNotifier = getDataNotifier(context, listen: true);

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
              future: dataNotifier.questions,
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
