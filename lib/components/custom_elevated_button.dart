import 'package:app_well_mate/main.dart';
import 'package:flutter/material.dart';

class CustomElevatedButton extends StatefulWidget {
  const CustomElevatedButton(
      {super.key, required this.onTap, required this.child, this.color});
  final Function() onTap;
  final Widget child;
  final Color? color;
  @override
  State<CustomElevatedButton> createState() => _CustomElevatedButtonState();
}

class _CustomElevatedButtonState extends State<CustomElevatedButton> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: widget.color != null ? widget.color : colorScheme.primary,
      borderRadius: const BorderRadius.all(Radius.circular(30)),
      child: InkWell(
        onTap: widget.onTap,
        borderRadius: const BorderRadius.all(Radius.circular(30)),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
          child: widget.child,
        ),
      ),
    );
  }
}
