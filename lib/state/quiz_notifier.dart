import 'package:flutter/material.dart';
import 'package:futurama_quiz/data/question.dart';
import 'package:provider/provider.dart';

QuizNotifier getStateNotifier(BuildContext context, {required bool listen}) =>
    Provider.of<QuizNotifier>(context, listen: listen);

/// for the current state of the quiz e.g. current question, score
class QuizNotifier extends ChangeNotifier {
  Question? currentQuestion;

  void setCurrentQuestion(Question question) {
    currentQuestion = question;
  }
}
