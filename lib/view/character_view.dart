// © 2022, Paul Sumpner <sumpner@hotmail.com>

import 'package:flutter/material.dart';
import 'package:futurama_quiz/data/characters.dart';

class CharacterView extends StatelessWidget {
  final Future<Character> character;

  const CharacterView({Key? key, required this.character}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Character>(
      future: character,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Text(snapshot.data!.name);
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }

        // By default, show a loading spinner.
        return const CircularProgressIndicator();
      },
    );
  }
}
