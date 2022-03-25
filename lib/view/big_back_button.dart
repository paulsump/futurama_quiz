import 'package:flutter/material.dart';

class BigBackButton extends StatelessWidget {
  const BigBackButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: 3,
      child: const BackButton(),
    );
  }
}
