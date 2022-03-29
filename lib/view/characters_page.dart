// © 2022, Paul Sumpner <sumpner@hotmail.com>

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:futurama_quiz/character.dart';
import 'package:futurama_quiz/fetch_notifier.dart';
import 'package:futurama_quiz/view/background.dart';
import 'package:futurama_quiz/view/cancel_button.dart';
import 'package:futurama_quiz/view/pulsate.dart';
import 'package:futurama_quiz/view/screen_adjust.dart';
import 'package:futurama_quiz/view/screen_adjusted_text.dart';

/// List of people/aliens with name and thumbnail.
/// Click on a character to view his/her full biography.
class CharactersPage extends StatelessWidget {
  const CharactersPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final fetchNotifier = getFetchNotifier(context, listen: true);

    final characters = fetchNotifier.characters;

    return Background(
      child: Stack(
        children: [
          ScreenAdjust(
            portrait: const Offset(0, 0),
            landscape: const Offset(0, 1.5),
            child: ListView(
              scrollDirection:
                  isPortrait(context) ? Axis.vertical : Axis.horizontal,
              children: [
                for (int i = 0; i < characters.length; ++i)
                  ScreenAdjust(
                    portrait: Offset(i.isEven ? 1 : -1, 0),
                    landscape: const Offset(0, 0),
                    child: TextButton(
                        onPressed: () {
                          Navigator.of(context)
                              .pushNamed('Biography', arguments: characters[i]);
                        },
                        child: _Thumbnail(character: characters[i])),
                  ),
              ],
            ),
          ),
          const CancelButton(),
        ],
      ),
    );
  }
}

/// A labeled image of a character.
class _Thumbnail extends StatelessWidget {
  final Character character;

  const _Thumbnail({Key? key, required this.character}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final padY = SizedBox(height: screenAdjust(0.02, context));

    return Column(
      children: [
        if (!Platform.environment.containsKey('FLUTTER_TEST'))
          SizedBox(
              height: screenAdjust(isPortrait(context) ? 0.4 : 0.6, context),
              child: Pulsate(child: Image.network(character.image))),
        padY,
        ScreenAdjustedText(character.name),
        padY,
      ],
    );
  }
}
