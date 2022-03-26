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

