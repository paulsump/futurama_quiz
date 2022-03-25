import 'package:flutter/material.dart';
import 'package:futurama_quiz/data/data_notifier.dart';
import 'package:futurama_quiz/view/cage.dart';

class QuizView extends StatelessWidget {
  const QuizView({Key? key}) : super(key: key);

  //TODO MANage QuestionView etc
  @override
  Widget build(BuildContext context) {
    return Cage(
        child: Column(
      children: [
        const QuestionView(),
        TextButton(
          child: const Text('Ok'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    ));
  }
}

class QuestionView extends StatelessWidget {
  const QuestionView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dataNotifier = getDataNotifier(context, listen: true);

    dataNotifier.setCurrentQuestion(dataNotifier.questions[0]);
    final question = dataNotifier.currentQuestion!;

    return dataNotifier.haveQuestions
        ? Column(
            children: [
              Text(question.id.toString()),
              Text(question.question),
              for (final answer in question.possibleAnswers) Text(answer),
              Text(question.correctAnswer),
            ],
          )
        : Container();
  }
}
