import 'package:app_well_mate/api/application/application_repo.dart';
import 'package:app_well_mate/components/prescription_item.dart';
import 'package:app_well_mate/main.dart';
import 'package:app_well_mate/model/drug_model.dart';
import 'package:app_well_mate/model/prescription_model.dart';
import 'package:app_well_mate/providers/add_page_provider.dart';
import 'package:app_well_mate/screen/drug/add_drug_pages/components/add_drug_item.dart';
import 'package:app_well_mate/utils/app.colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:provider/provider.dart';

class AddDrugInfoPage extends StatefulWidget {
  const AddDrugInfoPage({super.key});
  @override
  State<AddDrugInfoPage> createState() => _AddDrugInfoPageState();
}

class _AddDrugInfoPageState extends State<AddDrugInfoPage> {
  TextEditingController nameController = TextEditingController(),
      quantityController = TextEditingController();
  DrugModel? current;
  ApplicationRepo repo = ApplicationRepo();
  TextEditingController controller = TextEditingController();
  List<PrescriptionModel>? lst = [];
  getApplications() async {
    lst = await repo.getPrescription();
  }

  @override
  void initState() {
    applicationFuture = getApplications();
    super.initState();
  }

  Future<void>? applicationFuture;
  Future<void>? future;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Consumer<AddPageProvider>(builder: (context, value, child) {
            if (value.drugModelList.isEmpty) {
              future = value.fetchModelList();
            }
            controller.text = value.searchQuery;
            return FutureBuilder(
                future: future,
                builder: (context, snapshot) {
                  bool isLoading =
                      snapshot.connectionState == ConnectionState.waiting;
                  return CustomScrollView(slivers: [
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(
                                child: Icon(
                              Symbols.pill,
                              size: 32,
                              color: colorScheme.primary,
                            )),
                            Center(
                              child: Text("Vui lòng chọn thuốc của bạn",
                                  textAlign: TextAlign.center,
                                  style:
                                      Theme.of(context).textTheme.displaySmall),
                            ),
                            TextField(
                              onEditingComplete: () {
                                future = value.searchDrug(controller.text);
                                setState(() {});
                                value.searchQuery = controller.text;
                              },
                              controller: controller,
                              decoration: InputDecoration(
                                  label: const Text("Tìm kiếm"),
                                  suffixIcon: IconButton(
                                      onPressed: () {},
                                      icon: const Icon(Icons.search))),
                            )
                          ],
                        ),
                      ),
                    ),
                    SliverPadding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 16),
                      sliver: SliverList.separated(
                          itemCount: isLoading ? 1 : value.drugModelList.length,
                          itemBuilder: (context, index) => !isLoading
                              ? AddDrugItem(
                                  drug: value.drugModelList[index],
                                  selected:
                                      value.prescriptionDetail!.drug!.idDrug ==
                                          value.drugModelList[index].idDrug,
                                  onClick: () {
                                    setState(() {
                                      value.prescriptionDetail!.drug =
                                          value.drugModelList[index];
                                    });
                                  },
                                )
                              : Center(
                                  child: LoadingAnimationWidget.flickr(
                                  leftDotColor: colorScheme.primary,
                                  rightDotColor: colorScheme.error,
                                  size: 24,
                                )),
                          separatorBuilder: (c, i) => const SizedBox(
                                height: 16,
                              )),
                    )
                  ]);
                });
          }),
        ),
        Consumer<AddPageProvider>(builder: (context, value, child) {
          quantityController.text = value.prescriptionDetail!.quantity == null
              ? ""
              : value.prescriptionDetail!.quantity.toString();
          return value.prescriptionDetail!.drug!.idDrug != null
              ? Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
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
        }),
        const SizedBox(
          height: 10,
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Text("Đơn thuốc"),
        ),
        const SizedBox(
          height: 10,
        ),
        Consumer<AddPageProvider>(builder: (context, value, child) {
          if (value.preList.isEmpty) {
            applicationFuture = value.fetchApplication();
          }
          return FutureBuilder(
              future: applicationFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done &&
                    value.prescriptionModel == null) {
                  value.prescriptionModel = value.preList[0];
                }
                return Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: Material(
                    color: AppColors.greyColor,
                    borderRadius: BorderRadius.circular(16),
                    child: DropdownButton(
                        hint: SizedBox(
                          width: 20,
                          height: 20,
                          child: LoadingAnimationWidget.flickr(
                            leftDotColor: colorScheme.primary,
                            rightDotColor: colorScheme.error,
                            size: 48,
                          ),
                        ),
                        borderRadius: BorderRadius.circular(16),
                        icon: const Icon(Icons.keyboard_arrow_down_rounded),
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        underline: const SizedBox(),
                        isExpanded: true,
                        value: value.prescriptionModel,
                        items: value.preList
                            .map((e) => DropdownMenuItem(
                                value: e,
                                child: Row(
                                  children: [
                                    const Icon(Icons.receipt_long),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Expanded(
                                        child: Text(
                                            "Bác sĩ ${e.doctorName} ngày ${DateFormat("dd/MM/yyyy").format(e.createdDate!)}"))
                                  ],
                                )))
                            .toList(),
                        onChanged: (v) {
                          setState(() {
                            value.prescriptionModel = v;
                          });
                        }),
                  ),
                );
              });
        }),
      ],
    );
  }
}
