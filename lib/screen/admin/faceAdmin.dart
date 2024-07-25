import 'package:app_well_mate/screen/changePassword.dart';
import 'package:app_well_mate/screen/info.dart';
import 'package:app_well_mate/screen/language.dart';
import 'package:app_well_mate/screen/login.dart';
import 'package:app_well_mate/screen/policy.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:material_symbols_icons/symbols.dart';

class FaceAdmin extends StatefulWidget {
  const FaceAdmin({super.key});

  @override
  State<FaceAdmin> createState() => _FaceAdminState();
}

class _FaceAdminState extends State<FaceAdmin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(children: [
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
        ]),
        actions: [
          //KHÔNG ĐƯỢC CONST!!!!!
          IconButton(
              onPressed: () {
                // Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //         builder: (context) => const NotificationPage()));
              },
              icon: const Icon(
                Symbols.notifications,
                size: 24,
              ))
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
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
                        builder: (context) => const ChangePassword()));
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
            )
          ]),
        ),
      ),
    );
  }
}
