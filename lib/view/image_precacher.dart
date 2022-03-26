import 'package:flutter/material.dart';
import 'package:futurama_quiz/api/api_notifier.dart';

class Precacher extends StatefulWidget {
  const Precacher({Key? key}) : super(key: key);

  @override
  State<Precacher> createState() => _PrecacherState();
}

class _PrecacherState extends State<Precacher> {
  final images = <Image>[];

  @override
  void didChangeDependencies() {
    final apiNotifier = getApiNotifier(context, listen: true);

    for (final character in apiNotifier.characters) {
      final image = Image.network(character.image);
      images.add(image);

      precacheImage(image.image, context);
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}