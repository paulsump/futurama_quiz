import 'package:flutter/material.dart';
import 'package:futurama_quiz/view/hue.dart';
import 'package:futurama_quiz/view/screen_adjust.dart';

/// Mostly used as a sort of back button
/// pop off the current screen.
/// It's not displayed as a [BackButton] because that would be
/// misleading on the quiz - you can't go back to the previous question.
class CancelButton extends StatelessWidget {
  const CancelButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenAdjust(
      portrait: const Offset(0.4, 0.59),
      landscape: const Offset(0.3, 0.95),
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
