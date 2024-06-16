import 'package:app_well_mate/const/color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

class TimeItem extends StatefulWidget {
  const TimeItem({super.key, required this.time, this.title, this.sIndex});
  final TimeOfDay time;
  final Widget? title;
  final int? sIndex;
  @override
  State<TimeItem> createState() => _TimeItemState();
}

class _TimeItemState extends State<TimeItem> {
  bool checkCurrentTime = false;

  String getPeriodOfDay(int h) {
    if (h > 18) {
      return "tối";
    }
    if (h > 12) {
      return "chiều";
    }
    return "sáng";
  }


  @override
  void initState() {
    super.initState();

    print(widget.sIndex);

    TimeOfDay currentTime = TimeOfDay.now();
    // print("Current time ${currentTime.hour} time ${widget.time.hour}");
    if (widget.time.hour == currentTime.hour) {
      setState(() {
        checkCurrentTime = true;
      });

      // print(checkCurrentTime);
    }

  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          widget.title != null
              ? Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Column(
                    children: [
                      widget.title!,
                    ],
                  ),
                )
              : const SizedBox(),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 6),
            child: Material(
              color: AppColor.gray,
              borderRadius: const BorderRadius.all(Radius.circular(20)),
              child: InkWell(
                onTap: () {
                  print(widget.sIndex);
                },
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 16, right: 2, top: 2, bottom: 2),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Icon(Symbols.alarm),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                              "${widget.time.hourOfPeriod.toString().padLeft(2, '0')}:${widget.time.minute.toString().padLeft(2, '0')} ${getPeriodOfDay(widget.time.hour)}"),

                          const SizedBox(width: 10,),
                          checkCurrentTime ? Text("(Tiếp theo)") : const SizedBox()
                        ],
                      ),
                      IconButton(
                          onPressed: () {},
                          icon: const Icon(Symbols.more_horiz))
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
