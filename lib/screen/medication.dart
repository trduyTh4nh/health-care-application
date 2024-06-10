import 'package:flutter/material.dart';

class MedicationPage extends StatefulWidget {
  const MedicationPage({super.key});

  @override
  State<MedicationPage> createState() => _MedicationPageState();
}

class _MedicationPageState extends State<MedicationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: const Text("Medication page"),
      ),
    );
  }
}
