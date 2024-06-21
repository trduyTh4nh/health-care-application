import 'package:flutter/material.dart';
import 'package:app_well_mate/model/prescription_model.dart';
import 'package:app_well_mate/model/hospital_model.dart';
import 'medicationDetail.dart';

class MedicationPage extends StatefulWidget {
  @override
  _MedicationPageState createState() => _MedicationPageState();
}

class _MedicationPageState extends State<MedicationPage> {
  final List<PrescriptionModel> prescriptions = PrescriptionModel.getData();
  final List<HospitalModel> hospitals = HospitalModel.getData();

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
          final hospital = hospitals.firstWhere((h) => h.idHospital == prescription.idHospital);

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
                      Text(hospital.name ?? ''),
                      Text(prescription.convertTime(prescription.createdDate!)),
                    ],
                  ),
                  onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => PrescriptionDetailPage()));
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
          // Add your navigation logic here
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

// import 'package:app_well_mate/screen/drug/add_drug.dart';
// import 'package:flutter/material.dart';



// class MedicationPage extends StatefulWidget {
//   @override
//   _MedicationPageState createState() => _MedicationPageState();
// }

// class _MedicationPageState extends State<MedicationPage> {
//   final List<Map<String, String>> prescriptions = [
//     {
//       'id': '1',
//       'date': 'Đơn ngày 30/4/1975',
//       'hospital': 'Bệnh viện Đại Học Y Dược',
//       'time': '12 giờ trước',
//     },
//     {
//       'id': '2',
//       'date': 'Đơn ngày 01/02/2024',
//       'hospital': 'Bệnh viện Hùng Vương',
//       'time': '2 Ngày trước',
//     },
//     {
//       'id': '3',
//       'date': 'Đơn ngày 27/3/2023',
//       'hospital': 'Bệnh viện Trung Tâm',
//       'time': '4 giờ trước',
//     },
    
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         automaticallyImplyLeading: false,
//         title: Text('Đơn thuốc'),
//         actions: [
//           IconButton(
//             icon: Icon(Icons.delete),
//             onPressed: () {
//               // Xóa hết
//               setState(() {
//                 prescriptions.clear();
//               });
//             },
//           ),
//         ],
//       ),
//       body: ListView.builder(
//         itemCount: prescriptions.length,
//         itemBuilder: (context, index) {
//           final prescription = prescriptions[index];
//           return Column(
//             children: [
//               Dismissible(
//                 key: Key(prescription['id'] ?? index.toString()),
//                 direction: DismissDirection.endToStart, //hướng lướt để xóa
//                 onDismissed: (direction) {
//                   setState(() {
//                     prescriptions.removeAt(index);
//                   });
//                   // log xóa
//                   ScaffoldMessenger.of(context).showSnackBar(
//                     SnackBar(
//                       content: Text('${prescription['date']} đã bị xóa'),
//                     ),
//                   );
//                 },
//                 child: ListTile(
//                   leading: CircleAvatar(
//                     child: Icon(Icons.local_hospital),
//                   ),
//                   subtitle: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                      Text(
//                     prescription['date'] ?? '',
//                     style: Theme.of(context).textTheme.titleMedium,),
//                       Text(prescription['hospital'] ?? ''),
//                       Text(prescription['time'] ?? '',
//                       style: Theme.of(context).textTheme.titleMedium,),
//                     ],
//                   ),
//                 ),
//                 background: Container(
//                   color: Colors.red,
//                   alignment: Alignment.centerRight,
//                   padding: EdgeInsets.symmetric(horizontal: 20),
//                   child: Icon(
//                     Icons.delete,
//                     color: Colors.white,
//                   ),
//                 ),
//               ),
//               Divider(), // Thêm một đường ngăn cách để tách các phần tử
//             ],
//           );
//         },
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           Navigator.push(
//             context,
//             MaterialPageRoute(
//               builder: (context) => AddDrugPage(),
//             ),
//           );
//         },
//         child: Icon(Icons.add),
//       ),
//     );
//   }
// }


