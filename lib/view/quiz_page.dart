import 'package:flutter/material.dart';
import 'package:futurama_quiz/fetch_notifier.dart';
import 'package:futurama_quiz/quiz_notifier.dart';
import 'package:futurama_quiz/view/background.dart';
import 'package:futurama_quiz/view/cancel_button.dart';
import 'package:futurama_quiz/view/screen_adjust.dart';
import 'package:futurama_quiz/view/screen_adjusted_text.dart';

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

    return Background(
      child: Stack(
        children: [
          Container(),
          ScreenAdjust(
            portrait: const Offset(1.8, 0.7),
            landscape: const Offset(1.8, 0.7),
            width: isPortrait(context) ? width : 0.9,
            child: ScreenAdjustedText(
              question.question,
              bold: true,
            ),
          ),
          ScreenAdjust(
            portrait: const Offset(6.5, 13.0),
            landscape: const Offset(6.5, 7.5),
            width: isPortrait(context) ? 0.37 : width,
            anchorBottom: true,
            anchorRight: true,
            child: Column(
              mainAxisAlignment: isPortrait(context)
                  ? MainAxisAlignment.start
                  : MainAxisAlignment.center,
              children: <Widget>[
                for (int i = 0; i < question.possibleAnswers.length; ++i)
                  SizedBox(
                    height: screenAdjust(
                        question.possibleAnswers.length > 5 ? 0.11 : 0.12,
                        context),
                    child: ListTile(
                      dense: true,
                      contentPadding:
                          const EdgeInsets.only(left: 0.0, right: 0.0),
                      title: ScreenAdjustedText(
                        question.possibleAnswers[i],
                        size: 0.032,
                        bold: true,
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
            portrait: Offset(5, 5.5),
            landscape: Offset(4, 4.5),
            width: width,
            anchorBottom: true,
            child: _Score(),
          ),
          ScreenAdjust(
            portrait: const Offset(1, 5.5),
            landscape: const Offset(0.5, 4.3),
            width: isPortrait(context) ? 0.3 : 0.6,
            anchorBottom: true,
            child: const Image(image: AssetImage('images/hypnotoad.png')),
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

/// Public for tests only.
enum Answer { one, two, three, four, five, six, seven, eight, nine, ten }

/// Display score and restart button
class ResultsPage extends StatelessWidget {
  const ResultsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final quizNotifier = getQuizNotifier(context, listen: false);

    return Background(
        child: Stack(
      children: [
        ScreenAdjust(
          portrait: const Offset(0, 9.5),
          landscape: const Offset(1.0, 6.3),
          width: isPortrait(context) ? 0.28 : 0.4,
          anchorBottom: true,
          child: const Image(image: AssetImage('images/zapp.png')),
        ),
        const CancelButton(),
        const ScreenAdjust(
          portrait: Offset(3.2, 3),
          landscape: Offset(7, 2.4),
          child: _Score(),
        ),
        ScreenAdjust(
          portrait: const Offset(4.5, 6.0),
          landscape: const Offset(11, 4.3),
          child: TextButton(
            child: const ScreenAdjustedText(
              'Restart Quiz',
              bold: true,
            ),
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
        ScreenAdjustedText(scoreMessage, bold: true),
        SizedBox(height: screenAdjust(0.05, context)),
        ScreenAdjustedText('(out of ${fetchNotifier.questions.length}).'),
      ],
    );
  }
}
