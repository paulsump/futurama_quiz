// © 2022, Paul Sumpner <sumpner@hotmail.com>

import 'package:flutter/material.dart';
import 'package:futurama_quiz/api/api_notifier.dart';
import 'package:futurama_quiz/api/character.dart';
import 'package:futurama_quiz/view/big_back_button.dart';
import 'package:futurama_quiz/view/cage.dart';
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
          ListView(
            children: [
              for (final character in apiNotifier.characters)
                SizedBox(
                  height: screenAdjust(0.4, context),
                  child: TextButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed('CharacterBiography',
                            arguments: character);
                      },
                      child: _CharacterThumbnail(character: character)),
                ),
            ],
          ),
          const BigBackButton(),
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
      child: Stack(children: [
        Transform.translate(
          offset: const Offset(1.5, 1) * screenAdjust(0.13, context),
          child: _buildThumbnail(context, character),
        ),
        Transform.translate(
          offset: const Offset(1, 9) * screenAdjust(0.13, context),
          child: _buildWords(context, character),
        ),
        const BigBackButton(),
        Container(),
      ]),
    );
  }

  Column _buildThumbnail(BuildContext context, Character character) {
    return Column(children: [
      SizedBox(
          height: screenAdjust(0.93, context),
          child: Image.network(character.image)),
      Text(character.name),
    ]);
  }

  Widget _buildWords(BuildContext context, Character character) {
    final padY = SizedBox(height: screenAdjust(0.04, context));

    return Column(children: [
      Text(character.type),
      padY,
      Text(character.occupation),
      padY,
      for (final saying in character.sayings)
        SizedBox(
            width: screenAdjust(0.73, context), child: Text(saying + '\n')),
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
    return Column(
      children: [
        //TODO Animate this hero onto Biography
        Expanded(child: Image.network(character.image)),
        Text(
          character.name,
          style: const TextStyle(color: Hue.text),
        ),
      ],
    );
  }
}
