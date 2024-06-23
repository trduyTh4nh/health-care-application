import 'package:app_well_mate/screen/FFMI.dart';
import 'package:app_well_mate/screen/imergencycall.dart';
import 'package:app_well_mate/screen/quick_action/bmi_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class UtilitiesProfileWidget extends StatelessWidget {
  const UtilitiesProfileWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
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
                          color: Colors.white, fontWeight: FontWeight.bold),
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
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const BmiPage()));
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
                    child: SvgPicture.asset('assets/images/monitor_weight.svg'),
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
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => FFMIPage()));
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
                    child: SvgPicture.asset('assets/images/fitness_center.svg'),
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
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xff6B94FF),
                  ),
                  child: Center(
                    child: SvgPicture.asset('assets/images/alarm_on.svg'),
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
    );
  }
}
