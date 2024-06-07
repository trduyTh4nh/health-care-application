import 'package:app_well_mate/utils/app.colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _rePassController = TextEditingController();
  final TextEditingController _namePController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(4),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
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
              const Text(
                "Đăng kí",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
              const SizedBox(
                height: 32,
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 0, horizontal: 48),
                child: Column(
                  children: [
                    TextField(
                      onChanged: (value) {
                        print(value);
                      },
                      controller: _phoneController,
                      decoration: const InputDecoration(
                          hintText: 'Số điện thoại',
                          hintStyle: TextStyle(
                              fontSize: 16,
                              color: Color.fromARGB(255, 167, 167, 167)),
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 20),
                          border: UnderlineInputBorder(
                              borderSide:
                                  BorderSide(width: 3, color: Colors.grey)),
                          prefixIcon: Icon(Icons.phone),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  width: 3, color: AppColors.primaryColor)),
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  width: 2, color: AppColors.greyColor))),
                    ),
                    const SizedBox(
                      height: 32,
                    ),
                    TextField(
                      onChanged: (value) {},
                      controller: _passwordController,
                      decoration: const InputDecoration(
                          hintText: 'Mật khẩu',
                          hintStyle: TextStyle(
                              fontSize: 16,
                              color: Color.fromARGB(255, 167, 167, 167)),
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 20),
                          border: UnderlineInputBorder(
                              borderSide:
                                  BorderSide(width: 3, color: Colors.grey)),
                          prefixIcon: Icon(Icons.password),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  width: 3, color: AppColors.primaryColor)),
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  width: 2, color: AppColors.greyColor))),
                    ),
                    const SizedBox(
                      height: 32,
                    ),
                    TextField(
                      onChanged: (value) {},
                      controller: _rePassController,
                      decoration: const InputDecoration(
                          hintText: 'Nhập lại mật khẩu',
                          hintStyle: TextStyle(
                              fontSize: 16,
                              color: Color.fromARGB(255, 167, 167, 167)),
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 20),
                          border: UnderlineInputBorder(
                              borderSide:
                                  BorderSide(width: 3, color: Colors.grey)),
                          prefixIcon: Icon(Icons.password),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  width: 3, color: AppColors.primaryColor)),
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  width: 2, color: AppColors.greyColor))),
                    ),
                    const SizedBox(
                      height: 32,
                    ),
                    TextField(
                      onChanged: (value) {},
                      controller: _namePController,
                      decoration: const InputDecoration(
                          hintText: 'Họ và tên',
                          hintStyle: TextStyle(
                              fontSize: 16,
                              color: Color.fromARGB(255, 167, 167, 167)),
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 20),
                          border: UnderlineInputBorder(
                              borderSide:
                                  BorderSide(width: 3, color: Colors.grey)),
                          prefixIcon: Icon(Icons.person_outlined),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  width: 3, color: AppColors.primaryColor)),
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  width: 2, color: AppColors.greyColor))),
                    ),
                    const SizedBox(
                      height: 32,
                    ),
                    SizedBox(
                      width: 360,
                      height: 48,
                      child: ElevatedButton(
                        onPressed: () {},
                        child: const Text(
                          'Đăng kí',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Colors.white),
                        ),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primaryColor,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(6))),
                      ),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
