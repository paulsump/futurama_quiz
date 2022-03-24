// © 2022, Paul Sumpner <sumpner@hotmail.com>

import 'package:flutter/material.dart';
import 'package:futurama_quiz/data/character.dart';
import 'package:futurama_quiz/view/character_view.dart';
import 'package:futurama_quiz/view/screen_adjust.dart';

class CharacterListView extends StatelessWidget {
  final Future<List<Character>> characters;

  const CharacterListView({Key? key, required this.characters})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Character>>(
      future: characters,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final characters_ = snapshot.data!;

          return Expanded(
            child: ListView(
              children: [
                for (final character in characters_)
                  SizedBox(
                      height: screenAdjust(0.4, context),
                      child: CharacterView(character: character)),
              ],
            ),
          );
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }

        return const CircularProgressIndicator();
      },
    );
  }
}
