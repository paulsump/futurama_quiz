// © 2022, Paul Sumpner <sumpner@hotmail.com>

import 'package:flutter/material.dart';
import 'package:futurama_quiz/data/character.dart';
import 'package:futurama_quiz/data/data_notifier.dart';
import 'package:futurama_quiz/view/big_back_button.dart';
import 'package:futurama_quiz/view/cage.dart';
import 'package:futurama_quiz/view/hue.dart';
import 'package:futurama_quiz/view/screen_adjust.dart';

class CharacterListView extends StatelessWidget {
  const CharacterListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dataNotifier = getDataNotifier(context, listen: true);

    return dataNotifier.haveCharacters
        ? Cage(
            child: Stack(
              children: [
                ListView(
                  children: [
                    for (final character in dataNotifier.characters)
                      SizedBox(
                        height: screenAdjust(0.4, context),
                        child: TextButton(
                            onPressed: () {
                              Navigator.of(context).pushNamed(
                                  'CharacterBiography',
                                  arguments: character);
                            },
                            child: _CharacterThumbnail(character: character)),
                      ),
                  ],
                ),
                const BigBackButton(),
              ],
            ),
          )
        : Container();
  }
}

class CharacterBiography extends StatelessWidget {
  const CharacterBiography({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Extract the arguments from the current ModalRoute
    // settings and cast them to Character.
    final character = ModalRoute.of(context)!.settings.arguments as Character;
    return Cage(
      child: Stack(children: [
        Column(children: [
          Expanded(child: Image.network(character.image)),
          Text(character.name),
          // TODO add the other character fields
        ]),
        const BigBackButton(),
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
        Expanded(child: Image.network(character.image)),
        Text(
          character.name,
          style: const TextStyle(color: Hue.text),
        ),
      ],
    );
  }
}
