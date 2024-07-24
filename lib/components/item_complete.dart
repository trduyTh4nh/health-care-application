import 'package:app_well_mate/model/drug_cart_detail_model.dart';
import 'package:app_well_mate/utils/util.dart';
import 'package:flutter/material.dart';

class item_complete extends StatelessWidget {
  item_complete({super.key, required this.drug});
  DrugCartDetailModel drug;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Image.network(
              errorBuilder: (context, error, stackTrace) =>
                  const Icon(Icons.image),
              // drug!.drugImage ?? '',
              drug.drug!.drugImage ?? '',
              width: 50,
              height: 50,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 2 / 3,
                    child: Text(drug.drug!.name!,
                        style: Theme.of(context).textTheme.bodyLarge),
                  ),
                  Text(
                      "${drug.quantity} ${drug.drug!.unit}_ ${convertCurrency(drug.drug!.price)}/ ${drug.drug!.unit}",
                      style: Theme.of(context).textTheme.labelSmall),
                  Text(convertCurrency(drug.drug!.price!),
                      style: Theme.of(context).textTheme.titleMedium),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
