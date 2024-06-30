import 'package:app_well_mate/main.dart';
import 'package:app_well_mate/screen/edit_infomation_user.dart';
import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:app_well_mate/screen/profile.dart';
import 'package:app_well_mate/screen/edit_infomation_user.dart';

class UserInformation extends StatefulWidget {
  const UserInformation({super.key});

  @override
  State<UserInformation> createState() => _UserInformationState();
}

class _UserInformationState extends State<UserInformation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Thông tin người dùng",
            style: Theme.of(context).textTheme.titleMedium),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(bottom: 16),
        child: Padding(

          padding: EdgeInsets.all(10),

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
                  "Nguyễn Duy",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              Row(
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
              const SizedBox(
                height: 16,
              ),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                        style: ButtonStyle(
                                backgroundColor: WidgetStateProperty.all(
                                    colorScheme.surfaceDim))
                            .copyWith(),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => EditInfomationUser()));
                        },
                        child: const Text(
                          "Chỉnh sửa thông tin cá nhân",
                          style: TextStyle(color: Colors.black),
                        )),
                  ),
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              Align(
                alignment: Alignment.centerLeft, // Căn bên trái
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Padding(padding: EdgeInsets.all(5)),
                    Text(
                      "Thông tin toa thuốc & thuốc",
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Row(
                      children: [
                        Icon(Symbols.pill),
                        SizedBox(
                          width: 10,
                        ),
                        Text("Có tổng cộng "),
                        Text(
                          " 116",
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        Text(" thuốc trong "),
                        Text("10",
                            style: Theme.of(context).textTheme.titleMedium),
                        Text(" toa")
                      ],
                    ),
                    SizedBox(
                      height: 10,

                    ),
                    Row(
                      children: [
                        Icon(Symbols.pill),
                        SizedBox(
                          width: 10,
                        ),
                        Text("Đã mua "),
                        Text(" 116 ",
                            style: Theme.of(context).textTheme.titleMedium),
                        Text(" thuốc"),
                        Text(" (13.194.131 VND)"),
                      ],
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Text(
                      "Thông tin cá nhân",
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    const Row(
                      children: [
                        Icon(Symbols.phone),
                        SizedBox(
                          width: 10,
                        ),
                        Text("SĐT: "),
                        Text("0908291416")
                      ],
                    ),
                    const SizedBox(
                      height: 16,
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
                      height: 16,
                    ),
                    Row(
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
                              height: 16,
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
                        const SizedBox(
                          width: 10,
                        ),
                        Row(
                          children: [
                            Text("BMI: 23.9",
                                style:
                                    Theme.of(context).textTheme.displaySmall),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    const Row(
                      children: [
                        Icon(Symbols.cake),
                        SizedBox(
                          width: 10,
                        ),
                        Text("Ngày sinh: "),
                        Text("28-08-2003 (18 tuổi)"),
                      ],
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    const Row(
                      children: [
                        Icon(Symbols.corporate_fare),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                            child: Text(
                                "Địa chỉ: 84 Thành Thái, Phường 10, Quận 10, TP. Hồ Chí Minh")),
                      ],
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    const Row(
                      children: [
                        Icon(Symbols.calendar_month),
                        SizedBox(
                          width: 10,
                        ),
                        Text("Ngày khám trước đó: "),
                        Text("11/06/2024")
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
