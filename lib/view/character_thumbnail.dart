// © 2022, Paul Sumpner <sumpner@hotmail.com>

import 'package:flutter/material.dart';
import 'package:futurama_quiz/data/character.dart';
import 'package:futurama_quiz/view/hue.dart';

class CharacterThumbnail extends StatelessWidget {
  final Character character;

  const CharacterThumbnail({Key? key, required this.character})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(child: Image.network(character.image)),
        Text(
          character.name,
          style: const TextStyle(
            // fontWeight: FontWeight.bold,
            // fontSize: screenAdjust(0.06, context),
            color: Hue.text,
          ),
        ),
      ],
    );
  }
}
