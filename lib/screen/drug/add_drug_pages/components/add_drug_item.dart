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
        onLongPress: () {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(widget.drug.name ?? "Không có tên")));
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
          child: Row(
            children: [
              SizedBox(
                width: 36,
                height: 36,
                child: CircleAvatar(
                  backgroundColor: colorScheme.surface,
                  backgroundImage: NetworkImage(widget.drug.drugImage ?? ""),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            overflow: TextOverflow.ellipsis,
                            widget.drug.name!,
                            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                                color: widget.selected
                                    ? colorScheme.onPrimary
                                    : colorScheme.onSurface),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      widget.drug.unit!,
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: widget.selected
                              ? colorScheme.onPrimary
                              : colorScheme.onSurface),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
