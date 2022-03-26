// © 2022, Paul Sumpner <sumpner@hotmail.com>

import 'package:flutter/material.dart';
import 'package:futurama_quiz/api/api_notifier.dart';
import 'package:futurama_quiz/api/character.dart';
import 'package:futurama_quiz/view/cage.dart';
import 'package:futurama_quiz/view/cancel_button.dart';
import 'package:futurama_quiz/view/hue.dart';
import 'package:futurama_quiz/view/screen_adjust.dart';

class CharactersPage extends StatelessWidget {
  const CharactersPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final apiNotifier = getApiNotifier(context, listen: true);

    return Cage(
      child: Stack(
        children: [
          Adjusted(
            0,
            isPortrait(context) ? 0 : 1.5,
            ListView(
              scrollDirection:
                  isPortrait(context) ? Axis.vertical : Axis.horizontal,
              children: [
                for (final character in apiNotifier.characters)
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed('Biography',
                            arguments: character);
                      },
                      child: _CharacterThumbnail(character: character)),
              ],
            ),
          ),
          const CancelButton(),
        ],
      ),
    );
  }
}

class _CharacterThumbnail extends StatelessWidget {
  final Character character;

  const _CharacterThumbnail({Key? key, required this.character})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final padY = SizedBox(height: screenAdjust(0.02, context));

    return Column(
      children: [
        //TODO Animate this hero onto Biography
        SizedBox(
            height: screenAdjust(isPortrait(context)?0.4:0.6, context),
            child: Image.network(character.image)),
        padY,
        Text(
          character.name,
          style: const TextStyle(color: Hue.text),
        ),
        padY,
      ],
    );
  }
}
