import 'package:flutter/material.dart';
import 'package:futurama_quiz/view/big_back_button.dart';
import 'package:futurama_quiz/view/cage.dart';

class ResultsView extends StatelessWidget {
  const ResultsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO Restart quiz button calls score.reset()

    return Cage(
        child: Stack(
      children: [
        const BigBackButton(),
        Container(),
      ],
    ));
  }
}
