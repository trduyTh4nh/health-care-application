import 'package:app_well_mate/main.dart';
import 'package:app_well_mate/screen/drug_cart.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

enum MedicationItemAction { delete, edit, snooze, buy, confirm }

class WidgetPrescriptionstatusCancelMedicine extends StatefulWidget {
  const WidgetPrescriptionstatusCancelMedicine({super.key});

  @override
  State<WidgetPrescriptionstatusCancelMedicine> createState() =>
      _WidgetPrescriptionstatusCancelMedicine();
}

class _WidgetPrescriptionstatusCancelMedicine
    extends State<WidgetPrescriptionstatusCancelMedicine> {
  bool isChecked = false;
  @override
  Widget build(BuildContext context) {
    final sizeHeight = MediaQuery.of(context).size.height;
    final sizeWight = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Tình trạng đơn thuốc"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Icon(Icons.ac_unit_outlined),
                SizedBox(
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
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: ListView.builder(
                itemCount: 10,
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
                                        Text("3 vỉ _ 8.000 đ / vỉ",
                                            style: Theme.of(context)
                                                .textTheme
                                                .labelSmall),
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
          ),
          Container(
            decoration: BoxDecoration(color: Colors.white, boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.4),
                blurRadius: 7,
                offset: const Offset(0, -5),
              )
            ]),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 20,
                horizontal: 16,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Phương thức thanh toán"),
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
                                  style:
                                      Theme.of(context).textTheme.titleMedium),
                              Text("******12"),
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                  Text("Địa chỉ giao hàng"),
                  Container(
                    width: double.infinity,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: sizeWight * 1.9 / 3,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "100 đường Example, Thành phố Hồ Chí Minh, Việt Nam",
                                    style:
                                        Theme.of(context).textTheme.titleMedium,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Text(
                    "Tổng tiền",
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                  Text(
                    "505.000" " Đ",
                    style: Theme.of(context).textTheme.displayMedium,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor:
                                    WidgetStateProperty.all(colorScheme.error)),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => CartPage()));
                            },
                            child: Text("Hủy đơn thuốc- KHÔNG HOÀN TIỀN")),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}



// Expanded(
//                     child: ElevatedButton(
//                         style: ButtonStyle(
//                             backgroundColor:
//                                 WidgetStateProperty.all(colorScheme.error)),
//                         onPressed: () {
//                           Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                   builder: (context) => CartPage()));
//                         },
//                         child: Text("Hủy đơn thuốc- KHÔNG HOÀN TIỀN")),
//                   ),