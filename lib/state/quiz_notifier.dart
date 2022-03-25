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

  void submitFinalAnswer(int answerIndex) {
    final question = currentQuestion!;

    if (question.correctAnswer == question.possibleAnswers[answerIndex]) {
      score.correct += 1;
    } else {
      score.incorrect += 1;
    }
  }
}

class Score {
  int correct = 0;
  int incorrect = 0;

  // TODO Restart quiz
  void reset() {
    correct = 0;
    incorrect = 0;
  }
}
