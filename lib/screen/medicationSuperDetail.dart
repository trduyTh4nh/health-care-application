import 'package:flutter/material.dart';
class MedicationSuperDetail extends StatefulWidget {
  const MedicationSuperDetail({super.key});
  

  @override
  State<MedicationSuperDetail> createState() => _MedicationSuperDetailState();
}

class _MedicationSuperDetailState extends State<MedicationSuperDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('xin chao'),),
        // leading: IconButton(
        //   icon: Icon(Icons.arrow_back),
        //   onPressed: () {},
        // ),
    );
    
    
  }
}