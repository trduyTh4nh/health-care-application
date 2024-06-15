import 'dart:developer';

import 'package:app_well_mate/providers/add_page_provider.dart';
import 'package:app_well_mate/screen/drug/add_drug_pages/add_drug_habit.dart';
import 'package:app_well_mate/screen/drug/add_drug_pages/add_drug_info.dart';
import 'package:app_well_mate/utils/app.colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class AddDrugPage extends StatefulWidget {
  const AddDrugPage({super.key});

  @override
  State<AddDrugPage> createState() => _AddDrugPageState();
}

class _AddDrugPageState extends State<AddDrugPage> {
  int _currentPageIndex = 0;
  PageController _pageController = PageController();
  List<Widget> pages = [
    AddDrugInfoPage(),
    AddDrugHabitPage(),
    AddDrugInfoPage(),
    AddDrugInfoPage()
  ];
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AddPageProvider())
      ],
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text("Thêm thuốc"),
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("Huỷ")),
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
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                children: [
                  _currentPageIndex != 0 ?
                  Expanded(
                    child: FilledButton(onPressed: () {
                      if(_currentPageIndex == 0){
                        _currentPageIndex = -1;
                      }
                      _currentPageIndex--;
                      _pageController.animateToPage(_currentPageIndex, duration: Duration(milliseconds: 500), curve: Curves.easeInOutCubicEmphasized);
                      setState(() {
                        
                      });
                    }, child: Text("Trước")),
                  ) : const SizedBox(),
                  SizedBox(width: _currentPageIndex == 0 ? 0 : 10,),
                  Expanded(
                    child: ElevatedButton(onPressed: () {
                      if(_currentPageIndex >= pages.length - 1){
                        return;
                      }
                      _currentPageIndex++;
                      _pageController.animateToPage(_currentPageIndex, duration: Duration(milliseconds: 500), curve: Curves.easeInOutCubicEmphasized);
                      setState(() {
                        
                      });
                    }, child: Text(_currentPageIndex == pages.length - 1 ? "Thêm" : "Tiếp")),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
