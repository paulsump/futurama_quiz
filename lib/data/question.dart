import 'package:futurama_quiz/data/fetcher.dart';

Future<List<Question>> fetchQuestions(Fetcher fetcher) async {
  final list = await fetcher.getList('questions');

  return list.map((character) => Question.fromJson(character)).toList();
}

class Question {
  Question.fromJson(Map<String, dynamic> json)
      //TODO containsKey
      : id = json['id'],
        question = json['question'],
        possibleAnswers = json['possibleAnswers']
            .map<String>((answer) => answer.toString())
            .toList(),
        correctAnswer = json['correctAnswer'].toString();

  final int id;
  final String question;
  final List<String> possibleAnswers;
  final String correctAnswer;
}
