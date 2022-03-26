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
          offset: const Offset(0, -3) * screenAdjust(0.13, context),
          child: Column(children: [
            Expanded(child: Image.network(character.image)),
            Text(character.name),
          ]),
        ),
        Transform.translate(
          offset: const Offset(2, 9) * screenAdjust(0.13, context),
          child: Column(children: [
            Text(character.type),
            SizedBox(height: screenAdjust(0.04, context)),
            Text(character.occupation),
            SizedBox(height: screenAdjust(0.04, context)),
            for (final saying in character.sayings) Text(saying + '\n'),
            SizedBox(height: screenAdjust(0.04, context)),
          ]),
        ),
        const BigBackButton(),
        Container(),
      ]),
    );
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
