// © 2022, Paul Sumpner <sumpner@hotmail.com>

import 'package:flutter/material.dart';
import 'package:futurama_quiz/view/hue.dart';

/// A container frame / scaffold for all pages.
class Cage extends StatelessWidget {
  final Widget child;

  const Cage({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Hue.background,
        child: SafeArea(
          left: false,
          child: child,
        ),
      ),
    );
  }
}
