// Copyright (c) 2022, Paul Sumpner.  All rights reserved.

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:futurama_quiz/out.dart';
import 'package:futurama_quiz/view/hue.dart';

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
    required this.portrait,
    required this.landscape,
    this.width,
    required this.child,
  }) : super(key: key);

  final Offset portrait, landscape;
  final double? width;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: (isPortrait(context) ? portrait : landscape) *
          screenAdjust(0.13, context),
      child: width != null
          ? Container(
              decoration: BoxDecoration(border: Border.all(color: Hue.border)),
              // color: Hue.lightForeground,
              width: screenAdjust(width!, context),
              child: child)
          : child,
    );
  }
}
