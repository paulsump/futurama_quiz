// © 2022, Paul Sumpner <sumpner@hotmail.com>

import 'package:flutter/material.dart';
import 'package:futurama_quiz/api/character.dart';
import 'package:futurama_quiz/view/cage.dart';
import 'package:futurama_quiz/view/cancel_button.dart';
import 'package:futurama_quiz/view/screen_adjust.dart';

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
          Adjusted(
            isPortrait(context) ? 0.7 : 0.5,
            isPortrait(context) ? 1.75 : 0.0,
            Stack(children: [
              Adjusted(
                1.5,
                isPortrait(context) ? -1 : 0.25,
                _buildThumbnail(context, character),
              ),
              if (isPortrait(context))
                Adjusted(
                  0.9,
                  6,
                  SizedBox(
                    width: screenAdjust(0.6, context),
                    child: _buildWords(context, character),
                  ),
                )
              else
                Adjusted(
                  7,
                  0.8,
                  SizedBox(
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
              maxWidth:
                  screenAdjust(isPortrait(context) ? 0.53 : 0.63, context)),
          height: screenAdjust(0.73, context),
          child: Image.network(character.image)),
      padY,
      Text(character.name),
    ]);
  }

  Widget _buildWords(BuildContext context, Character character) {
    final padY = SizedBox(height: screenAdjust(0.04, context));

    return ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: screenAdjust(0.6, context)),

      child: ListView(children: [
        Text(character.type),
        padY,
        Text(character.occupation),
        padY,
        padY,
        for (final saying in character.sayings) Text('"$saying"\n'),
        padY,
      ]),
    );
  }
}
