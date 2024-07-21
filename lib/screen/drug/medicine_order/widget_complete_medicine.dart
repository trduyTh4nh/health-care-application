import 'package:app_well_mate/model/drug_cart_detail_model.dart';
import 'package:app_well_mate/providers/cart_page_provider.dart';
import 'package:app_well_mate/utils/util.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

enum MedicationItemAction { delete, edit, snooze, buy, confirm }

class WidgetCompleteMedicine extends StatefulWidget {
  const WidgetCompleteMedicine({super.key});

  @override
  State<WidgetCompleteMedicine> createState() => _WidgetCompleteMedicine();
}

class _WidgetCompleteMedicine extends State<WidgetCompleteMedicine> {
  bool isChecked = false;
  @override
  Widget build(BuildContext context) {
    final sizeHeight = MediaQuery.of(context).size.height;

    return Consumer<CartPageProvider>(builder: (context, value, child) {
      return Scaffold(
        body: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        children: [
                          SizedBox(
                              width: 24,
                              height: 24,
                              child: CircularProgressIndicator()),
                          const SizedBox(
                            width: 15,
                          ),
                          Expanded(
                            child: SizedBox(
                              width: double.infinity,
                              child: Text(
                                "Đơn thuốc đang được chuẩn bị bởi nhà thuốc",
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge!
                                    .copyWith(fontSize: 24),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Consumer<CartPageProvider>(
                        builder: (context, value, child) {
                      return SizedBox(
                        height: sizeHeight * 0.40,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: ListView.builder(
                            itemCount: value.listChecked.length,
                            itemBuilder: (context, index) {
                              var item = value.listChecked[index];
                              return Column(
                                children: [
                                  item_complete(drug: item),
                                  const Divider(),
                                ],
                              );
                            },
                          ),
                        ),
                      );
                    }),
                  ],
                ),
              ),
            ),
            Material(
              elevation: 50,
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(top: 15),
                      child: Text("Phương thức thanh toán"),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(25),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(25),
                                child: Image.network(
                                    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSGxsoe7iPccCnGraliGFCLCvbg3bO3PDtELQ&s"),
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Visa",
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium),
                                Text("******12"),
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
                    Text("Địa chỉ giao hàng"),
                    Text(
                      value.selectedAddress!.address!,
                      style: Theme.of(context).textTheme.titleMedium,
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      );
    });
  }
}

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
                  Text(drug.drug!.name!,
                      style: Theme.of(context).textTheme.bodyLarge),
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
