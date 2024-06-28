import 'package:app_well_mate/main.dart';
import 'package:app_well_mate/model/prescription_model.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

class PrescriptionItem extends StatelessWidget {
  const PrescriptionItem({super.key, required this.model});
  final PrescriptionModel model;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          decoration: BoxDecoration(
              border: Border.all(color: colorScheme.primary, width: 2),
              borderRadius: const BorderRadius.all(Radius.circular(50))),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Icon(Symbols.playlist_add_check, color: colorScheme.primary),
          ),
        ),
        const SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Đơn ngày ${model.createdDate!.day.toString().padLeft(2, '0')}/${model.createdDate!.month.toString().padLeft(2, '0')}/${model.createdDate!.year}",
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            Text(model.hospital!.name ?? "")
          ],
        )
      ],
    );
  }
}
