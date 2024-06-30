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
            style: Theme.of(context).textTheme.titleLarge),
        toolbarHeight: 50.0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 16),
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
                    backgroundImage:
                        NetworkImage('https://i.giphy.com/BSx6mzbW1ew7K.webp'),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Hero(
                tag: "02",
                child: Text(
                  "Nguyễn Duy",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
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
              const SizedBox(
                height: 10,
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
                                  builder: (context) =>
                                      const EditInfomationUser()));
                        },
                        child: Text(
                          "Chỉnh sửa thông tin cá nhân",
                          style: Theme.of(context).textTheme.bodyLarge,
                        )),
                  ),
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 13, vertical: 0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Padding(padding: EdgeInsets.all(5)),
                      Text(
                        "Thông tin toa thuốc & thuốc",
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Row(
                        children: [
                          const Icon(Symbols.pill),
                          const SizedBox(
                            width: 10,
                          ),
                          const Text("Có tổng cộng "),
                          Text(
                            " 116",
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          const Text(" thuốc trong "),
                          Text("10",
                              style: Theme.of(context).textTheme.titleMedium),
                          const Text(" toa")
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          const Icon(Symbols.pill),
                          const SizedBox(
                            width: 10,
                          ),
                          const Text("Đã mua "),
                          Text(" 116 ",
                              style: Theme.of(context).textTheme.titleMedium),
                          const Text(" thuốc"),
                          const Text(" (13.194.131 VND)"),
                        ],
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Text(
                        "Thông tin cá nhân",
                        style: Theme.of(context).textTheme.titleLarge,
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
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 1),
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
                            Row(
                              children: [
                                Text(
                                  "BMI: 23.9",
                                  style:
                                      Theme.of(context).textTheme.displaySmall,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ],
                        ),
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
                      const SizedBox(
                        height: 10,
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
