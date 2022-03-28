// Copyright (c) 2022, Paul Sumpner.  All rights reserved.

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:futurama_quiz/out.dart';
import 'package:futurama_quiz/view/hue.dart';

const noWarn = [out, Hue];

/// convenient access to screen dimensions.
Size _getScreenSize(BuildContext context) => MediaQuery.of(context).size;

bool isPortrait(BuildContext context) {
  final screen = _getScreenSize(context);
  return screen.width < screen.height;
}

/// object dimensions calculated using the shortestEdge of the screen...

double screenAdjust(double length, BuildContext context) =>
    length * _getScreenShortestEdge(context);

double _getScreenShortestEdge(BuildContext context) {
  final screen = _getScreenSize(context);

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
    this.fromBottomUp = false,
  }) : super(key: key);

  final Offset portrait, landscape;
  final double? width;
  final Widget child;
  final bool fromBottomUp;

  @override
  Widget build(BuildContext context) {
    final offset_ = (isPortrait(context) ? portrait : landscape) *
        screenAdjust(0.13, context);

    final h = _getScreenSize(context).height;
    final offset =
        Offset(offset_.dx, fromBottomUp ? h - offset_.dy : offset_.dy);

    return Transform.translate(
      offset: offset,
      child: width != null
          ? SizedBox(
              // Container(
              // decoration: BoxDecoration(
              //     color: Hue.lightForeground,
              //     border: Border.all(color: Hue.border)),
              //TODO maybe rename width to scale
              width: fromBottomUp ? width! * h : screenAdjust(width!, context),
              child: child)
          : child,
    );
  }
}
