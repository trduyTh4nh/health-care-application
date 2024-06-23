import 'package:app_well_mate/components/utilities_profile_widget.dart';
import 'package:app_well_mate/screen/changeRePassword.dart';
import 'package:app_well_mate/screen/ffmi.dart';
import 'package:app_well_mate/screen/imergencycall.dart';
import 'package:app_well_mate/screen/quick_action/bmi_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'login.dart';
import 'package:app_well_mate/components/shotcut.dart';
import 'package:app_well_mate/screen/drug/medicine_order/medicines_order_main.dart';

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
        title: Row(children: [
          const CircleAvatar(
            radius: 20,
            backgroundImage:
                NetworkImage('https://i.giphy.com/BSx6mzbW1ew7K.webp'),
          ),
          const SizedBox(
            width: 12,
          ),
          Text("Nguyễn Duy", style: Theme.of(context).textTheme.titleMedium),
        ]),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              icon: const Icon(Icons.notifications_none),
              onPressed: () {},
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Tiện ích", style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(
                height: 10,
              ),
              const UtilitiesProfileWidget(),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Text("Cài đặt",
                    style: Theme.of(context).textTheme.titleMedium),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const MedicinesOrder()));
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
                onTap: () {},
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
                onTap: () {},
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SvgPicture.asset('assets/images/delete.svg'),
                      const SizedBox(width: 16),
                      const Text("Xóa tài khoản"),
                    ],
                  ),
                ),
              ),
              const Divider(),
              InkWell(
                onTap: () {},
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
                onTap: () {},
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
              InkWell(
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
            ],
          ),
        ),
      ),
    );
  }
}
