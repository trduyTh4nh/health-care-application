import 'package:app_well_mate/main.dart';
import 'package:app_well_mate/model/drug_model.dart';
import 'package:app_well_mate/utils/app.colors.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

class AddDrugItem extends StatefulWidget {
  const AddDrugItem(
      {super.key, required this.drug, this.selected = false, this.onClick});
  final DrugModel drug;
  final bool selected;
  final Function()? onClick;
  @override
  State<AddDrugItem> createState() => _AddDrugItemState();
}

class _AddDrugItemState extends State<AddDrugItem> {
  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(16),
      color: widget.selected ? colorScheme.primary : AppColors.greyColor,
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: widget.onClick ?? () {},
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
          child: Row(
            children: [
              Container(
                decoration: BoxDecoration(
                    color: colorScheme.primary,
                    borderRadius: const BorderRadius.all(Radius.circular(50))),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Icon(Symbols.pill, color: colorScheme.surface),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.drug.name!,
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: widget.selected
                            ? colorScheme.onPrimary
                            : colorScheme.onSurface),
                  ),
                  Text(
                    widget.drug.unit!,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: widget.selected
                            ? colorScheme.onPrimary
                            : colorScheme.onSurface),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
