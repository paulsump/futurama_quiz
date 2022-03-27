// © 2022, Paul Sumpner <sumpner@hotmail.com>

import 'package:flutter/material.dart';
import 'package:futurama_quiz/fetch_notifier.dart';
import 'package:futurama_quiz/view/cage.dart';
import 'package:futurama_quiz/view/hue.dart';
import 'package:futurama_quiz/view/image_precacher.dart';
import 'package:futurama_quiz/view/screen_adjust.dart';

/// The home page of the app, showing a synopsis of Futurama.
/// Allows access to the other two pages [CharactersPage] and [QuizPage]
/// via the two buttons that appear at the top once
/// the [Character]s and [Question]s have been fetched.
class InfoPage extends StatelessWidget {
  const InfoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final fetchNotifier = getFetchNotifier(context, listen: true);

    return Cage(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              fetchNotifier.haveCharacters
                  ? Column(
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
                        // TODO CHeck if we need to put this in here in the widget tree
                        const ImagePrecacher(),
                      ],
                    )
                  : Container(),
              fetchNotifier.haveQuestions
                  ? TextButton(
                      child: const Text(
                        'Quiz',
                        style: TextStyle(color: Hue.text),
                      ),
                      onPressed: () {
                        Navigator.of(context).pushNamed('Quiz');
                      },
                    )
                  : Container(),
            ],
          ),
          if (isPortrait(context))
            Expanded(
              child: ListView(children: [
                _buildImage(context),
                _buildInfo(context),
              ]),
            )
          else
            Expanded(
              child: Row(
                children: [
                  _buildImage(context),
                  Expanded(
                    child: ListView(children: [
                      _buildInfo(context),
                    ]),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildImage(BuildContext context) => Image(
        image: const AssetImage('images/fry.png'),
        height: screenAdjust(0.5, context),
      );

  Widget _buildInfo(BuildContext context) => Padding(
        padding: EdgeInsets.symmetric(
          vertical: screenAdjust(0.08, context),
          horizontal: screenAdjust(0.1, context),
        ),
        child: const _InfoView(),
      );
}

/// The view of the actual fetched data.
class _InfoView extends StatelessWidget {
  const _InfoView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final fetchNotifier = getFetchNotifier(context, listen: true);

    return fetchNotifier.haveInfo
        ? Column(
            children: [
              Text(fetchNotifier.info.synopsis),
              SizedBox(height: screenAdjust(0.1, context)),
              Text(fetchNotifier.info.yearsAired),
              for (final name in fetchNotifier.info.creatorNames) Text(name),
            ],
          )
        : Container();
  }
}
