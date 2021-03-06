// © 2022, Paul Sumpner <sumpner@hotmail.com>

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:futurama_quiz/character.dart';
import 'package:futurama_quiz/view/background.dart';
import 'package:futurama_quiz/view/cancel_button.dart';
import 'package:futurama_quiz/view/pulsate.dart';
import 'package:futurama_quiz/view/screen_adjust.dart';
import 'package:futurama_quiz/view/screen_adjusted_text.dart';

/// Character Biography - Info on a person/alien
/// including a subset of his/her famous sayings.
class BiographyPage extends StatelessWidget {
  const BiographyPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final character = ModalRoute.of(context)!.settings.arguments as Character;

    return Background(
      child: Stack(
        children: [
          const CancelButton(),
          Container(),
          ScreenAdjust(
            portrait: const Offset(0.7, 1.75),
            landscape: const Offset(0.5, 0.0),
            child: Stack(children: [
              ScreenAdjust(
                portrait: const Offset(1.0, -1),
                landscape: const Offset(1.0, 3.25),
                child: _buildThumbnail(context, character),
              ),
              ScreenAdjust(
                portrait: const Offset(6.5, 8.5),
                landscape: const Offset(4, 14),
                width: isPortrait(context) ? 0.7 : 0.44,
                anchorBottom: true,
                anchorRight: true,
                child: _buildWords(context, character),
              ),
            ]),
          ),
        ],
      ),
    );
  }

  Widget _buildThumbnail(BuildContext context, Character character) {
    final padY = SizedBox(height: screenAdjustY(0.015, context));

    return Column(children: [
      Container(
        constraints: BoxConstraints(
            maxWidth:
                screenAdjustX(isPortrait(context) ? 0.66 : 0.29, context)),
        height: screenAdjustY(isPortrait(context) ? 0.4 : 0.5, context),
        child: Platform.environment.containsKey('FLUTTER_TEST')
            ? null
            : Pulsate(child: Image.network(character.image)),
      ),
      padY,
      ScreenAdjustedText(character.name, bold: true),
    ]);
  }

  Widget _buildWords(BuildContext context, Character character) {
    final padY = SizedBox(height: screenAdjust(0.04, context));

    return ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: screenAdjust(
          isPortrait(context) ? 0.48 : 0.68,
          context,
        ),
      ),
      child: ListView(children: [
        ScreenAdjustedText(character.type),
        if (character.occupation.isNotEmpty) padY,
        if (character.occupation.isNotEmpty)
          ScreenAdjustedText(character.occupation),
        padY,
        padY,
        for (final saying in character.sayings)
          ScreenAdjustedText(
            '"$saying"\n',
            italic: true,
          ),
        padY,
      ]),
    );
  }
}
