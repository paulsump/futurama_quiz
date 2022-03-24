import 'package:flutter/material.dart';
import 'package:futurama_quiz/data/data_notifier.dart';

class QuestionView extends StatelessWidget {
  const QuestionView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dataNotifier = getDataNotifier(context, listen: true);

    return dataNotifier.haveQuestions
        ? Text(dataNotifier.questions[0].question)
        : Container();
  }
}
