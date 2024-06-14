import 'package:app_well_mate/main.dart';
import 'package:flutter/material.dart';

class CustomElevatedBtnCheck extends StatefulWidget {
  const CustomElevatedBtnCheck(
      {super.key, required this.onTap, required this.child, this.color});
  final Function() onTap;
  final Widget child;
  final Color? color;
  @override
  State<CustomElevatedBtnCheck> createState() => _CustomElevatedBtnCheckState();
}

class _CustomElevatedBtnCheckState extends State<CustomElevatedBtnCheck> {
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
