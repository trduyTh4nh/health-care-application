import 'package:app_well_mate/components/prescription_item.dart';
import 'package:app_well_mate/main.dart';
import 'package:app_well_mate/model/prescription_detail_model.dart';
import 'package:app_well_mate/providers/add_page_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:provider/provider.dart';

class AddDrugInfoPage extends StatefulWidget {
  const AddDrugInfoPage({super.key});

  @override
  State<AddDrugInfoPage> createState() => _AddDrugInfoPageState();
}

class _AddDrugInfoPageState extends State<AddDrugInfoPage> {
  List<(IconData, String)> units = [
    (Symbols.pill, "Viên"),
    (Symbols.pill, "Ống"),
    (Symbols.pill, "Giọt"),
    (Symbols.pill, "Lọ"),
    (Symbols.pill, "Mũi tiêm"),
    (Symbols.pill, "Gói"),
    (Symbols.pill, "Lần"),
  ];
  TextEditingController nameController = TextEditingController(),
      quantityController = TextEditingController();
  late (IconData, String) selection = units[0];
  List<DropdownMenuItem<(IconData, String)>> options = [];
  @override
  void initState() {
    options = units
        .map((e) => DropdownMenuItem<(IconData, String)>(
              value: e,
              child: Row(
                children: [
                  Icon(e.$1),
                  SizedBox(
                    width: 10,
                  ),
                  Text(e.$2)
                ],
              ),
            ))
        .toList();
    setState(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AddPageProvider>(builder: (context, value, child) {
      nameController.text = value.prescriptionDetail!.drug!.name ?? "";
      quantityController.text =
          value.prescriptionDetail!.quantity.toString() == "null"
              ? ""
              : value.prescriptionDetail!.quantity.toString();
      selection =
          (Symbols.pill, value.prescriptionDetail!.drug!.unit ?? "Viên");
      PrescriptionDetailModel model = PrescriptionDetailModel();
      return SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                  child: SvgPicture.asset(
                      'assets/images/undraw_add_information.svg', height: 125,)),
              const SizedBox(height: 20),
              Center(
                child: Text("Thuốc của bạn là gì?",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.displaySmall),
              ),
              TextField(
                controller: nameController,
                decoration:
                    InputDecoration(label: const Text("Nhập tên thuốc")),
                onChanged: (val) {
                  value.prescriptionDetail!.drug!.name = nameController.text;
                  value.checkIsDrugValid();
                },
              ),
              const SizedBox(height: 20),
              const Text("Đơn vị"),
              DropdownButton<(IconData, String)>(
                  isExpanded: true,
                  value: selection,
                  items: options,
                  onChanged: (i) {
                    value.prescriptionDetail!.drug!.unit = i!.$2;
                    setState(() {
                      selection = i;
                    });
                    value.checkIsDrugValid();
                  }),
              TextField(
                controller: quantityController,
                decoration: const InputDecoration(
                    label: Text("Nhập số lượng thuốc bạn đang có")),
                keyboardType: const TextInputType.numberWithOptions(
                    decimal: false, signed: false),
                onChanged: (v) {
                  value.prescriptionDetail!.quantity =
                      int.tryParse(quantityController.text);

                  value.checkIsDrugValid();
                },
              ),
              const SizedBox(height: 20),
              const Text("Toa thuốc"),
              const SizedBox(height: 20),
              PrescriptionItem(model: value.prescriptionModel!),
            ],
          ),
        ),
      );
    });
  }
}
