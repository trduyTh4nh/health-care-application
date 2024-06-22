import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HeroWidget extends StatelessWidget {
  const HeroWidget({super.key, required this.tag, required this.child});
  final String tag;
  final Widget child;

  @override
  Widget build(BuildContext context) => Hero(
        tag: tag,
        child: Material(
          type: MaterialType.transparency,
          child: child,
        ),
      );
}
