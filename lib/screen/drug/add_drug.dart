import 'dart:developer';

import 'package:app_well_mate/providers/add_page_provider.dart';
import 'package:app_well_mate/screen/drug/add_drug_pages/add_drug_dosage.dart';
import 'package:app_well_mate/screen/drug/add_drug_pages/add_drug_habit.dart';
import 'package:app_well_mate/screen/drug/add_drug_pages/add_drug_info.dart';
import 'package:app_well_mate/screen/drug/add_drug_pages/add_drug_schedule.dart';
import 'package:app_well_mate/utils/app.colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class AddDrugPage extends StatefulWidget {
  const AddDrugPage({super.key, this.addPageProdiver});
  final AddPageProvider? addPageProdiver;
  @override
  State<AddDrugPage> createState() => _AddDrugPageState();
}

class _AddDrugPageState extends State<AddDrugPage> {
  int _currentPageIndex = 0;
  PageController _pageController = PageController();
  List<Widget> pages = [
    AddDrugInfoPage(),
    AddDrugHabitPage(),
    AddDrugSchedulePage(),
    AddDrugPageDosage()
  ];
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => widget.addPageProdiver ?? AddPageProvider())
      ],
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text("Thêm thuốc"),
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("Huỷ")),
            )
          ],
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
              child: SmoothPageIndicator(
                controller: _pageController,
                count: pages.length,
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
              child: PageView(
                physics: NeverScrollableScrollPhysics(),
                controller: _pageController,
                children: pages,
              ),
            ),
            Consumer<AddPageProvider>(builder: (context, value, child) {
              void checkIsPageValid() {
                if (_currentPageIndex == 2) {
                  value.isValid = value.scheduleDetailModel.isNotEmpty || value.habit != 0;
                }
                if(_currentPageIndex == 1){
                  value.isValid = true;
                }
                FocusManager.instance.primaryFocus?.unfocus();
              }
              return Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  children: [
                    _currentPageIndex != 0
                        ? Expanded(
                            child: FilledButton(
                                onPressed: () {
                                  if (_currentPageIndex == 0) {
                                    _currentPageIndex = -1;
                                  }
                                  _currentPageIndex--;
                                  _pageController.animateToPage(
                                      _currentPageIndex,
                                      duration: Duration(milliseconds: 500),
                                      curve: Curves.easeInOutCubicEmphasized);
                                  checkIsPageValid();
                                  setState(() {});
                                },
                                child: const Text("Trước")),
                          )
                        : const SizedBox(),
                    SizedBox(
                      width: _currentPageIndex == 0 ? 0 : 10,
                    ),
                    Expanded(
                      child: ElevatedButton(
                          onPressed: value.isValid
                              ? () {
                                  if (_currentPageIndex >= pages.length - 1) {
                                    Navigator.pop(context);
                                    //TODO: Add thuốc khi có back-end.
                                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Đã thêm thuốc.")));
                                    return;
                                  }
                                  _currentPageIndex++;
                                  _pageController.animateToPage(
                                      _currentPageIndex,
                                      duration: Duration(milliseconds: 500),
                                      curve: Curves.easeInOutCubicEmphasized);
                                  checkIsPageValid();
                                  setState(() {});
                                }
                              : null,
                          child: Text(_currentPageIndex == pages.length - 1
                              ? "Thêm"
                              : "Tiếp")),
                    ),
                  ],
                ),
              );
            })
          ],
        ),
      ),
    );
  }
}
