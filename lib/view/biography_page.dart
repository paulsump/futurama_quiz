// © 2022, Paul Sumpner <sumpner@hotmail.com>

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:futurama_quiz/character.dart';
import 'package:futurama_quiz/view/cage.dart';
import 'package:futurama_quiz/view/cancel_button.dart';
import 'package:futurama_quiz/view/screen_adjust.dart';

/// Character Biography - Info on a person/alien
/// including a subset of his/her famous sayings.
class BiographyPage extends StatelessWidget {
  const BiographyPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final character = ModalRoute.of(context)!.settings.arguments as Character;

    return Cage(
      child: Stack(
        children: [
          const CancelButton(),
          Container(),
          ScreenAdjust(
            x: isPortrait(context) ? 0.7 : 0.5,
            y: isPortrait(context) ? 1.75 : 0.0,
            child: Stack(children: [
              ScreenAdjust(
                x: 1.5,
                y: isPortrait(context) ? -1 : 0.25,
                child: _buildThumbnail(context, character),
              ),
              if (isPortrait(context))
                ScreenAdjust(
                  x: 0.9,
                  y: 6,
                  child: SizedBox(
                    width: screenAdjust(0.6, context),
                    child: _buildWords(context, character),
                  ),
                )
              else
                ScreenAdjust(
                  x: 7,
                  y: 0.8,
                  child: SizedBox(
                      width: screenAdjust(1, context),
                      child: _buildWords(context, character)),
                ),
            ]),
          ),
        ],
      ),
    );
  }

  Widget _buildThumbnail(BuildContext context, Character character) {
    final padY = SizedBox(height: screenAdjust(0.06, context));

    return Column(children: [
      Container(
        constraints: BoxConstraints(
            maxWidth: screenAdjust(isPortrait(context) ? 0.53 : 0.63, context)),
        height: screenAdjust(0.73, context),
        child: Platform.environment.containsKey('FLUTTER_TEST')
            ? null
            : Image.network(character.image),
      ),
      padY,
      Text(
        character.name,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
    ]);
  }

  Widget _buildWords(BuildContext context, Character character) {
    final padY = SizedBox(height: screenAdjust(0.04, context));

    return ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: screenAdjust(
          isPortrait(context) ? 0.9 : 0.8,
          context,
        ),
      ),
      child: ListView(children: [
        Text(character.type),
        padY,
        Text(character.occupation),
        padY,
        padY,
        for (final saying in character.sayings)
          Text(
            '"$saying"\n',
            style: const TextStyle(fontStyle: FontStyle.italic),
          ),
        padY,
      ]),
    );
  }
}
