import 'package:app_well_mate/main.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

enum MedicationItemAction { delete, edit, snooze, buy, confirm }

class WidgetPaymentMedicine extends StatefulWidget {
  const WidgetPaymentMedicine({super.key});

  @override
  State<WidgetPaymentMedicine> createState() => _WidgetPaymentMedicine();
}

class _WidgetPaymentMedicine extends State<WidgetPaymentMedicine> {
  String paymentMethod = 'Momo';
  String? diaChi;
  final _userName = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final sizeWight = MediaQuery.of(context).size.width;
    final sizeHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Phương thức thanh toán"),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Radio(
                        value: "Visa",
                        groupValue: paymentMethod,
                        onChanged: (value) {
                          setState(() {
                            paymentMethod = value!;
                          });
                        },
                      ),
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
                              style: Theme.of(context).textTheme.titleMedium),
                          const Text("******12"),
                        ],
                      )
                    ],
                  ),
                  PopupMenuButton(
                    style: Theme.of(context).iconButtonTheme.style,
                    itemBuilder: (context) => const [
                      PopupMenuItem(
                          value: MedicationItemAction.delete,
                          child: ListTile(
                              leading: Icon(Symbols.delete),
                              title: Text("Xoá thẻ ngân hàng  này"))),
                    ],
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: InkWell(
                  onTap: () {
                    showModalBottomSheet(
                      isScrollControlled: true,
                      backgroundColor: Colors.white,
                      context: context,
                      builder: (context) {
                        // return showBottomSheet(sizeHeight: sizeHeight);
                        return SingleChildScrollView(
                          child: Padding(
                            padding: EdgeInsets.only(
                              bottom: MediaQuery.of(context).viewInsets.bottom,
                              left: 12,
                              right: 12,
                              top: 12,
                            ),
                            child: Container(
                              height: 0.5 * sizeHeight,
                              child: SingleChildScrollView(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Center(
                                        child: Text(
                                          "Thêm thẻ",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyLarge,
                                        ),
                                      ),
                                      const Text("Thông tin liên hệ"),
                                      // SizedBox(
                                      //   height: 20,
                                      // ),
                                      Column(
                                        children: [
                                          TextFormField(
                                            controller: _userName,
                                            decoration: InputDecoration(
                                              labelText: "Tên thẻ ngân hàng",
                                            ),
                                          ),
                                          TextField(
                                            decoration: InputDecoration(
                                                labelText: "Số thẻ ngân hàng"),
                                          ),
                                          Row(
                                            children: [
                                              Expanded(
                                                flex: 3,
                                                child: TextField(
                                                  decoration: InputDecoration(
                                                      labelText:
                                                          "Ngày hết hạn(MM/YY)"),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 20,
                                              ),
                                              Expanded(
                                                flex: 1,
                                                child: TextField(
                                                  decoration: InputDecoration(
                                                      labelText: "Mã CVV"),
                                                ),
                                              )
                                            ],
                                          )
                                        ],
                                      ),

                                      SizedBox(
                                        height: 12,
                                      ),
                                      SizedBox(
                                        width: double.infinity,
                                        child: ElevatedButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: const Text("Xong"),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                  child: Row(
                    children: [
                      Icon(Icons.add),
                      Text("Thêm thẻ ngân hàng",
                          style: Theme.of(context).textTheme.titleMedium),
                    ],
                  ),
                ),
              ),
              Text("Địa chỉ giao hàng"),
              Container(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [SwitchExample(), Text("Giao hàng tận nơi")],
                  )
                ],
              )),
              Container(
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Radio<String>(
                          value: "Diachi1",
                          groupValue: diaChi,
                          onChanged: (String? value) {
                            setState(() {
                              diaChi = value!;
                              // if (value == diaChi) {
                              //   diaChi = null;
                              // } else {
                              //   diaChi = value;
                              // }
                            });
                          },
                        ),
                        Container(
                          width: sizeWight * 1.8 / 3,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "100 đường Example, Thành phố Hồ Chí Minh, Việt Nam",
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                              Text("Địa chỉ 1"),
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
                                title: Text("Xoá địa chỉ này"))),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15),
                child: InkWell(
                  onTap: () {
                    showModalBottomSheet(
                      isScrollControlled: true,
                      backgroundColor: Colors.white,
                      context: context,
                      builder: (context) {
                        // return showBottomSheet(sizeHeight: sizeHeight);
                        return SingleChildScrollView(
                          child: Padding(
                            padding: EdgeInsets.only(
                              bottom: MediaQuery.of(context).viewInsets.bottom,
                              left: 12,
                              right: 12,
                              top: 12,
                            ),
                            child: Container(
                              height: 0.51 * sizeHeight,
                              child: SingleChildScrollView(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Center(
                                        child: Text(
                                          "Thêm địa chỉ mới",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyLarge,
                                        ),
                                      ),
                                      const Text("Thông tin liên hệ"),
                                      // SizedBox(
                                      //   height: 20,
                                      // ),
                                      Column(
                                        children: [
                                          TextFormField(
                                            controller: _userName,
                                            decoration: InputDecoration(
                                              labelText: "Họ và tên",
                                            ),
                                          ),
                                          TextField(
                                            decoration: InputDecoration(
                                                labelText: "Số điện thoại"),
                                          )
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      Text("Thông tin địa chỉ"),
                                      TextFormField(
                                        decoration: InputDecoration(
                                            labelText:
                                                "Tỉnh/Thành phố, Quận/Huyện, Phường/Xã"),
                                      ),
                                      TextFormField(
                                        decoration: InputDecoration(
                                            labelText:
                                                "Tên đường, Tòa nhà, Số nhà"),
                                      ),
                                      SizedBox(
                                        height: 12,
                                      ),
                                      Text("Đặt làm mặc định"),
                                      SwitchExample(),
                                      SizedBox(
                                        height: 12,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(18.0),
                                        child: SizedBox(
                                          width: double.infinity,
                                          child: ElevatedButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: const Text("Xong"),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                  child: Row(
                    children: [
                      Icon(Icons.add),
                      Text("Thêm địa chỉ giao hàng",
                          style: Theme.of(context).textTheme.titleMedium),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SwitchExample extends StatefulWidget {
  const SwitchExample({super.key});

  @override
  State<SwitchExample> createState() => _SwitchExampleState();
}

class _SwitchExampleState extends State<SwitchExample> {
  bool light = true;

  @override
  Widget build(BuildContext context) {
    return Switch(
      // This bool value toggles the switch.
      value: light,
      activeColor: colorScheme.primary,
      onChanged: (bool value) {
        // This is called when the user toggles the switch.
        setState(() {
          light = value;
        });
      },
    );
  }
}
