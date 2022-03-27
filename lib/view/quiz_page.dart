import 'package:flutter/material.dart';
import 'package:futurama_quiz/fetch_notifier.dart';
import 'package:futurama_quiz/out.dart';
import 'package:futurama_quiz/quiz_notifier.dart';
import 'package:futurama_quiz/view/cage.dart';
import 'package:futurama_quiz/view/cancel_button.dart';
import 'package:futurama_quiz/view/screen_adjust.dart';

const noWarn = out;

/// Display one question, current score etc.
class QuizPage extends StatefulWidget {
  const QuizPage({Key? key}) : super(key: key);

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  _Answer? _answer;

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
            x: isPortrait(context) ? 2.5 : 3.0,
            y: isPortrait(context) ? 1 : 1,
            child: Text(
                'Question ${question.id} of ${fetchNotifier.questions.length}:'),
          ),
          ScreenAdjust(
            x: isPortrait(context) ? 1 : 1,
            y: isPortrait(context) ? 2.2 : 2,
            child: SizedBox(
                width: screenAdjust(isPortrait(context) ? 0.73 : 0.9, context),
                child: Text(
                  question.question,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                )),
          ),
          ScreenAdjust(
            x: isPortrait(context) ? 0.5 : 8,
            y: isPortrait(context) ? 4 : -0.0,
            child: SizedBox(
              width: screenAdjust(0.9, context),
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
                          style:
                              TextStyle(fontSize: screenAdjust(0.032, context)),
                        ),
                        leading: Radio<_Answer>(
                            value: _Answer.values[i],
                            groupValue: _answer,
                            onChanged: (_Answer? value) {
                              _answer = value!;
                              setState(() {});
                            }),
                      ),
                    ),
                  ScreenAdjust(
                    x: isPortrait(context) ? 1 : 0,
                    y: 0.5,
                    child: TextButton(
                      child: const Text('Final Answer'),
                      onPressed: _answer == null
                          ? null
                          : () {
                              quizNotifier.updateScoreMessage(
                                  _answer!.index, question);

                              _answer = null;
                              quizNotifier.currentQuestionIndex += 1;

                              if (quizNotifier.currentQuestionIndex ==
                                  questions.length) {
                                quizNotifier.currentQuestionIndex = 0;

                                Navigator.of(context)
                                    .pushReplacementNamed('Results');
                              } else {
                                setState(() {});
                              }
                            },
                    ),
                  ),
                ],
              ),
            ),
          ),
          ScreenAdjust(
            x: isPortrait(context) ? 1 : 1,
            y: isPortrait(context) ? 11 : 4,
            child: SizedBox(
              width: screenAdjust(0.75, context),
              child: Text(
                  '${quizNotifier.message}\n\n${score.correct} right, ${score.incorrect} wrong.'),
            ),
          ),
          const CancelButton(),
        ],
      ),
    );
  }
}

enum _Answer { one, two, three, four, five, six, seven, eight, nine, ten }

/// Display score and restart button
class ResultsPage extends StatelessWidget {
  const ResultsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final quizNotifier = getQuizNotifier(context, listen: false);

    final score = quizNotifier.score;

    return Cage(
        child: Stack(
      children: [
        const CancelButton(),
        //TODO Animate this hero onto ResultsView
        ScreenAdjust(
          x: isPortrait(context) ? 3 : 8,
          y: isPortrait(context) ? 3 : 2.5,
          child: Text(
              'Great!\n\n\n${score.correct} right,\n\n${score.incorrect} wrong.'),
        ),
        ScreenAdjust(
          x: isPortrait(context) ? 3 : 7.5,
          y: isPortrait(context) ? 6 : 4,
          child: TextButton(
            child: const Text('Restart Quiz'),
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
