import 'package:flutter/material.dart';
import 'package:futurama_quiz/view/screen_adjust.dart';

class BigBackButton extends StatelessWidget {
  const BigBackButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: screenAdjust(0.008, context),
      child: const BackButton(),
    );
  }
}
