import 'package:flutter/material.dart';
import 'package:futurama_quiz/api/api_notifier.dart';
import 'package:futurama_quiz/state/quiz_notifier.dart';
import 'package:futurama_quiz/view/big_back_button.dart';
import 'package:futurama_quiz/view/cage.dart';
import 'package:futurama_quiz/view/screen_adjust.dart';

//TODO MANages QuestionView etc
class QuizPage extends StatelessWidget {
  const QuizPage({Key? key}) : super(key: key);

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
    final quizNotifier = getQuizNotifier(context, listen: false);

    final apiNotifier = getApiNotifier(context, listen: true);
    final questions = apiNotifier.questions;

    final question = questions[quizNotifier.currentQuestionIndex];
    final score = quizNotifier.score;

    return Stack(
      children: [
        Adjusted(
          1,
          1,
          Text('${question.id} / ${apiNotifier.questions.length}'),
        ),
        Adjusted(
          1,
          2,
          SizedBox(
              width: screenAdjust(isPortrait(context) ? 0.73 : 2.3, context),
              child: Text(question.question)),
        ),
        Adjusted(
          1,
          3,
          Column(
            children: <Widget>[
              for (int i = 0; i < question.possibleAnswers.length; ++i)
                ListTile(
                  title: Text(question.possibleAnswers[i]),
                  leading: Radio<_Answer>(
                      value: _Answer.values[i],
                      groupValue: _answer,
                      onChanged: (_Answer? value) {
                        _answer = value!;
                        setState(() {});
                      }),
                ),
              if (_answer != null)
                Adjusted(
                  -2,
                  1,
                  TextButton(
                    child: const Text('Final Answer'),
                    onPressed: () {
                      quizNotifier.submitFinalAnswer(_answer!.index, question);
                      _answer = null;
                      quizNotifier.currentQuestionIndex += 1;
                      // if (quizNotifier.currentQuestionIndex == questions.length) {
                      Navigator.of(context).pushNamed('Results');
                      // }
                      setState(() {});
                    },
                  ),
                ),
            ],
          ),
        ),
        Adjusted(
          5,
          1,
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
        const BigBackButton(),
        //TODO Animate this hero onto ResultsView
        Adjusted(
          3,
          3,
          Text('${score.correct} right,\n${score.incorrect} wrong.'),
        ),
        Adjusted(
          3,
          6,
          TextButton(
            child: const Text('Restart Quiz'),
            onPressed: () {
              quizNotifier.restart();
              Navigator.of(context).pop();
            },
          ),
        ),
        Container(),
      ],
    ));
  }
}
