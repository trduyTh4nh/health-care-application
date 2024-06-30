import 'package:app_well_mate/components/item_prescription_of_infomation_user.dart';
import 'package:flutter/material.dart';

import 'package:material_symbols_icons/symbols.dart';

class UserProfilePage extends StatefulWidget {
  const UserProfilePage({super.key});

  @override
  State<UserProfilePage> createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
        "Thông tin người dùng",
      )),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Center(
                child: Hero(
                  tag: "01",
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage:
                        NetworkImage('https://i.giphy.com/BSx6mzbW1ew7K.webp'),
                  ),
                ),
              ),
              Hero(
                tag: "02",
                child: Text(
                  "Nguyễn Thành Duy",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Đăng ký ngày ",
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    Text(
                      "11-06-2024",
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Mã người dùng:",
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  Text(
                    "000043",
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15),
                child: const Divider(),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Padding(padding: EdgeInsets.all(5)),
                  Text(
                    "Thông tin cơ bản",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    child: Row(
                      children: [
                        const Icon(Symbols.pill),
                        const SizedBox(
                          width: 10,
                        ),
                        const Text("Đã mua "),
                        Text(" 115 ",
                            style: Theme.of(context).textTheme.titleMedium),
                        const Text(" thuốc"),
                        const Text(" (13.194.131 VND)"),
                      ],
                    ),
                  ),
                  const Row(
                    children: [
                      Icon(Symbols.email),
                      SizedBox(
                        width: 10,
                      ),
                      Text("Email: "),
                      Text("thanhduy69@gmail.com")
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const Icon(Symbols.monitor_weight),
                                SizedBox(
                                  width: 10,
                                ),
                                const Text("Cân nặng: "),
                                Text(" 65kg")
                              ],
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Row(
                              children: [
                                const Icon(Symbols.height),
                                SizedBox(
                                  width: 10,
                                ),
                                const Text("Chiều cao: "),
                                Text("165kg")
                              ],
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text("BMI: ",
                                style:
                                    Theme.of(context).textTheme.displaySmall),
                            Text(" 23.9",
                                style: Theme.of(context).textTheme.displaySmall)
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 15),
                    child: Row(
                      children: [
                        Icon(Symbols.cake),
                        SizedBox(
                          width: 10,
                        ),
                        Text("Ngày sinh: "),
                        Text("28-08-2003 (18 tuổi)"),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 15),
                    child: Container(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(Symbols.corporate_fare),
                          SizedBox(
                            width: 10,
                          ),
                          Text("Địa chỉ:"),
                          Expanded(
                            child: Text(
                              " 84 Thành Thái, Phường 10, Quận 10, TP. Hồ Chí Minh",
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 15),
                    child: Row(
                      children: [
                        const Icon(Symbols.calendar_month),
                        const SizedBox(
                          width: 10,
                        ),
                        const Text("Ngày khám trước đó: "),
                        Text("11/06/2024")
                      ],
                    ),
                  ),
                  Text(
                    "Đơn thuốc",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const ItemPrescriptionOfInfomationUser(),
                  const ItemPrescriptionOfInfomationUser(),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
