import 'package:flutter/material.dart';
import 'package:futurama_quiz/api/api_notifier.dart';
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
    final quizNotifier = getQuizNotifier(context, listen: false);
    final apiNotifier = getApiNotifier(context, listen: true);

    quizNotifier.setCurrentQuestion(apiNotifier.questions[0]);
    final question = quizNotifier.currentQuestion!;

    return apiNotifier.haveQuestions
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

//TODO DIsplay this at the top
class _QuestionNumber extends StatelessWidget {
  const _QuestionNumber({Key? key}) : super(key: key);

  String getQuestionNumberString(BuildContext context) {
    final quizNotifier = getQuizNotifier(context, listen: false);

    final apiNotifier = getApiNotifier(context, listen: true);
    return '${quizNotifier.currentQuestion!.id} / ${apiNotifier.questions.length}';
  }

  @override
  Widget build(BuildContext context) {
    return Text(getQuestionNumberString(context));
  }
}

//TODO DIsplay this at the top right
class _Score extends StatelessWidget {
  const _Score({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final quizNotifier = getQuizNotifier(context, listen: true);

    final score = quizNotifier.score;
    return Text('${score.correct} right, ${score.incorrect} wrong}');
  }
}
