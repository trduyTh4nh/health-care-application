import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:app_well_mate/screen/imergencycall.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'login.dart';
import 'package:app_well_mate/components/shotcut.dart';

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
        title: Row(children: [
          CircleAvatar(
            radius: 20,
            backgroundImage:
                NetworkImage('https://i.giphy.com/BSx6mzbW1ew7K.webp'),
          ),
          SizedBox(
            width: 12,
          ),
          Text("Nguyễn Duy", style: Theme.of(context).textTheme.titleMedium),
        ]),
        actions: const [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(Icons.notifications_none),
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Tiện ích", style: Theme.of(context).textTheme.titleMedium),
            SizedBox(
              height: 10,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
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
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(0xffFF7D7D),
                          ),
                          child: Center(
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
                            child: Text("Gọi điện bác sĩ khẩn cấp",
                                textAlign: TextAlign.center,
                                style: Theme.of(context).textTheme.labelSmall))
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: InkWell(
                    onTap: () {},
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
                    onTap: () {},
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
                    onTap: () {},
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
                                  'assets/images/alarm_on.svg'),
                              alignment: Alignment.center,
                              width: 62,
                              height: 62,
                            ),
                          ),
                        ),
                        Padding(
                            padding: EdgeInsets.zero,
                            child: Text("Thông báo uống thuốc",
                                textAlign: TextAlign.center,
                                style: Theme.of(context).textTheme.labelSmall))
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 12,
            ),
            Text("Cài đặt", style: Theme.of(context).textTheme.titleMedium),
            SizedBox(
              height: 12,
            ),
            Expanded(
                child: InkWell(
              onTap: () {},
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Symbols.pill),
                  SizedBox(width: 16),
                  Text("Quản lý thuốc "),
                ],
              ),
            )),
            Divider(),
            Expanded(
                child: InkWell(
              onTap: () {},
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SvgPicture.asset('assets/images/settings_alert.svg'),
                  SizedBox(width: 16),
                  Text("Chỉnh sửa tài khoản"),
                ],
              ),
            )),
            Divider(),
            Expanded(
                child: InkWell(
              onTap: () {},
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SvgPicture.asset('assets/images/encrypted.svg'),
                  SizedBox(width: 16),
                  Text("Đổi mật khẩu"),
                ],
              ),
            )),
            Divider(),
            Expanded(
                child: InkWell(
              onTap: () {},
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SvgPicture.asset('assets/images/delete.svg'),
                  SizedBox(width: 16),
                  Text("Xóa tài khoản"),
                ],
              ),
            )),
            Divider(),
            Expanded(
                child: InkWell(
              onTap: () {},
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SvgPicture.asset('assets/images/policy.svg'),
                  SizedBox(width: 16),
                  Text("Chính sách và hỗ trợ"),
                ],
              ),
            )),
            Divider(),
            Expanded(
                child: InkWell(
              onTap: () {},
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SvgPicture.asset('assets/images/info.svg'),
                  SizedBox(width: 16),
                  Text("Thông tin ứng dụng"),
                ],
              ),
            )),
            Divider(),
            Expanded(
                child: InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Login(),
                    ));
              },
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SvgPicture.asset('assets/images/move_item.svg'),
                  SizedBox(width: 16),
                  Text("Đăng xuất"),
                ],
              ),
            )),
          ],
        ),
      ),
    );
  }
}
