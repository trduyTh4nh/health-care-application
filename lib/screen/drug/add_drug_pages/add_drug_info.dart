import 'package:app_well_mate/components/prescription_item.dart';
import 'package:app_well_mate/model/drug_model.dart';
import 'package:app_well_mate/providers/add_page_provider.dart';
import 'package:app_well_mate/screen/drug/add_drug_pages/components/add_drug_item.dart';
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
  List<DrugModel> lst = [];
  TextEditingController nameController = TextEditingController(),
      quantityController = TextEditingController();
  DrugModel? current;
  @override
  void initState() {
    lst = List.generate(
        10,
        (e) => DrugModel(
              idDrug: e,
              idBrand: 0,
              idDrugCate: 0,
              name: "Paracetamol",
              unit: "Viên",
            ));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Consumer<AddPageProvider>(builder: (context, value, child) {
            return CustomScrollView(slivers: [
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                          child: SvgPicture.asset(
                        'assets/images/undraw_add_information.svg',
                        height: 125,
                      )),
                      const SizedBox(height: 20),
                      Center(
                        child: Text("Vui lòng chọn thuốc của bạn",
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.displaySmall),
                      ),
                    ],
                  ),
                ),
              ),
              SliverPadding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                sliver: SliverList.separated(
                    itemCount: lst.length,
                    itemBuilder: (context, index) => AddDrugItem(
                          drug: lst[index],
                          selected: value.prescriptionDetail!.drug!.idDrug ==
                              lst[index].idDrug,
                          onClick: () {
                            setState(() {
                              value.prescriptionDetail!.drug = lst[index];
                            });
                          },
                        ),
                    separatorBuilder: (c, i) => const SizedBox(
                          height: 16,
                        )),
              )
            ]);
          }),
        ),
        Consumer<AddPageProvider>(builder: (context, value, child) {
          quantityController.text = value.prescriptionDetail!.quantity == null
              ? ""
              : value.prescriptionDetail!.quantity.toString();
          return value.prescriptionDetail!.drug!.idDrug != null
              ? Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: TextField(
                    controller: quantityController,
                    onChanged: (v) {
                      int? quantity = int.tryParse(quantityController.text);
                      if (quantity != null) {
                        value.prescriptionDetail!.quantity = quantity;
                      } else {
                        quantityController.text = quantityController.text == ""
                            ? ""
                            : value.prescriptionDetail!.quantity.toString();
                      }
                      if (quantityController.text == "") {
                        value.prescriptionDetail!.quantity = null;
                      }
                      value.checkIsDrugValid();
                    },
                    decoration: const InputDecoration(label: Text("Số lượng")),
                  ),
                )
              : const SizedBox();
        })
      ],
    );
  }
}
