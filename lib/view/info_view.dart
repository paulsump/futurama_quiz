// © 2022, Paul Sumpner <sumpner@hotmail.com>

import 'package:flutter/material.dart';
import 'package:futurama_quiz/data/data_notifier.dart';

class InfoView extends StatelessWidget {
  const InfoView({Key? key}) : super(key: key);

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
