import 'package:app_well_mate/main.dart';
import 'package:app_well_mate/providers/add_page_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:provider/provider.dart';

class AddDrugPageDosage extends StatefulWidget {
  const AddDrugPageDosage({super.key});

  @override
  State<AddDrugPageDosage> createState() => _AddDrugPageDosageState();
}

class _AddDrugPageDosageState extends State<AddDrugPageDosage> {
  List<int> dosages = [1, 2, 3, 4];
  int selectedDosage = 1;
  final TextEditingController customValueController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Consumer<AddPageProvider>(
      builder: (context, value, child) {
        int? quantityToUse = -1;
        if (value.prescriptionDetail!.amountPerConsumption != null) {
          quantityToUse =
              value.prescriptionDetail!.amountPerConsumption!.toInt();
          selectedDosage = quantityToUse;
        }
        customValueController.text =
            quantityToUse == -1 ? "" : quantityToUse.toString();
        return CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                children: [
                  Center(
                      child: SvgPicture.asset(
                    'assets/images/undraw_completing.svg',
                    height: 125,
                  )),
                  const SizedBox(height: 20),
                  Center(
                    child: Text(
                        "Bạn uống bao nhiêu ${value.prescriptionDetail!.drug!.unit} '${value.prescriptionDetail!.drug!.name}' 1 lần?",
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.displaySmall),
                  ),
                  SizedBox(height: 20)
                ],
              ),
            ),
            SliverList.separated(
                separatorBuilder: (context, index) => Divider(
                      indent: 20,
                      endIndent: 20,
                    ),
                itemCount: dosages.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Material(
                      borderRadius: const BorderRadius.all(Radius.circular(16)),
                      color: index == dosages.indexOf(selectedDosage)
                          ? colorScheme.primary
                          : null,
                      child: InkWell(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(16)),
                        onTap: () {
                          setState(() {
                            selectedDosage = dosages[index];
                            value.prescriptionDetail!.amountPerConsumption =
                                selectedDosage;
                            if (value
                                    .prescriptionDetail!.amountPerConsumption ==
                                -1) {
                              value.isValid = false;
                            } else {
                              value.isValid = true;
                            }
                          });
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 15),
                          child: Row(
                            children: [
                              Icon(
                                Symbols.alarm,
                                color: index == dosages.indexOf(selectedDosage)
                                    ? colorScheme.surface
                                    : colorScheme.onSurface,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                dosages[index] == 0
                                    ? "Tự định nghĩa"
                                    : "${dosages[index]} ${value.prescriptionDetail!.drug!.unit} 1 Lần",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                        color: index ==
                                                dosages.indexOf(selectedDosage)
                                            ? colorScheme.surface
                                            : colorScheme.onSurface),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                }),
            SliverToBoxAdapter(
              child: Column(
                children: [
                  const Divider(
                    indent: 20,
                    endIndent: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        const Text("Tự định nghĩa"),
                        TextField(
                          controller: customValueController,
                          decoration:
                              const InputDecoration(label: Text("Số lượng")),
                          onChanged: (val) {
                            setState(() {});
                            value.prescriptionDetail!.amountPerConsumption =
                                (int.tryParse(customValueController.text) ??
                                    -1);
                            if (value
                                    .prescriptionDetail!.amountPerConsumption ==
                                -1) {
                              value.isValid = false;
                            } else {
                              value.isValid = true;
                            }
                          },
                        ),
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        );
      },
    );
  }
}
