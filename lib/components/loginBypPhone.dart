import 'package:app_well_mate/screen/signup.dart';
import 'package:app_well_mate/utils/app.colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginByPhone extends StatefulWidget {
  const LoginByPhone({super.key});

  @override
  State<LoginByPhone> createState() => _LoginByPhoneState();
}

class _LoginByPhoneState extends State<LoginByPhone> {
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(),
        child: Container(
          padding: const EdgeInsets.all(4),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Text(
                "Đăng nhập",
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
                          hintText: 'Phone',
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
                      onChanged: (value) {
                        print(value);
                      },
                      controller: _passwordController,
                      decoration: const InputDecoration(
                          hintText: 'Password',
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
                    SizedBox(
                      width: 360,
                      height: 48,
                      child: ElevatedButton(
                        onPressed: () {},
                        child: const Text(
                          'Đăng nhập',
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
                    const Divider(
                      color: Colors.black,
                    ),
                    const Text(
                      'Hoặc',
                      style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    SizedBox(
                      width: 50,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.all(0),
                            shape: const CircleBorder(),
                            backgroundColor:
                                Color.fromARGB(255, 238, 238, 238)),
                        child: ClipOval(
                          child: SvgPicture.asset(
                            'assets/images/google-color.svg',
                            width: 25,
                            height: 25,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 100,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Chưa có tài khoản?',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        const SizedBox(
                          width: 4,
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const Signup()));
                          },
                          child: const Text(
                            'Đăng kí',
                            style: TextStyle(
                                color: AppColors.primaryColor,
                                decoration: TextDecoration.underline,
                                decorationColor: AppColors.primaryColor,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
