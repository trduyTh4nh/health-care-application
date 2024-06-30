import 'package:app_well_mate/screen/medicationSuperDetail.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:app_well_mate/model/prescription_model.dart';
import 'package:app_well_mate/model/user.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:app_well_mate/model/disease_model.dart';

class PrescriptionDetailPage extends StatefulWidget {
  final PrescriptionModel prescription;

  PrescriptionDetailPage({required this.prescription});

  @override
  State<PrescriptionDetailPage> createState() => _PrescriptionDetailPageState();
}

class _PrescriptionDetailPageState extends State<PrescriptionDetailPage> {
  late User user = User(
      idUser: 1,
      email: 'huynhtuan@gmail.com',
      password: '@Tuan.030209',
      role: 'user',
      userName: 'rintuan');
  late DiseaseModel diseaseModel = DiseaseModel(
      id: 1,
      doctor: 'ThS.BS.CKI Phan Lương Huy',
      title: 'Cancer',
      description:
          'Ở giai đoạn 2 của ung thư đại tràng, khối u vẫn chưa lan ra đến các hạch bạch huyết lân cận hoặc di căn xa. Vì vậy nếu phát hiện sớm thì vẫn có cơ hội để kiểm soát và chữa khỏi hoàn toàn. Bên cạnh phát hiện sớm ung thư đại tràng, các yếu tố như độ tuổi, lựa chọn điều trị, thể trạng người bệnh cũng như mức độ đáp ứng điều trị cũng ảnh hưởng đến kết quả điều trị.',
      time: DateTime.now(),
      overview:
          'Ung thư màng phổi là gì? U trung biểu mô (mesothelioma) là ung thư xảy ra ở các lớp màng mỏng bao bọc các cơ quan trong cơ thể, bao gồm lớp biểu mô màng bụng, màng ngoài tim và màng phổi, vốn có nguồn gốc phôi thai từ trung bì phổi. Trong các vị trí trên, ung thư trung biểu mô xảy ra chủ yếu ở màng phổi. Ung thư trung biểu mô màng phổi (maglinant pleural mesothelioma) cũng là loại ung thư duy nhất của màng phổi được biết đến',
      details: diseaseArr,
      reason: "1. Một số loại thực phẩm có chứa nitrat. \n"
          "2. Thay đổi giấc ngủ hoặc thiếu ngủ. \n"
          "3. Tư thế xấu. \n"
          "4. Bỏ bữa. \n"
          "5. Căng thẳng. \n");
  String formatDate(DateTime date) {
    return DateFormat('dd/MM/yyyy').format(date);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          formatDate(widget.prescription.createdDate!),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 8),

                Row(
                  children: [
                    Text("Bệnh nhân: ",
                        style: Theme.of(context).textTheme.titleMedium),
                    Text('${user.userName!}'),
                  ],
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text("Bệnh: ",
                            style: Theme.of(context).textTheme.titleMedium),
                        Text('${diseaseModel.title}'),
                      ],
                    ),
                    Row(
                      children: [
                        Text("Ngày tái khám: ",
                            style: Theme.of(context).textTheme.titleMedium),
                        Text(formatDate(widget.prescription.createdDate!)),
                      ],
                    ),
                  ],
                ),

                SizedBox(height: 16),
                Table(
                  border: TableBorder.all(color: Colors.grey),
                  columnWidths: const {
                    0: FlexColumnWidth(2),
                    1: FlexColumnWidth(1),
                    2: FlexColumnWidth(1),
                    3: FlexColumnWidth(2),
                  },
                  children: [
                    const TableRow(
                      children: [
                        TableCell(
                            child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text("Tên thuốc"))),
                        TableCell(
                            child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text("Số lượng"))),
                        TableCell(
                            child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text("Đơn vị"))),
                        TableCell(
                            child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text("Ghi chú"))),
                      ],
                    ),
                    ...widget.prescription.medications.map((medication) {
                      return TableRow(
                        children: [
                          TableCell(
                              child: Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                      medication.drug?.name ?? 'Unknown'))),
                          TableCell(
                              child: Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(medication.quantity.toString()))),
                          TableCell(
                              child: Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child:
                                      Text(medication.drug!.unit.toString()))),
                          TableCell(
                              child: Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(medication.notes!))),
                        ],
                      );
                    }).toList(),
                  ],
                ),
                SizedBox(height: 16),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          Text("Lời dặn của bác sĩ:",
                              style: Theme.of(context).textTheme.titleMedium),
                          const Text(
                              "Sức đề kháng kém là do bạn không chơi đồ đó bạn ạ",
                              style: TextStyle(fontSize: 16)),
                        ],
                      ),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        children: [
                          Text(
                            "Toa thuốc cấp ngày ${formatDate(widget.prescription.createdDate!)}",
                            style: TextStyle(fontSize: 16),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 8),
                          const Text("Bác sĩ", style: TextStyle(fontSize: 16)),
                          Text(widget.prescription.doctorName!,
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold)),
                          SizedBox(height: 8),
                          Icon(Symbols.signature, size: 48),
                        ],
                      ),
                    ),
                  ],
                ), // Giả sử đây là chữ ký của bác sĩ
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(0.0),
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                      context,
                       MaterialPageRoute(
                        builder: (context) => MedicationSuperDetail(),
                      ),
                    );
                      },
                      child: Text("Chi tiết đơn thuốc"),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: FilledButton(
                        onPressed: () {}, child: const Text("Hủy")),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
