import 'package:flutter/material.dart';

class BgImage extends StatelessWidget {
  final Widget child;

  const BgImage({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          "assets/event_pictures/bg.png",
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.fill,
        ),
        child,
      ],
    );
  }
}