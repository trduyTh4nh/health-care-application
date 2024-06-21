import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PrescriptionDetailPage extends StatelessWidget {
  final DateTime prescriptionDate = DateTime.parse("2003-02-03T12:34:56");
  final String patientName = "Mr. Steve";
  final String diagnosis = "Đau đầu";
  final List<Map<String, String>> medicationList = [
    {"name": "Gliclazid", "quantity": "20", "unit": "viên", "notes": "Sáng 1 viên sau khi ăn"},
    {"name": "Arthur", "quantity": "2", "unit": "viên", "notes": "Trưa + tối sau khi ăn"},
    {"name": "Violet", "quantity": "4", "unit": "viên", "notes": "Mỗi tuần một viên"},
    {"name": "Panadon", "quantity": "10", "unit": "viên", "notes": "Mỗi ngày một viên"},
  ];
  final String doctorAdvice = "Hạn chế rượu bia, tăng cường tập thể dục, ăn uống điều độ";
  final DateTime issueDate = DateTime.parse("2024-06-06T12:34:56");
  final String doctorName = "Trần Duy Thành";

  String formatDate(DateTime date) {
    return DateFormat('dd/MM/yyyy').format(date);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Drug Detail'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(formatDate(prescriptionDate), style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Text("Bệnh nhân: $patientName", style: TextStyle(fontSize: 16)),
            Text("Bệnh: $diagnosis", style: TextStyle(fontSize: 16)),
            Text("Ngày tái khám: ${formatDate(prescriptionDate)}", style: TextStyle(fontSize: 16)),
            SizedBox(height: 16),
            Table(
              border: TableBorder.all(color: Colors.grey),
              columnWidths: {
                0: FlexColumnWidth(2),
                1: FlexColumnWidth(1),
                2: FlexColumnWidth(1),
                3: FlexColumnWidth(2),
              },
              children: [
                TableRow(
                  children: [
                    TableCell(child: Padding(padding: EdgeInsets.all(8.0), child: Text("Tên thuốc"))),
                    TableCell(child: Padding(padding: EdgeInsets.all(8.0), child: Text("Số lượng"))),
                    TableCell(child: Padding(padding: EdgeInsets.all(8.0), child: Text("Đơn vị"))),
                    TableCell(child: Padding(padding: EdgeInsets.all(8.0), child: Text("Ghi chú"))),
                  ],
                ),
                ...medicationList.map((medication) {
                  return TableRow(
                    children: [
                      TableCell(child: Padding(padding: EdgeInsets.all(8.0), child: Text(medication["name"]!))),
                      TableCell(child: Padding(padding: EdgeInsets.all(8.0), child: Text(medication["quantity"]!))),
                      TableCell(child: Padding(padding: EdgeInsets.all(8.0), child: Text(medication["unit"]!))),
                      TableCell(child: Padding(padding: EdgeInsets.all(8.0), child: Text(medication["notes"]!))),
                    ],
                  );
                }).toList(),
              ],
            ),
            SizedBox(height: 16),
            Text("Lời dặn của bác sĩ:", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            Text(doctorAdvice, style: TextStyle(fontSize: 16)),
            SizedBox(height: 16),
            Text("Toa thuốc cấp ngày ${formatDate(issueDate)}", style: TextStyle(fontSize: 16)),
            SizedBox(height: 8),
            Text("Bác sĩ", style: TextStyle(fontSize: 16)),
            Text(doctorName, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Icon(Icons.edit, size: 48),  // Giả sử đây là chữ ký của bác sĩ
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                onPressed: () {},
                child: Text('Chi tiết đơn thuốc'),
              ),
              ElevatedButton(
                onPressed: () {},
                // style: ElevatedButton.styleFrom(primary: Colors.red),
                child: Text('Hủy'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void main() => runApp(MaterialApp(
  home: PrescriptionDetailPage(),
));
