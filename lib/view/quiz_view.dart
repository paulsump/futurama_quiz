import 'package:flutter/material.dart';
import 'package:futurama_quiz/api/api_notifier.dart';
import 'package:futurama_quiz/state/quiz_notifier.dart';
import 'package:futurama_quiz/view/big_back_button.dart';
import 'package:futurama_quiz/view/cage.dart';
import 'package:futurama_quiz/view/screen_adjust.dart';

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

enum Answer { one, two, three, four, five, six, seven, eight, nine, ten }

var _answer = Answer.one;

class QuestionView extends StatefulWidget {
  const QuestionView({Key? key}) : super(key: key);

  @override
  State<QuestionView> createState() => _QuestionViewState();
}

class _QuestionViewState extends State<QuestionView> {
  @override
  Widget build(BuildContext context) {
    final quizNotifier = getQuizNotifier(context, listen: false);
    final apiNotifier = getApiNotifier(context, listen: true);

    quizNotifier.setCurrentQuestion(apiNotifier.questions[0]);
    final question = quizNotifier.currentQuestion!;

    return apiNotifier.haveQuestions
        ? Column(
            children: [
              Padding(
                padding: EdgeInsets.all(screenAdjust(0.13, context)),
                child: const _QuestionNumber(),
              ),
              Text(question.question),
              Padding(
                padding: EdgeInsets.all(screenAdjust(0.13, context)),
                child: Column(
                  children: <Widget>[
                    for (int i = 0; i < question.possibleAnswers.length; ++i)
                      ListTile(
                        title: Text(question.possibleAnswers[i]),
                        leading: Radio<Answer>(
                            value: Answer.values[i],
                            groupValue: _answer,
                            onChanged: (Answer? value) {
                              _answer = value!;
                              setState(() {});
                            }),
                      )
                  ],
                ),
              ),
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
