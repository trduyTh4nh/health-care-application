import 'package:app_well_mate/model/prescription_detail_model.dart';
import 'package:app_well_mate/screen/drug/medicine_order/widget_buy_medicine.dart';
import 'package:app_well_mate/screen/drug/medicine_order/widget_complete_medicine.dart';
import 'package:app_well_mate/screen/drug/medicine_order/widget_payment_medicine.dart';
import 'package:app_well_mate/utils/app.colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:app_well_mate/providers/cart_page_provider.dart';

class MedicinesOrder extends StatefulWidget {
  const MedicinesOrder({super.key});

  @override
  State<MedicinesOrder> createState() => _MedicinesOrderState();
}

class _MedicinesOrderState extends State<MedicinesOrder> {
  int _currentPageIndex = 0;
  final PageController _pageController = PageController();

  final List<String> _title = [
    "Mua thuốc",
    "Thanh toán",
    "Hoàn tất",
  ];

  @override
  Widget build(BuildContext context) {
    var selectedDrugs = Provider.of<CartPageProvider>(context).getSelectedDrugs();
    var totalPrice = Provider.of<CartPageProvider>(context).calculateTotalPrice();

    return Scaffold(
      appBar: AppBar(
        title: AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          transitionBuilder: (Widget child, Animation<double> animation) {
            return ScaleTransition(scale: animation, child: child);
          },
          child: Text(
            _title[_currentPageIndex],
            key: ValueKey(_title[_currentPageIndex]),
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: SmoothPageIndicator(
              controller: _pageController,
              count: _title.length,
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
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 20),
              child: PageView(
                physics: const NeverScrollableScrollPhysics(),
                controller: _pageController,
                children: [
                  WidgetBuyMedicine(selectedDrugs: selectedDrugs),
                  // WidgetPaymentMedicine(totalPrice: totalPrice),
                  WidgetPaymentMedicine(),  
                  WidgetCompleteMedicine(selectedDrugs: selectedDrugs)
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Tổng tiền",
                  style: Theme.of(context).textTheme.labelMedium,
                ),
                Text(
                  "$totalPrice Đ",
                  style: Theme.of(context).textTheme.displayMedium,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _currentPageIndex != _title.length - 1
                          ? FilledButton(
                              onPressed: () {
                                if (_currentPageIndex > 0) {
                                  _currentPageIndex--;
                                }
                                _pageController.animateToPage(
                                  _currentPageIndex,
                                  duration: const Duration(milliseconds: 500),
                                  curve: Curves.easeInOutCubicEmphasized,
                                );
                                setState(() {});
                              },
                              child: const Text("Quay lại"),
                            )
                          : const SizedBox.shrink(),
                      _currentPageIndex != _title.length - 1
                          ? ElevatedButton(
                              onPressed: () {
                                if (_currentPageIndex >= _title.length - 1) {
                                  return;
                                }
                                _currentPageIndex++;
                                _pageController.animateToPage(
                                  _currentPageIndex,
                                  duration: const Duration(milliseconds: 500),
                                  curve: Curves.easeInOutCubicEmphasized,
                                );
                                setState(() {});
                              },
                              child: const Text("Tiếp theo"),
                            )
                          : Expanded(
                              child: SizedBox(
                                child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            WidgetCompleteMedicine(selectedDrugs: selectedDrugs),
                                      ),
                                    );
                                  },
                                  child: const Text("Hoàn thành"),
                                ),
                              ),
                            ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
