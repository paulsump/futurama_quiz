// © 2022, Paul Sumpner <sumpner@hotmail.com>

import 'package:flutter/material.dart';
import 'package:futurama_quiz/data/data_notifier.dart';
import 'package:futurama_quiz/view/cage.dart';
import 'package:futurama_quiz/view/hue.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Cage(
      child: Column(children: [
        // TODO maybe pic of Fry here 'cause info talks about him?
        // if so, this could be loaded from assets
        const _InfoView(),
        TextButton(
          child: const Text(
            'Characters',
            style: TextStyle(color: Hue.text),
          ),
          onPressed: () {
            Navigator.of(context).pushNamed('Characters');
          },
        ),
      ]),
    );
  }
}

class _InfoView extends StatelessWidget {
  const _InfoView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dataNotifier = getDataNotifier(context, listen: true);

    return dataNotifier.haveInfo
        //TODO add the other info fields
        ? Column(
            children: [
              Text(dataNotifier.info.synopsis),
              Text(dataNotifier.info.yearsAired),
              for (final name in dataNotifier.info.creatorNames) Text(name),
            ],
          )
        : Container();
  }
}
