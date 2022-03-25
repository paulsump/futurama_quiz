import 'package:flutter/material.dart';
import 'package:futurama_quiz/api/question.dart';
import 'package:provider/provider.dart';

QuizNotifier getQuizNotifier(BuildContext context, {required bool listen}) =>
    Provider.of<QuizNotifier>(context, listen: listen);

/// for the current state of the quiz e.g. current question, score
class QuizNotifier extends ChangeNotifier {
  Question? currentQuestion;

  var score = Score();

  void setCurrentQuestion(Question question) {
    currentQuestion = question;
  }
}

class Score {
  int correct = 0;
  int incorrect = 0;
}
