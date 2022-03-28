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
    const width = 0.73;

    return Cage(
      child: Stack(
        children: [
          Container(),
          ScreenAdjust(
            portrait: const Offset(1, 2.2),
            landscape: const Offset(1, 2),
            width: isPortrait(context) ? width : 0.9,
            child: Text(
              question.question,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          ScreenAdjust(
            portrait: const Offset(1, 4),
            landscape: const Offset(8, 0),
            width: width,
            child: Column(
              mainAxisAlignment: isPortrait(context)
                  ? MainAxisAlignment.start
                  : MainAxisAlignment.center,
              children: <Widget>[
                for (int i = 0; i < question.possibleAnswers.length; ++i)
                  SizedBox(
                    height: screenAdjust(0.12, context),
                    child: ListTile(
                      dense: true,
                      contentPadding:
                          const EdgeInsets.only(left: 0.0, right: 0.0),
                      title: Text(
                        question.possibleAnswers[i],
                        style: TextStyle(
                          fontSize: screenAdjust(0.032, context),
                        ),
                      ),
                      leading:
                          isPortrait(context) ? _buildRadio(i, context) : null,
                      trailing:
                          isPortrait(context) ? null : _buildRadio(i, context),
                    ),
                  ),
              ],
            ),
          ),
          const ScreenAdjust(
            portrait: Offset(1, 10),
            landscape: Offset(1, 4),
            width: width,
            // TODO Animate Score
            child: _Score(),
          ),
          const CancelButton(),
        ],
      ),
    );
  }

  Radio<Answer> _buildRadio(int i, BuildContext context) {
    final quizNotifier = getQuizNotifier(context, listen: false);

    final fetchNotifier = getFetchNotifier(context, listen: false);
    final questions = fetchNotifier.questions;

    return Radio<Answer>(
      value: Answer.values[i],
      groupValue: null,
      onChanged: (Answer? value) {
        quizNotifier.setAnswer(value!.index, questions, context);
      },
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
        const ScreenAdjust(
          portrait: Offset(3, 3),
          landscape: Offset(4.5, 2),
          child: Text('Great!'),
        ),
        const ScreenAdjust(
          portrait: Offset(3, 6),
          landscape: Offset(8, 3),
          // TODO Animate Score
          child: _Score(),
        ),
        ScreenAdjust(
          portrait: const Offset(3, 9.5),
          landscape: const Offset(11.5, 5),
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

/// 3 Correct! out of 28.
class _Score extends StatelessWidget {
  const _Score({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final fetchNotifier = getFetchNotifier(context, listen: false);

    final quizNotifier = getQuizNotifier(context, listen: true);
    final score = quizNotifier.score;

    var scoreMessage = '$score correct';
    if (score > 0) {
      scoreMessage += '!';
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(scoreMessage, style: const TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: screenAdjust(0.05, context)),
        Text('(out of ${fetchNotifier.questions.length}).'),
      ],
    );
  }
}
