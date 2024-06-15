import 'package:flutter/material.dart';

class WidgetCompleteMedicine extends StatefulWidget {
  const WidgetCompleteMedicine({super.key});

  @override
  State<WidgetCompleteMedicine> createState() => _WidgetCompleteMedicine();
}

class _WidgetCompleteMedicine extends State<WidgetCompleteMedicine> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(children: [
          CircleAvatar(
            radius: 20,
            backgroundImage:
                NetworkImage('https://i.giphy.com/BSx6mzbW1ew7K.webp'),
          ),
          SizedBox(
            width: 12,
          ),
          Text("Nguyễn Duy", style: Theme.of(context).textTheme.titleMedium),
        ]),
        actions: const [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(Icons.notifications_none),
          )
        ],
      ),
    );
  }
}
