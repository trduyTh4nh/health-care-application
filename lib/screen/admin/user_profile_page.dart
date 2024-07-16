import 'package:app_well_mate/components/item_prescription_of_infomation_user.dart';
import 'package:app_well_mate/main.dart';
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
    return Stack(
      children: [
        Positioned.fill(
          child: Container(
            color: colorScheme.surface,
          ),
        ),
        Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xff6a94ff),
              Colors.white,
            ],
          )),
          height: MediaQuery.of(context).size.height * 1 / 2,
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
              backgroundColor: colorScheme.surface.withAlpha(100),
              title: const Text(
                "Thông tin người dùng",
              )),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Center(
                    child: Hero(
                      tag: "01",
                      child: CircleAvatar(
                        radius: 50,
                        backgroundImage: NetworkImage(
                            'https://i.giphy.com/BSx6mzbW1ew7K.webp'),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
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
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        Text(
                          "11-06-2024",
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Mã người dùng:",
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      Text(
                        "000043",
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 5),
                    child: Divider(),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 13, vertical: 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Padding(padding: EdgeInsets.all(2)),
                        Text(
                          "Thông tin cơ bản",
                          style: Theme.of(context).textTheme.titleLarge,
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
                                  style:
                                      Theme.of(context).textTheme.titleMedium),
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
                        const SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Icon(Symbols.monitor_weight),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text("Cân nặng: "),
                                      Text(" 65kg")
                                    ],
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    children: [
                                      Icon(Symbols.height),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text("Chiều cao: "),
                                      Text("165kg")
                                    ],
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Text("BMI: ",
                                      style: Theme.of(context)
                                          .textTheme
                                          .displaySmall),
                                  Text(" 23.9",
                                      style: Theme.of(context)
                                          .textTheme
                                          .displaySmall)
                                ],
                              ),
                            ],
                          ),
                        ),
                        const Padding(
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
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          child: Container(
                            child: const Row(
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
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 15),
                          child: Row(
                            children: [
                              Icon(Symbols.calendar_month),
                              SizedBox(
                                width: 10,
                              ),
                              Text("Ngày khám trước đó: "),
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
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
