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
                  height: screenAdjust(0.5, context),
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
        _place(1.5, 0.5, _buildThumbnail(context, character), context),
        if (isPortrait(context))
          _place(
              1,
              8,
              SizedBox(
                  width: screenAdjust(0.8, context),
                  child: _buildWords(context, character)),
              context)
        else
          _place(
              7,
              1,
              SizedBox(
                  width: screenAdjust(1, context),
                  child: _buildWords(context, character)),
              context),
        const BigBackButton(),
        Container(),
      ]),
    );
  }

  Widget _place(double x, double y, Widget widget, BuildContext context) =>
      Transform.translate(
        offset: Offset(x, y) * screenAdjust(0.13, context),
        child: widget,
      );

  Widget _buildThumbnail(BuildContext context, Character character) {
    final padY = SizedBox(height: screenAdjust(0.04, context));

    return Column(children: [
      Container(
          constraints: BoxConstraints(maxWidth: screenAdjust(0.63, context)),
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
      for (final saying in character.sayings) Text(saying + '\n'),
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
        Expanded(child: Image.network(character.image)),
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
