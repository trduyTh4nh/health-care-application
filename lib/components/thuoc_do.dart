import 'package:flutter/material.dart';

class thuocdo_widget extends StatelessWidget {
  thuocdo_widget({super.key, required this.color, required this.title});
  Color color;
  String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 15,
          height: 15,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        Text(
          title,
          style: Theme.of(context).textTheme.labelSmall,
        )
      ],
    );
  }
}
