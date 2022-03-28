import 'package:flutter/material.dart';
import 'package:futurama_quiz/fetch_notifier.dart';
import 'package:futurama_quiz/out.dart';
import 'package:futurama_quiz/quiz_notifier.dart';
import 'package:futurama_quiz/view/cage.dart';
import 'package:futurama_quiz/view/cancel_button.dart';
import 'package:futurama_quiz/view/screen_adjust.dart';

const noWarn = out;

/// Display one question, current score etc.
class QuizPage extends StatelessWidget {
  const QuizPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final quizNotifier = getQuizNotifier(context, listen: true);

    final fetchNotifier = getFetchNotifier(context, listen: true);
    final questions = fetchNotifier.questions;

    final question = questions[quizNotifier.currentQuestionIndex];
    final score = quizNotifier.score;

    return Cage(
      child: Stack(
        children: [
          Container(),
          ScreenAdjust(
            portrait: const Offset(1, 2.2),
            landscape: const Offset(1, 2),
            width: isPortrait(context) ? 0.73 : 0.9,
            child: Text(
              question.question,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          ScreenAdjust(
            portrait: const Offset(0.7, 4),
            landscape: const Offset(8, 0),
            width: 0.85,
            child: Column(
              mainAxisAlignment: isPortrait(context)
                  ? MainAxisAlignment.start
                  : MainAxisAlignment.center,
              children: <Widget>[
                for (int i = 0; i < question.possibleAnswers.length; ++i)
                  SizedBox(
                    height: screenAdjust(0.12, context),
                    child: ListTile(
                      title: Text(
                        question.possibleAnswers[i],
                        style: TextStyle(
                          fontSize: screenAdjust(0.032, context),
                        ),
                      ),
                      trailing: Radio<Answer>(
                        value: Answer.values[i],
                        groupValue: null,
                        onChanged: (Answer? value) {
                          quizNotifier.setAnswer(
                              value!.index, questions, context);
                        },
                      ),
                    ),
                  ),
              ],
            ),
          ),
          const ScreenAdjust(
              portrait: Offset(1, 10),
              landscape: Offset(1, 4),
              width: 0.75,
              child: _Score()),
          const CancelButton(),
        ],
      ),
    );
  }
}

enum Answer { one, two, three, four, five, six, seven, eight, nine, ten }

/// Display score and restart button
class ResultsPage extends StatelessWidget {
  const ResultsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final quizNotifier = getQuizNotifier(context, listen: false);


    return Cage(
        child: Stack(
      children: [
        const CancelButton(),
        //TODO Animate this hero onto ResultsView
        ScreenAdjust(
          portrait: const Offset(3, 3),
          landscape: const Offset(8, 2),
          child: Column(
            children: [
              const Text('Great!'),
              SizedBox(height: screenAdjust(0.1, context)),
              const _Score(),
            ],
          ),
        ),
        ScreenAdjust(
          portrait: const Offset(3, 6),
          landscape: const Offset(8, 5),
          child: TextButton(
            child: const Text('Restart Quiz'),
            style: TextButton.styleFrom(padding: EdgeInsets.zero),
            onPressed: () {
              quizNotifier.restart();
              Navigator.of(context).pushReplacementNamed('Quiz');
            },
          ),
        ),
        Container(),
      ],
    ));
  }
}

class _Score extends StatelessWidget {
  const _Score({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final fetchNotifier = getFetchNotifier(context, listen: false);

    final quizNotifier = getQuizNotifier(context, listen: false);
    final score = quizNotifier.score;

    return Text('$score correct\n\nout of ${fetchNotifier.questions.length}.');
  }
}
