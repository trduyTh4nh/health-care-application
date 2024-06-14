import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

class DrugInfoPage extends StatefulWidget {
  const DrugInfoPage({super.key});

  @override
  State<DrugInfoPage> createState() => _DrugInfoPageState();
}

class _DrugInfoPageState extends State<DrugInfoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Symbols.more_horiz))
        ],
      ),
      body: Center(child: Text('Drug information'),),
    );
  }
}