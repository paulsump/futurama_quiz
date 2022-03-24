// © 2022, Paul Sumpner <sumpner@hotmail.com>

import 'package:flutter/material.dart';
import 'package:futurama_quiz/data/characters.dart';
import 'package:futurama_quiz/view/character_view.dart';

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
          //TODO ListView etc
          return CharacterView(character: snapshot.data![0]);
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }

        return const CircularProgressIndicator();
      },
    );
  }
}
