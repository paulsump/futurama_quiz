import 'package:flutter/material.dart';
import 'package:futurama_quiz/api/api_notifier.dart';
import 'package:futurama_quiz/out.dart';
import 'package:futurama_quiz/state/quiz_notifier.dart';
import 'package:futurama_quiz/view/cage.dart';
import 'package:futurama_quiz/view/cancel_button.dart';
import 'package:futurama_quiz/view/screen_adjust.dart';

const noWarn = out;

//TODO MANages QuestionView etc
class QuizPage extends StatelessWidget {
  const QuizPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Cage(
        child: Stack(
      children: const [
        QuestionView(),
        CancelButton(),
      ],
    ));
  }
}

enum _Answer { one, two, three, four, five, six, seven, eight, nine, ten }

class QuestionView extends StatefulWidget {
  const QuestionView({Key? key}) : super(key: key);

  @override
  State<QuestionView> createState() => _QuestionViewState();
}

class _QuestionViewState extends State<QuestionView> {
  _Answer? _answer;

  @override
  Widget build(BuildContext context) {
    final quizNotifier = getQuizNotifier(context, listen: true);

    final apiNotifier = getApiNotifier(context, listen: true);
    final questions = apiNotifier.questions;

    final question = questions[quizNotifier.currentQuestionIndex];
    final score = quizNotifier.score;

    return Stack(
      children: [
        Container(),
        Adjusted(
          isPortrait(context) ? 3 : 4.5,
          isPortrait(context) ? 2 : 1,
          Text('${question.id} / ${apiNotifier.questions.length}'),
        ),
        Adjusted(
          isPortrait(context) ? 1 : 2,
          isPortrait(context) ? 3 : 2,
          SizedBox(
              width: screenAdjust(isPortrait(context) ? 0.73 : 0.9, context),
              child: Text(question.question)),
        ),
        Adjusted(
          isPortrait(context) ? 1 : 9,
          isPortrait(context) ? 5 : 0.5,
          SizedBox(
            width: screenAdjust(0.8, context),
            child: Column(
              children: <Widget>[
                for (int i = 0; i < question.possibleAnswers.length; ++i)
                  SizedBox(
                    height: screenAdjust(0.1, context),
                    child: ListTile(
                      title: Text(
                        question.possibleAnswers[i],
                        style: TextStyle(fontSize: screenAdjust(0.03, context)),
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
                if (_answer != null)
                  Adjusted(
                    isPortrait(context) ? 1 : 0,
                    0.5,
                    TextButton(
                      child: const Text('Final Answer'),
                      onPressed: () {
                        quizNotifier.submitAnswer(
                            _answer!.index, question);

                        final snackBar = SnackBar(
                          content: const Text('Yay! A SnackBar!'),
                          action: SnackBarAction(
                            label: 'Undo',
                            onPressed: () {
                              // Some code to undo the change.
                            },
                          ),
                        );

                        // Find the ScaffoldMessenger in the widget tree
                        // and use it to show a SnackBar.
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);

                        _answer = null;
                        quizNotifier.currentQuestionIndex += 1;

                        if (quizNotifier.currentQuestionIndex ==
                            questions.length) {
                          quizNotifier.currentQuestionIndex = 0;
                          Navigator.of(context).pushReplacementNamed('Results');
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
        Adjusted(
          isPortrait(context) ? 5 : 1,
          isPortrait(context) ? 1 : 6,
          Text('${score.correct} right, ${score.incorrect} wrong.'),
        ),
      ],
    );
  }
}

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
        Adjusted(
          isPortrait(context) ? 3 : 8,
          isPortrait(context) ? 3 : 2.5,
          Text('${score.correct} right,\n${score.incorrect} wrong.'),
        ),
        Adjusted(
          isPortrait(context) ? 3 : 7.5,
          isPortrait(context) ? 6 : 4,
          TextButton(
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
