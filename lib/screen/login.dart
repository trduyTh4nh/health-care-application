import 'package:app_well_mate/components/loginByEmail.dart';
import 'package:app_well_mate/components/loginBypPhone.dart';
import 'package:app_well_mate/utils/app.colors.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
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
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
          child: Column(
            children: [
              Container(
                child: Lottie.asset('assets/images/dotorjson.json'),
                alignment: Alignment.center,
                padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
              ),
              const SizedBox(
                height: 0,
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
                height: 28,
              ),
              LoginByEmail(),
            ],
          ),
        ),
      ),
    );
  }
}

void _handlePageViewChanged(int currentPageIndex) {}
