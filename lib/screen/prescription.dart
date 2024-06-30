import 'package:flutter/material.dart';
import 'package:app_well_mate/model/prescription_model.dart';
import 'medicationDetail.dart';

class PrescriptionPage extends StatefulWidget {
  @override
  _PrescriptionPageState createState() => _PrescriptionPageState();
}

class _PrescriptionPageState extends State<PrescriptionPage> {
  final List<PrescriptionModel> prescriptions = PrescriptionModel.getData();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Đơn thuốc'),
        actions: [
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              setState(() {
                prescriptions.clear();
              });
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: prescriptions.length,
        itemBuilder: (context, index) {
          final prescription = prescriptions[index];

          return Column(
            children: [
              Dismissible(
                key: Key(prescription.idPre.toString()),
                direction: DismissDirection.endToStart,
                onDismissed: (direction) {
                  setState(() {
                    prescriptions.removeAt(index);
                  });
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('${prescription.doctorName} đã bị xóa'),
                    ),
                  );
                },
                background: Container(
                  color: Colors.red,
                  alignment: Alignment.centerRight,
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Icon(
                    Icons.delete,
                    color: Colors.white,
                  ),
                ),
                child: ListTile(
                  leading: CircleAvatar(
                    child: Icon(Icons.local_hospital),
                  ),
                  title: Text(
                    prescription.createdDate != null
                        ? "Đơn ngày ${prescription.createdDate!.day}/${prescription.createdDate!.month}/${prescription.createdDate!.year}"
                        : '',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(prescription.hospital?.name ?? ''),
                      Text(prescription.convertTime(prescription.createdDate!)),
                    ],
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                       MaterialPageRoute(
                        builder: (context) => PrescriptionDetailPage(prescription: prescription),
                      ),
                    );
                  },
                ),
              ),
              Divider(),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
