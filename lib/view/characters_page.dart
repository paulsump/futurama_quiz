// © 2022, Paul Sumpner <sumpner@hotmail.com>

import 'package:flutter/material.dart';
import 'package:futurama_quiz/character.dart';
import 'package:futurama_quiz/fetch_notifier.dart';
import 'package:futurama_quiz/view/cage.dart';
import 'package:futurama_quiz/view/cancel_button.dart';
import 'package:futurama_quiz/view/hue.dart';
import 'package:futurama_quiz/view/screen_adjust.dart';

/// List of people/aliens with name and thumbnail.
/// Click on a character to view his/her full biography.
class CharactersPage extends StatelessWidget {
  const CharactersPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final fetchNotifier = getFetchNotifier(context, listen: true);

    final characters = fetchNotifier.characters;

    return Cage(
      child: Stack(
        children: [
          ScreenAdjust(
            x: 0,
            y: isPortrait(context) ? 0 : 1.5,
            child: ListView(
              scrollDirection:
                  isPortrait(context) ? Axis.vertical : Axis.horizontal,
              children: [
                for (int i = 0; i < characters.length; ++i)
                  ScreenAdjust(
                    x: isPortrait(context) ? (i.isEven ? 1 : -1) : 0,
                    y: 0,
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
        //TODO Animate this hero onto Biography
        SizedBox(
            height: screenAdjust(isPortrait(context) ? 0.4 : 0.6, context),
            child: Image.network(character.image)),
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
