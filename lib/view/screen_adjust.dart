// Copyright (c) 2022, Paul Sumpner.  All rights reserved.

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:futurama_quiz/out.dart';

const noWarn = out;

/// convenient access to screen dimensions.
Size getScreenSize(BuildContext context) => MediaQuery.of(context).size;

double getScreenWidth(BuildContext context) => getScreenSize(context).width;

double getScreenHeight(BuildContext context) => getScreenSize(context).height;

Offset getScreenCenter(BuildContext context) {
  final size = getScreenSize(context);
  return Offset(size.width, size.height) / 2;
}

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

// TODO REname to ScreenAdjusted
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
      // TODO round off this arbitrary number
      offset: Offset(x, y) * screenAdjust(0.13, context),
      child: child,
    );
  }
}
