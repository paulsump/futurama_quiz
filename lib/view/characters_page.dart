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
                        Navigator.of(context).pushNamed('CharacterBiography',
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
              Adjusted(1.5, isPortrait(context) ? -1 : 0,
                  _buildThumbnail(context, character)),
              if (isPortrait(context))
                Adjusted(
                    1.2,
                    6,
                    SizedBox(
                      width: screenAdjust(0.6, context),
                      child: _buildWords(context, character),
                    ))
              else
                Adjusted(
                    7,
                    0.8,
                    SizedBox(
                        width: screenAdjust(1, context),
                        child: _buildWords(context, character))),
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

    return ListView(children: [
      Text(character.type),
      padY,
      Text(character.occupation),
      padY,
      padY,
      for (final saying in character.sayings) Text('"$saying"\n'),
      padY,
    ]);
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
            height: screenAdjust(0.6, context),
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
