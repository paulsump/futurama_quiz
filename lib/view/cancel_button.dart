import 'package:flutter/material.dart';
import 'package:futurama_quiz/view/hue.dart';
import 'package:futurama_quiz/view/screen_adjust.dart';

class CancelButton extends StatelessWidget {
  const CancelButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: screenAdjust(0.006, context),
      child: Padding(
        padding: EdgeInsets.all(screenAdjust(0.05, context)),
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
