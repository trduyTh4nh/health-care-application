import 'package:app_well_mate/screen/drug/medicine_order/widget_complete_medicine.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:app_well_mate/main.dart';

enum MedicationItemAction { delete, edit, snooze, buy, confirm }

class CartMedicines extends StatefulWidget {
  const CartMedicines({super.key});

  @override
  State<CartMedicines> createState() => _CartMedicines();
}

class _CartMedicines extends State<CartMedicines> {
  bool isChecked = false;
  @override
  Widget build(BuildContext context) {
    final sizeHeight = MediaQuery.of(context).size.height;
    final sizeWight = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text("Giỏ hàng"),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: sizeHeight * 0.6,
              child: ListView.builder(
                itemCount: 3,
                itemBuilder: (context, index) {
                  return SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Checkbox(
                                    value: isChecked,
                                    activeColor: Colors.blue,
                                    onChanged: (value) {
                                      setState(() {
                                        isChecked = value!;
                                      });
                                    },
                                  ),
                                  CircleAvatar(
                                    radius: 20,
                                    backgroundImage: NetworkImage(
                                        'https://i.giphy.com/BSx6mzbW1ew7K.webp'),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text("Panadol Extra",
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyLarge),
                                        Text("25.000 đ",
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleMedium),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              PopupMenuButton(
                                style: Theme.of(context).iconButtonTheme.style,
                                itemBuilder: (context) => const [
                                  PopupMenuItem(
                                      value: MedicationItemAction.delete,
                                      child: ListTile(
                                          leading: Icon(Symbols.delete),
                                          title: Text("Xoá thuốc này"))),
                                ],
                              ),
                            ],
                          ),
                          const Divider(),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            Align(
                alignment: Alignment.bottomLeft,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Tổng tiền",
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                      Text(
                        "505.000" " Đ",
                        style: Theme.of(context).textTheme.displaySmall,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              WidgetCompleteMedicine()));
                                },
                                child: Text("Mua thuốc")),
                          ),
                        ],
                      ),
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
