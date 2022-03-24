// © 2022, Paul Sumpner <sumpner@hotmail.com>

import 'package:flutter/material.dart';
import 'package:futurama_quiz/data/info.dart';

class InfoView extends StatelessWidget {
  final Future<Info> info;

  const InfoView({Key? key, required this.info}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Info>(
      future: info,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Text(snapshot.data!.synopsis);
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }

        // By default, show a loading spinner.
        return const CircularProgressIndicator();
      },
    );
  }
}
