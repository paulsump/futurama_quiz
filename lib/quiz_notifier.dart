import 'package:flutter/material.dart';
import 'package:futurama_quiz/out.dart';
import 'package:provider/provider.dart';

import 'fetch_notifier.dart';

const noWarn = [out, Question];

QuizNotifier getQuizNotifier(BuildContext context, {required bool listen}) =>
    Provider.of<QuizNotifier>(context, listen: listen);

/// For the current state of the quiz e.g. current question, score
class QuizNotifier extends ChangeNotifier {
  int currentQuestionIndex = 0;

  var score = Score();
  var message = '';

  void restart() {
    score.reset();

    currentQuestionIndex = 0;
    notifyListeners();
  }

  void setAnswer(
      int answerIndex, List<Question> questions, BuildContext context) {
    _updateScoreMessage(answerIndex, questions);

    currentQuestionIndex += 1;

    if (currentQuestionIndex == questions.length) {
      currentQuestionIndex = 0;

      Navigator.of(context).pushReplacementNamed('Results');
    }
    notifyListeners();
  }

  void _updateScoreMessage(int answerIndex, List<Question> questions) {
    final question = questions[currentQuestionIndex];

    if (question.correctAnswer == question.possibleAnswers[answerIndex]) {
      score.correct += 1;

      message = 'Correct!';
    } else {
      score.incorrect += 1;

      message = 'Sorry, the correct answer was\n"${question.correctAnswer}".';
    }
  }
}

class Score {
  int correct = 0;
  int incorrect = 0;

  void reset() {
    correct = 0;
    incorrect = 0;
  }
}
