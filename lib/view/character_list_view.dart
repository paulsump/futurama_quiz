// © 2022, Paul Sumpner <sumpner@hotmail.com>

import 'package:flutter/material.dart';
import 'package:futurama_quiz/data/data_notifier.dart';
import 'package:futurama_quiz/view/cage.dart';
import 'package:futurama_quiz/view/character_thumbnail.dart';
import 'package:futurama_quiz/view/screen_adjust.dart';

class CharacterListView extends StatelessWidget {
  const CharacterListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dataNotifier = getDataNotifier(context, listen: true);

    return dataNotifier.haveCharacters
        ? Cage(
            child: ListView(
              children: [
                for (final character in dataNotifier.characters)
                  SizedBox(
                    height: screenAdjust(0.4, context),
                    child: TextButton(
                        onPressed: () {
                          dataNotifier.setCurrentCharacter(character);
                          Navigator.of(context).pushNamed('CharacterBiography');
                        },
                        child: CharacterThumbnail(character: character)),
                  ),
              ],
            ),
          )
        : Container();
  }
}
