import 'package:app_well_mate/api/auth/api_repo.dart';
import 'package:app_well_mate/components/snack_bart.dart';
import 'package:app_well_mate/screen/login.dart';
import 'package:app_well_mate/utils/app.colors.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _namePController = TextEditingController();
  final TextEditingController _userNamePController = TextEditingController();

  register() async {
    String respone = await ApiRepo().register(
        _userNamePController.text,
        _namePController.text,
        _emailController.text,
        _phoneController.text,
        _passwordController.text);
    print("đăng ký thành công");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(4),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  child: Lottie.asset('assets/images/fight_the_virus.json'),
                  alignment: Alignment.center,
                  width: double.infinity,
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                ),
                const Text(
                  "Đăng kí",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 0, horizontal: 48),
                  child: Column(
                    children: [
                      TextField(
                        onChanged: (value) {},
                        controller: _userNamePController,
                        decoration: const InputDecoration(
                            hintText: 'User name',
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
                        controller: _emailController,
                        decoration: const InputDecoration(
                            hintText: 'Nhập email',
                            hintStyle: TextStyle(
                                fontSize: 16,
                                color: Color.fromARGB(255, 167, 167, 167)),
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 20),
                            border: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(width: 3, color: Colors.grey)),
                            prefixIcon: Icon(Icons.email),
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
                        obscureText: true,
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
                      SizedBox(
                        width: 360,
                        height: 48,
                        child: ElevatedButton(
                          onPressed: () {
                            register();
                            showCustomSnackBar(context, "Đăng ký thành công");
                          },
                          child: Text(
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
                        height: 16,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const Login(),
                              ));
                        },
                        child: const Text(
                          'Đăng nhập',
                          style: TextStyle(
                              color: AppColors.primaryColor,
                              decoration: TextDecoration.underline,
                              decorationColor: AppColors.primaryColor,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
