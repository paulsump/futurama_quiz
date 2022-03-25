import 'package:flutter/material.dart';
import 'package:futurama_quiz/data/data_notifier.dart';
import 'package:futurama_quiz/state/quiz_notifier.dart';
import 'package:futurama_quiz/view/big_back_button.dart';
import 'package:futurama_quiz/view/cage.dart';

class QuizView extends StatelessWidget {
  const QuizView({Key? key}) : super(key: key);

  //TODO MANage QuestionView etc
  @override
  Widget build(BuildContext context) {
    return Cage(
        child: Stack(
      children: const [
        QuestionView(),
        BigBackButton(),
      ],
    ));
  }
}

class QuestionView extends StatelessWidget {
  const QuestionView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final quizNotifier = getStateNotifier(context, listen: false);
    final dataNotifier = getDataNotifier(context, listen: true);

    quizNotifier.setCurrentQuestion(dataNotifier.questions[0]);
    final question = quizNotifier.currentQuestion!;

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

// can simple logic go here?
class Score {
  int correct = 0;
  int incorrect = 0;
}

//TODO DIsplay this at the top right? on a stack?
class _Score extends StatelessWidget {
  const _Score({Key? key}) : super(key: key);

  String getQuestionNumberString(BuildContext context) {
    final quizNotifier = getStateNotifier(context, listen: false);

    final dataNotifier = getDataNotifier(context, listen: true);
    return '${quizNotifier.currentQuestion!.id} / ${dataNotifier.questions.length}';
  }

  @override
  Widget build(BuildContext context) {
    final dataNotifier = getDataNotifier(context, listen: true);
    return Text('');
  }
}
