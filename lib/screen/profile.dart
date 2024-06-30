import 'package:app_well_mate/screen/admin/admin_page.dart';
import 'package:app_well_mate/screen/changeRePassword.dart';
import 'package:app_well_mate/screen/drug_manage.dart';
import 'package:app_well_mate/screen/ffmi.dart';
import 'package:app_well_mate/screen/imergencycall.dart';
import 'package:app_well_mate/screen/medicine_purchase_history.dart';
import 'package:app_well_mate/screen/info.dart';
import 'package:app_well_mate/screen/notification.dart';
import 'package:app_well_mate/screen/language.dart';
import 'package:app_well_mate/screen/policy.dart';
import 'package:app_well_mate/screen/quick_action/bmi_page.dart';
import 'package:app_well_mate/screen/revisit_page.dart';
import 'package:app_well_mate/screen/transaction_history.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'login.dart';
import 'package:app_well_mate/screen/user_information.dart';
import 'package:app_well_mate/screen/edit_infomation_user.dart';

class Thongtincanhan extends StatefulWidget {
  const Thongtincanhan({super.key});

  @override
  State<Thongtincanhan> createState() => _ThongtincanhanState();
}

class _ThongtincanhanState extends State<Thongtincanhan> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const UserInformation(),
                  ));
            },
            child: Row(children: [
              Hero(
                tag: "01",
                child: const CircleAvatar(
                  radius: 20,
                  backgroundImage:
                      NetworkImage('https://i.giphy.com/BSx6mzbW1ew7K.webp'),
                ),
              ),
              const SizedBox(
                width: 12,
              ),
              Hero(
                tag: "02",
                child: Text("Nguyễn Duy",
                    style: Theme.of(context).textTheme.titleMedium),
              ),
            ])),
        actions: [
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: IconButton(
//               icon: const Icon(Icons.notifications_none),
//               onPressed: () {},
//             ),
//           )
//         ],
          //KHÔNG ĐƯỢC CONST!!!!!
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const MedicinePurchaseHistory()));
              },
              icon: const Badge(
                  child: Icon(Symbols.deployed_code),
                  smallSize: 0 /*và 5*/,
                  largeSize: 0)),

          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const NotificationPage()));
              },
              icon: const Icon(
                Symbols.notifications,
                size: 24,
              ))
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text("Tiện ích", style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(
              height: 10,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const emergencycall(),
                          ));
                    },
                    child: Column(
                      children: [
                        Container(
                          width: 62,
                          height: 62,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(0xffFF7D7D),
                          ),
                          child: const Center(
                            child: Text(
                              "SOS",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        Padding(
                            padding: EdgeInsets.zero,
                            child: Text("Gọi điện khẩn cấp",
                                textAlign: TextAlign.center,
                                style: Theme.of(context).textTheme.labelSmall))
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const BmiPage()));
                    },
                    child: Column(
                      children: [
                        Container(
                          width: 62,
                          height: 62,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(0xff6B94FF),
                          ),
                          child: Center(
                            child: Container(
                              child: SvgPicture.asset(
                                  'assets/images/monitor_weight.svg'),
                              alignment: Alignment.center,
                              width: 62,
                              height: 62,
                            ),
                          ),
                        ),
                        Padding(
                            padding: EdgeInsets.zero,
                            child: Text("Tính chỉ số BMI",
                                textAlign: TextAlign.center,
                                style: Theme.of(context).textTheme.labelSmall))
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: InkWell(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => FFMIPage()));
                    },
                    child: Column(
                      children: [
                        Container(
                          width: 62,
                          height: 62,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(0xff6B94FF),
                          ),
                          child: Center(
                            child: Container(
                              child: SvgPicture.asset(
                                  'assets/images/fitness_center.svg'),
                              alignment: Alignment.center,
                              width: 62,
                              height: 62,
                            ),
                          ),
                        ),
                        Padding(
                            padding: EdgeInsets.zero,
                            child: Text("Tính chỉ số FFMI",
                                textAlign: TextAlign.center,
                                style: Theme.of(context).textTheme.labelSmall))
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (c) => const RevisitPage()));
                    },
                    child: Column(
                      children: [
                        Container(
                          width: 62,
                          height: 62,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(0xff6B94FF),
                          ),
                          child: Center(
                            child: Container(
                              alignment: Alignment.center,
                              width: 62,
                              height: 62,
                              child: SvgPicture.asset(
                                  'assets/images/alarm_on.svg'),
                            ),
                          ),
                        ),
                        Padding(
                            padding: EdgeInsets.zero,
                            child: Text("Lịch tái khám",
                                textAlign: TextAlign.center,
                                style: Theme.of(context).textTheme.labelSmall))
                      ],
                    ),
                  ),
                ),
              ],
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const DrugManagePage()));
              },
              child: const Padding(
                padding: EdgeInsets.symmetric(vertical: 16),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Symbols.pill),
                    SizedBox(width: 16),
                    Text("Quản lý thuốc "),
                  ],
                ),
              ),
            ),
            const Divider(),
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => EditInfomationUser()));
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SvgPicture.asset('assets/images/settings_alert.svg'),
                    const SizedBox(width: 16),
                    const Text("Chỉnh sửa tài khoản"),
                  ],
                ),
              ),
            ),
            const Divider(),
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const Changerepassword()));
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SvgPicture.asset('assets/images/encrypted.svg'),
                    const SizedBox(width: 16),
                    const Text("Đổi mật khẩu"),
                  ],
                ),
              ),
            ),
            const Divider(),
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Policy(),
                    ));
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SvgPicture.asset('assets/images/policy.svg'),
                    const SizedBox(width: 16),
                    const Text("Chính sách và hỗ trợ"),
                  ],
                ),
              ),
            ),
            const Divider(),
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LanguagePage(),
                    ));
              },
              child: const Padding(
                padding: EdgeInsets.symmetric(vertical: 16),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Symbols.language_chinese_array),
                    SizedBox(width: 16),
                    Text("Ngôn ngữ"),
                  ],
                ),
              ),
            ),
            const Divider(),
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const TransactionHistoryScreen(),
                    ));
              },
              child: const Padding(
                padding: EdgeInsets.symmetric(vertical: 16),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Symbols.attach_money),
                    SizedBox(width: 16),
                    Text("Lịch sử giao dịch"),
                  ],
                ),
              ),
            ),
            const Divider(),
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const InfoPage(),
                    ));
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SvgPicture.asset('assets/images/info.svg'),
                    const SizedBox(width: 16),
                    const Text("Thông tin ứng dụng"),
                  ],
                ),
              ),
            ),
            const Divider(),
            Container(
              child: InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Login(),
                      ));
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SvgPicture.asset('assets/images/move_item.svg'),
                      const SizedBox(width: 16),
                      const Text("Đăng xuất"),
                    ],
                  ),
                ),
              ),
            ),
            const Divider(),
            Container(
              child: InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AdminPage(),
                      ));
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(Icons.code),
                      const SizedBox(width: 16),
                      const Text("Nhà phát triển"),
                    ],
                  ),
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
