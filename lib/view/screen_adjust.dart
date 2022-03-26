// Copyright (c) 2022, Paul Sumpner.  All rights reserved.

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:futurama_quiz/out.dart';

const noWarn = out;

/// convenient access to screen dimensions.
Size getScreenSize(BuildContext context) => MediaQuery.of(context).size;

bool isPortrait(BuildContext context) {
  final screen = getScreenSize(context);
  return screen.width < screen.height;
}

/// object dimensions calculated using the shortestEdge of the screen...

double screenAdjust(double length, BuildContext context) =>
    length * _getScreenShortestEdge(context);

double _getScreenShortestEdge(BuildContext context) {
  final screen = getScreenSize(context);

  return min(screen.width, screen.height);
}

/// Translate a child widget by an amount relative to
/// the length of the shortest edge of the device
class ScreenAdjust extends StatelessWidget {
  const ScreenAdjust({
    Key? key,
    required this.x,
    required this.y,
    required this.child,
  }) : super(key: key);

  final double x, y;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: Offset(x, y) * screenAdjust(0.13, context),
      child: child,
    );
  }
}
