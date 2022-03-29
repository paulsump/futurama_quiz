// © 2022, Paul Sumpner <sumpner@hotmail.com>

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:futurama_quiz/view/screen_adjust.dart';

/// Calculate a value between 0 and 1 but goes up and down like a sine wave.
double _calcUnitPingPong(double unitValue) => (1 + sin(2 * pi * unitValue)) / 2;

/// Little animated stars on the [Background]
class Star extends StatefulWidget {
  const Star({Key? key}) : super(key: key);

  @override
  _StarState createState() => _StarState();
}

class _StarState extends State<Star> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    const Duration pingPongDuration = Duration(milliseconds: 80000);

    _controller = AnimationController(duration: pingPongDuration, vsync: this)
      ..addListener(() {
        setState(() {});
      });
    _controller.repeat();

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = getScreenSize(context);

    const unit = Offset(1, 1);
    final center = unit * _calcUnitPingPong(_controller.value);

    final offset = Offset(size.width * center.dx, size.height * center.dy);
    final imageSize = unit * 128;

    return Transform.translate(
      offset: offset - imageSize / 2,
      child: const Image(
        image: AssetImage('images/star.png'),
      ),
    );
  }
}
