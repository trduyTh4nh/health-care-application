import 'package:app_well_mate/const/color_scheme.dart';
import 'package:app_well_mate/main.dart';
import 'package:app_well_mate/screen/drug/medicine_order/widget_prescriptionstatus_cancel_medicine.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

class TransactionDetail extends StatelessWidget {
  const TransactionDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(""),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                Container(
                  height: 120,
                  width: 120,
                  decoration: BoxDecoration(
                    color: colorScheme.primary,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.attach_money,
                    color: Colors.white,
                    size: 54,
                  ),
                ),
                Text(
                  "Giao dịch",
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.calendar_month),
                    const SizedBox(
                      width: 12,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      child: Text(
                        "30/06/2023 13:45",
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    )
                  ],
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.check),
                        SizedBox(
                          width: 5,
                        ),
                        Text("Thành công"),
                      ],
                    ),
                    SizedBox(
                      width: 13,
                    ),
                    Row(
                      children: [
                        Icon(Icons.credit_card),
                        SizedBox(
                          width: 5,
                        ),
                        Text("Thẻ tín dụng"),
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                const Text("505.000 VND")
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Text("Đơn mua",
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        fontSize: 18,
                      )),
            ),
            Row(
              children: [
                Container(
                  height: 46,
                  width: 46,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, color: AppColor.gray),
                  child: const Icon(Icons.receipt_long),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Đơn thuốc ngày 20-05-2024",
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge!
                            .copyWith(fontSize: 16),
                      ),
                      Text(
                        "5 thuốc",
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      Text(
                        "505.000đ",
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Symbols.deployed_code_history),
                      iconSize: 24,
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (c) => const WidgetPrescriptionstatusCancelMedicine()));
                      },
                      icon: const Icon(Symbols.arrow_right_alt),
                      iconSize: 24,
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
