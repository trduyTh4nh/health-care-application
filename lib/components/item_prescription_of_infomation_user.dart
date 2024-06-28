import 'package:app_well_mate/main.dart';
import 'package:flutter/material.dart';

class ItemPrescriptionOfInfomationUser extends StatelessWidget {
  const ItemPrescriptionOfInfomationUser({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    String date = "27/03/2022";

    return Column(
      children: [
        Row(
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: colorScheme.primary,
                    width: 2,
                  )),
              child: Icon(
                Icons.playlist_add_check,
                color: colorScheme.primary,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Đơn ngày ${date}",
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
                Text("Bệnh viện trung tâm"),
              ],
            )
          ],
        ),
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 12),
          child: Divider(),
        )
      ],
    );
  }
}
