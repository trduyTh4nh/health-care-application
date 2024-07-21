import 'package:app_well_mate/components/shotcut.dart';
import 'package:app_well_mate/main.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

class ErrorInfo extends StatelessWidget {
  const ErrorInfo({super.key, required this.title, required this.subtitle, this.action, this.icon});
  final String title;
  final String subtitle;
  final IconData? icon;
  final Widget? action;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            icon != null ? Icon(
              icon,
              size: 32,
              color: colorScheme.primary,
            ) : const SizedBox(),
            Text(
              title,
              style: Theme.of(context).textTheme.headlineLarge,
              textAlign: TextAlign.center,
            ),
            Text(
              subtitle,
              textAlign: TextAlign.center,
            ),
            action ?? const SizedBox()
          ],
        ),
      ),
    );
    ;
  }
}
