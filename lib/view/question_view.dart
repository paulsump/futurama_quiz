import 'package:flutter/material.dart';
import 'package:futurama_quiz/data/question.dart';

class QuestionView extends StatelessWidget {
  final Question question;

  const QuestionView({Key? key, required this.question}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(question.question);
  }
}
