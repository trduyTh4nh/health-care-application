import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:app_well_mate/utils/app.colors.dart';
import 'package:app_well_mate/screen/drug/medicine_order/widget_buy_medicine.dart';
import 'package:app_well_mate/screen/drug/medicine_order/widget_complete_medicine.dart';
import 'package:app_well_mate/screen/drug/medicine_order/widget_payment_medicine.dart';

class MedicinesOrder extends StatefulWidget {
  const MedicinesOrder({super.key});

  @override
  State<MedicinesOrder> createState() => _MedicinesOrderState();
}

class _MedicinesOrderState extends State<MedicinesOrder> {
  late PageController _pageViewController;
  @override
  void initState() {
    super.initState();
    _pageViewController = PageController();
  }

  @override
  void dispose() {
    super.dispose();
    _pageViewController.dispose();
  }

  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(children: [
          SizedBox(
            width: 12,
          ),
          Text("Mua thuốc", style: Theme.of(context).textTheme.titleMedium),
        ]),
        actions: const [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(Icons.notifications_none),
          )
        ],
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 23),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SmoothPageIndicator(
                controller: _pageViewController,
                count: 3,
                axisDirection: Axis.horizontal,
                effect: const SlideEffect(
                  spacing: 8.0,
                  radius: 4.0,
                  dotWidth: 36.0,
                  dotHeight: 10.0,
                  strokeWidth: 1,
                  dotColor: AppColors.greyColor,
                  activeDotColor: AppColors.primaryColor,
                ),
              ),
              // const SizedBox(
              //   height: 32,
              // ),
              Expanded(
                  child: PageView(
                onPageChanged: (value) {
                  setState(() {
                    currentPageIndex = value;
                  });
                },
                controller: _pageViewController,
                children: const [
                  WidgetBuyMedicine(),
                  WidgetCompleteMedicine(),
                  WidgetPaymentMedicine()
                ],
              )),
              Text("Tổng tiền"),
              Text("505.000đ", style: Theme.of(context).textTheme.titleMedium),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 150,
                    height: 40,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => WidgetBuyMedicine()));
                      },
                      child: const Text(
                        'Quay lại',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                            color: Colors.black),
                      ),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.greyColor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6))),
                    ),
                  ),
                  SizedBox(
                    width: 150,
                    height: 40,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => WidgetBuyMedicine()));
                      },
                      child: const Text(
                        'Tiếp theo',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                            color: Colors.white),
                      ),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primaryColor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6))),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
