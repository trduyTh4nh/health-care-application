import 'package:flutter/material.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';

class emergencycall extends StatefulWidget {
  const emergencycall({super.key});

  @override
  State<emergencycall> createState() => _emergencycallState();
}

class _emergencycallState extends State<emergencycall> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              children: [
                Container(
                  child: SvgPicture.asset('assets/images/emergency.svg'),
                  alignment: Alignment.center,
                ),
                SizedBox(
                  height: 12,
                ),
                Padding(
                    padding: EdgeInsets.zero,
                    child: Text("Gọi khẩn cấp",
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.headlineLarge)),
                Padding(
                    padding: EdgeInsets.all(12),
                    child: Text(
                        "Ấn nút dưới đây trong 5 giây để gọi khẩn cấp đến bệnh viện của bạn",
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.labelSmall)),
              ],
            ),
            InkWell(
              onTap: () {},
              child: Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xffFF7D7D),
                ),
                child: Center(
                  child: Text(
                    "Gọi khẩn cấp",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Text(
                    "Bệnh viện: Bệnh viện Đại học Y Dược Thành phố Hồ Chí Minh",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.labelSmall),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
