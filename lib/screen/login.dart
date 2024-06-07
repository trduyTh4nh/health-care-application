import 'package:app_well_mate/components/loginByEmail.dart';
import 'package:app_well_mate/components/loginBypPhone.dart';
import 'package:app_well_mate/utils/app.colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> with TickerProviderStateMixin {
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
      backgroundColor: Colors.white,
      body: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
        child: Column(
          children: [
            Container(
              child: SvgPicture.asset('assets/images/login_picture.svg'),
              alignment: Alignment.center,
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(0, 48, 0, 0),
            ),
            const SizedBox(
              height: 64,
            ),
            SmoothPageIndicator(
              controller: _pageViewController,
              count: 2,
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
            const SizedBox(
              height: 32,
            ),
            Expanded(
                child: PageView(
              onPageChanged: (value) {
                setState(() {
                  currentPageIndex = value;
                });
              },
              controller: _pageViewController,
              children: const [
                LoginByEmail(),
                LoginByPhone(),
              ],
            ))
          ],
        ),
      ),
    );
  }
}

void _handlePageViewChanged(int currentPageIndex) {}
