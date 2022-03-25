// © 2022, Paul Sumpner <sumpner@hotmail.com>

import 'package:flutter/material.dart';
import 'package:futurama_quiz/api/api_notifier.dart';
import 'package:futurama_quiz/view/cage.dart';
import 'package:futurama_quiz/view/hue.dart';
import 'package:futurama_quiz/view/screen_adjust.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Cage(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton(
                child: const Text(
                  'Characters',
                  style: TextStyle(color: Hue.text),
                ),
                onPressed: () {
                  Navigator.of(context).pushNamed('Characters');
                },
              ),
              TextButton(
                child: const Text(
                  'Quiz',
                  style: TextStyle(color: Hue.text),
                ),
                onPressed: () {
                  Navigator.of(context).pushNamed('Quiz');
                },
              ),
            ],
          ),
          Expanded(
            child: ListView(children: [
              Image(
                image: const AssetImage('images/fry.png'),
                height: screenAdjust(0.5, context),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  vertical: screenAdjust(0.08, context),
                  horizontal: screenAdjust(0.1, context),
                ),
                child: const _InfoView(),
              ),
            ]),
          ),
        ],
      ),
    );
  }
}

class _InfoView extends StatelessWidget {
  const _InfoView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final apiNotifier = getApiNotifier(context, listen: true);

    return apiNotifier.haveInfo
        //TODO add the other info fields
        ? Column(
            children: [
              Text(apiNotifier.info.synopsis),
              SizedBox(height: screenAdjust(0.1, context)),
              Text(apiNotifier.info.yearsAired),
              for (final name in apiNotifier.info.creatorNames) Text(name),
            ],
          )
        : Container();
  }
}
