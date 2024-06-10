import 'package:app_well_mate/main.dart';
import 'package:flutter/material.dart';

class Shortcut extends StatefulWidget {
  const Shortcut({super.key, required this.icon, required this.text});
  final IconData icon;
  final String text;
  @override
  State<Shortcut> createState() => _ShortcutState();
}

class _ShortcutState extends State<Shortcut> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 10),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(color: Theme.of(context).colorScheme.primary, borderRadius: BorderRadius.all(Radius.circular(50))),
              child: Padding(padding: const EdgeInsets.all(20), child: Icon(widget.icon, color: colorScheme.surface),),
            ),
            const SizedBox(height: 6),
            Text(widget.text, textAlign: TextAlign.center,)
          ],
        ),
      ),
    );
  }
}