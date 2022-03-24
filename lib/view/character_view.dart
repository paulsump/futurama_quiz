// © 2022, Paul Sumpner <sumpner@hotmail.com>

import 'package:flutter/material.dart';
import 'package:futurama_quiz/data/character.dart';

class CharacterView extends StatelessWidget {
  final Character character;

  const CharacterView({Key? key, required this.character}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.network(character.image);
  }
}
