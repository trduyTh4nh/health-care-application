import 'package:app_well_mate/const/color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

class TimeItem extends StatelessWidget {
  const TimeItem({super.key, required this.time, this.title});
  final TimeOfDay time;
  final Widget? title;

  String getPeriodOfDay(int h){
    if(h >= 18){
      return "tối";
    }
    if(h >= 12){
      return "chiều";
    }
    return "sáng";
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        title != null ? 
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
          child: Column(
            children: [
              title!,
            ],
          ),
        )
        : const SizedBox(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Material(
            color: AppColor.gray,
            borderRadius: const BorderRadius.all(Radius.circular(16)),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: [
                  Row(
                    children: [
                      Icon(Symbols.alarm),
                      SizedBox(width: 10,),
                      Text("${time.hourOfPeriod.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')} ${getPeriodOfDay(time.hour)}")
                    ],
                  )
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}