// © 2022, Paul Sumpner <sumpner@hotmail.com>

import 'package:flutter/material.dart';
import 'package:futurama_quiz/data/question.dart';
import 'package:futurama_quiz/view/cage.dart';
import 'package:futurama_quiz/view/character_list_view.dart';
import 'package:futurama_quiz/view/hue.dart';
import 'package:futurama_quiz/view/info_view.dart';
import 'package:futurama_quiz/view/question_view.dart';

const noWarn = [InfoView, Question, CharacterListView, QuestionView];

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Cage(
      child: Column(children: [
        // TODO maybe pic of Fry here 'cause info talks about him?
        // if so, this could be loaded from assets
        const InfoView(),
        TextButton(
          child: const Text(
            'Characters',
            style: TextStyle(color: Hue.text),
          ),
          onPressed: () {
            Navigator.of(context).pushNamed('Characters');
          },
        ),
        // CharacterListView(),
        // QuestionView(),
      ]),
    );
  }
}
