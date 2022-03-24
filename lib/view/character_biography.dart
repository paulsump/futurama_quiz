import 'package:flutter/material.dart';
import 'package:futurama_quiz/data/data_notifier.dart';

class CharacterBiography extends StatelessWidget {
  const CharacterBiography({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dataNotifier = getDataNotifier(context, listen: true);

    final character = dataNotifier.currentCharacter;
    return Column(children: [
      Text(character!.name),
      //TODO add the other character fields
      TextButton(
        child: const Text('Ok'),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
    ]);
  }
}
