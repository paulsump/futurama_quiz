import 'package:flutter/material.dart';
import 'package:futurama_quiz/data/character.dart';
import 'package:futurama_quiz/data/question.dart';
import 'package:provider/provider.dart';

StateNotifier getStateNotifier(BuildContext context, {required bool listen}) =>
    Provider.of<StateNotifier>(context, listen: listen);

/// for the current state e.g. current question, score
/// but also the current character (which is why i didn't call this quizState)
/// if i don't use current character in the quiz (as a player avatar) then
/// i'll rename this.
class StateNotifier extends ChangeNotifier {
  Character? currentCharacter;
  Question? currentQuestion;

  void setCurrentCharacter(Character character) {
    currentCharacter = character;
  }

  void setCurrentQuestion(Question question) {
    currentQuestion = question;
  }
}
