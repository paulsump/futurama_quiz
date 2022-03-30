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
    return Transform.translate(
      offset:
          Offset(screenAdjustX(0.06, context), screenAdjustY(0.04, context)),
      child: Transform.scale(
        scale: screenAdjust(0.006, context),
        child: IconButton(
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(
              Icons.cancel_outlined,
              color: Hue.enabledIcon,
            )),
      ),
    );
  }
}
