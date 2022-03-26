import 'package:flutter/material.dart';
import 'package:futurama_quiz/view/hue.dart';
import 'package:futurama_quiz/view/screen_adjust.dart';

/// Mostly used as a sort of back button
/// pop off the current screen.
/// It's not a back button because that would be
/// misleading on the quiz - you can't go back to the previous question.
class CancelButton extends StatelessWidget {
  const CancelButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: screenAdjust(0.006, context),
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: screenAdjust(0.05, context),
          horizontal: screenAdjust(0.03, context),
        ),
        child: TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Icon(
              Icons.cancel_outlined,
              color: Hue.enabledIcon,
            )),
      ),
    );
  }
}
