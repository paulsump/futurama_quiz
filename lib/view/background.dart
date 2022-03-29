// © 2022, Paul Sumpner <sumpner@hotmail.com>

import 'package:flutter/material.dart';
import 'package:futurama_quiz/view/star.dart';

/// A container frame / scaffold for all pages.
class Background extends StatelessWidget {
  final Widget child;

  const Background({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/background.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            const Star(),
            SafeArea(
              left: false,
              child: child,
            ),
          ],
        ),
      ),
    );
  }
}
