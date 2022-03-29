import 'package:flutter/material.dart';
import 'package:futurama_quiz/view/hue.dart';
import 'package:futurama_quiz/view/screen_adjust.dart';

/// Simple [Text] with screen adjusted font size.
class SizedText extends StatelessWidget {
  const SizedText(this.text, {Key? key, this.bold = false, this.italic = false})
      : super(key: key);

  final String text;
  final bool bold, italic;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: Hue.text,
        fontSize: screenAdjust(0.04, context),
        fontWeight: bold ? FontWeight.bold : FontWeight.normal,
        fontStyle: italic ? FontStyle.italic : FontStyle.normal,
      ),
    );
  }
}
