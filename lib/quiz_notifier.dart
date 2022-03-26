import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

QuizNotifier getQuizNotifier(BuildContext context, {required bool listen}) =>
    Provider.of<QuizNotifier>(context, listen: listen);

/// For the current state of the quiz e.g. current question, score
class QuizNotifier extends ChangeNotifier {
  int currentQuestionIndex = 27; //hack

  var score = Score();

  void restart() {
    score.reset();

    currentQuestionIndex = 0;
    notifyListeners();
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
