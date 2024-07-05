import 'package:app_well_mate/main.dart';
import 'package:flutter/material.dart';

class Shortcut extends StatefulWidget {
  const Shortcut(
      {super.key, required this.icon, required this.text, required this.onTap});
  final IconData icon;
  final String text;
  final VoidCallback onTap;
  @override
  State<Shortcut> createState() => _ShortcutState();
}

class _ShortcutState extends State<Shortcut> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  borderRadius: const BorderRadius.all(Radius.circular(50))),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Icon(widget.icon, color: colorScheme.surface),
              ),
            ),
            const SizedBox(height: 6),
            Text(
              widget.text,
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    );
  }
}
