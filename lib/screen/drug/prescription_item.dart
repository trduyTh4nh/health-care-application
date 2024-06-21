import 'package:app_well_mate/utils/app.colors.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

class PrescriptionItem extends StatefulWidget {
  const PrescriptionItem({super.key, required this.idPresciption});
  final int idPresciption;
  @override
  State<PrescriptionItem> createState() => _PrescriptionItemState();
}

class _PrescriptionItemState extends State<PrescriptionItem> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4),
      child: InkWell(
        onTap: () {},
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  border: Border.all(width: 1, color: AppColors.primaryColor)),
              child: const Icon(
                Symbols.playlist_add_check,
                color: AppColors.primaryColor,
              ),
            ),
            const SizedBox(
              width: 6,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Đơn ngày 27/3/2023',
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    fontWeight: FontWeight.bold
                  ),
                ),
                const SizedBox(
                  height: 2,
                ),
                Text(
                  'Bệnh viện trung tâm',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(
                  height: 2,
                ),
                Text(
                  '4 giờ trước',
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall!
                      .copyWith(fontWeight: FontWeight.bold, fontSize: 14),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
