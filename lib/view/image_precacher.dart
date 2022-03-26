import 'package:flutter/material.dart';
import 'package:futurama_quiz/fetch_notifier.dart';

/// Pre loads all the character images so that we
/// see them immediately when we go to the [CharactersPage]
class ImagePrecacher extends StatefulWidget {
  const ImagePrecacher({Key? key}) : super(key: key);

  @override
  State<ImagePrecacher> createState() => _ImagePrecacherState();
}

class _ImagePrecacherState extends State<ImagePrecacher> {
  //TODO check if it works without this array
  final images = <Image>[];

  @override
  void didChangeDependencies() {
    final fetchNotifier = getFetchNotifier(context, listen: true);

    for (final character in fetchNotifier.characters) {
      final image = Image.network(character.image);

      images.add(image);
      precacheImage(image.image, context);
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) => Container();
}
