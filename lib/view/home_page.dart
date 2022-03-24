// © 2022, Paul Sumpner <sumpner@hotmail.com>

import 'package:flutter/material.dart';
import 'package:futurama_quiz/data/question.dart';
import 'package:futurama_quiz/view/character_list_view.dart';
import 'package:futurama_quiz/view/info_view.dart';
import 'package:futurama_quiz/view/question_view.dart';

const noWarn = [InfoView, Question, CharacterListView, QuestionView];

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Futurama')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const <Widget>[
            // InfoView(),
            // CharacterListView(),
            QuestionView(),
          ],
        ),
      ),
    );
  }
}
