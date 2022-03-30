// © 2022, Paul Sumpner <sumpner@hotmail.com>

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'fetch_notifier.dart';

/// Convenience function to get the [QuizNotifier] '[Provider]'.
QuizNotifier getQuizNotifier(BuildContext context, {required bool listen}) =>
    Provider.of<QuizNotifier>(context, listen: listen);

/// For the current state of the quiz i.e. current question, score.
/// Also any logic is done here rather than in the ui code.
class QuizNotifier extends ChangeNotifier {
  int currentQuestionIndex = 0;

  int score = 0;

  void restart() {
    currentQuestionIndex = 0;

    score = 0;
    notifyListeners();
  }

  void setAnswer(int answerIndex,
      List<Question> questions,
      BuildContext context,) {
    _updateScore(answerIndex, questions);

    currentQuestionIndex += 1;

    if (currentQuestionIndex == questions.length) {
      currentQuestionIndex = 0;

      Navigator.of(context).pushReplacementNamed('Results');
    }
    notifyListeners();
  }

  void _updateScore(int answerIndex, List<Question> questions) {
    final question = questions[currentQuestionIndex];

    if (question.correctAnswer == question.possibleAnswers[answerIndex]) {
      score += 1;
    }
  }
}
