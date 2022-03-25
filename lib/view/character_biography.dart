import 'package:flutter/material.dart';
import 'package:futurama_quiz/data/data_notifier.dart';
import 'package:futurama_quiz/view/cage.dart';

class CharacterBiography extends StatelessWidget {
  const CharacterBiography({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dataNotifier = getDataNotifier(context, listen: true);

    final character = dataNotifier.currentCharacter!;
    return Cage(
      child: Column(children: [
        Expanded(child: Image.network(character.image)),
        Text(character.name),
        // TODO add the other character fields
        TextButton(
          child: const Text('Ok'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ]),
    );
  }
}
