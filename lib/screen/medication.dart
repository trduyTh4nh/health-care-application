import 'package:app_well_mate/screen/drug/add_drug.dart';
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
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AddDrugPage(),
                ));
          },
          child: const Icon(Icons.add)),
      body: Center(
        child: const Text("Medication page"),
      ),
    );
  }
}
