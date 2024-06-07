import 'package:app_well_mate/main.dart';
import 'package:flutter/material.dart';

class Shortcut extends StatefulWidget {
  const Shortcut({super.key});

  @override
  State<Shortcut> createState() => _ShortcutState();
}

class _ShortcutState extends State<Shortcut> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(color: Theme.of(context).colorScheme.primary, borderRadius: BorderRadius.all(Radius.circular(50))),
              child: Padding(padding: EdgeInsets.all(20), child: Icon(Icons.abc, color: colorScheme.surface),),
            ),
            SizedBox(height: 6,),
            Text("Text")
        
          ],
        ),
      ),
    );
  }
}
