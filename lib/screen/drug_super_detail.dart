import 'package:flutter/material.dart';

class DrugSuperDetail extends StatefulWidget {
  const DrugSuperDetail({super.key});

  @override
  State<DrugSuperDetail> createState() => _DrugSuperDetailState();
}

class _DrugSuperDetailState extends State<DrugSuperDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [Text("03/02/2003 - Chi tiết")],
        ),
      ),
    );
  }
}
