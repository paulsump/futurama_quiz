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
  Answer? _answer;

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
                        leading: Radio<Answer>(
                            value: Answer.values[i],
                            groupValue: _answer,
                            onChanged: (Answer? value) {
                              quizNotifier.setAnswer(
                                  value!.index, questions, context);
                            }),
                      ),
                    ),
                ],
              ),
            ),
          ),
          ScreenAdjust(
            x: isPortrait(context) ? 1 : 1,
            y: isPortrait(context) ? 10 : 4,
            child: SizedBox(
              width: screenAdjust(0.75, context),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(quizNotifier.message),
                  SizedBox(height: screenAdjust(0.03, context)),
                  Text('${score.correct} right, ${score.incorrect} wrong.'),
                ],
              ),
            ),
          ),
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
