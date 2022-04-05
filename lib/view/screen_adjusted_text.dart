// © 2022, Paul Sumpner <sumpner@hotmail.com>

import 'package:flutter/material.dart';
import 'package:futurama_quiz/view/hue.dart';
import 'package:futurama_quiz/view/screen_adjust.dart';

/// Simple [Text] with screen adjusted font size.
class ScreenAdjustedText extends StatelessWidget {
  const ScreenAdjustedText(
    this.text, {
    Key? key,
    this.bold = false,
    this.italic = false,
    this.size = 0.04,
  }) : super(key: key);

  final String text;

  final bool bold, italic;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: Hue.text,
        //TODO CHANge to screenAdjustY()
        fontSize: screenAdjust(size, context),
        fontWeight: bold ? FontWeight.bold : FontWeight.normal,
        fontStyle: italic ? FontStyle.italic : FontStyle.normal,
      ),
    );
  }
}
