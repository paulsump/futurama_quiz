// © 2022, Paul Sumpner <sumpner@hotmail.com>

import 'dart:io' show Platform;

import 'package:flutter/material.dart';
import 'package:futurama_quiz/fetch_notifier.dart';
import 'package:futurama_quiz/view/background.dart';
import 'package:futurama_quiz/view/hue.dart';
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

    return Background(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(children: [
                TextButton(
                  child: const Text(
                    'Characters',
                    style: TextStyle(color: Hue.text),
                  ),
                  onPressed: fetchNotifier.haveCharacters
                      ? () {
                          Navigator.of(context).pushNamed('Characters');
                        }
                      : null,
                ),
                // TODO Call this elsewhere only once
                // So far it's not slowing anything down.
                if (fetchNotifier.haveCharacters) _precacheImages(context),
              ]),
              TextButton(
                child: const Text(
                  'Quiz',
                  style: TextStyle(color: Hue.text),
                ),
                onPressed: fetchNotifier.haveQuestions
                    ? () {
                        Navigator.of(context).pushNamed('Quiz');
                      }
                    : null,
              )
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

  /// This make the images on the character list page pop up immediately
  /// instead of gradually when they are ready.
  Widget _precacheImages(BuildContext context) {
    if (Platform.environment.containsKey('FLUTTER_TEST')) {
      return Container();
    }
    final fetchNotifier = getFetchNotifier(context, listen: false);

    for (final character in fetchNotifier.characters) {
      final image = Image.network(character.image);

      precacheImage(image.image, context);
    }
    return Container();
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
              SizedBox(height: screenAdjust(0.04, context)),
              for (final name in fetchNotifier.info.creatorNames) Text(name),
            ],
          )
        : Center(child: Text(fetchNotifier.infoErrorMessage));
  }
}
