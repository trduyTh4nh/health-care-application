import 'dart:developer';

import 'package:app_well_mate/api/auth/api_repo.dart';
import 'package:app_well_mate/const/current_page.dart';
import 'package:app_well_mate/main.dart';
import 'package:app_well_mate/model/user.dart';
import 'package:app_well_mate/screen/admin/admin_page.dart';
import 'package:app_well_mate/screen/signup.dart';
import 'package:app_well_mate/storage/secure_storage.dart';
import 'package:app_well_mate/utils/app.colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

String? currentPassword;

class LoginByEmail extends StatefulWidget {
  const LoginByEmail({super.key});
  @override
  State<LoginByEmail> createState() => _LoginByEmailState();
}

class _LoginByEmailState extends State<LoginByEmail> {
  final _formKey = GlobalKey<FormState>();

  String? validateEmail(String? email) {
    log("dang kiem tra");
    RegExp emailRegex = RegExp(r'^[\w\.-]+@gmail\.com$');
    final isEmailValid = emailRegex.hasMatch(email ?? '');
    if (!isEmailValid) {
      return "Vui lòng nhập email hợp lệ";
    }
    return null;
  }

  late User user;
  bool isLoading = false;
  bool _isSecurePassword = true;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  ApiRepo repo = ApiRepo();
  login(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });
      String msg = "";
      bool r =
          await repo.login(_emailController.text, _passwordController.text);
      msg = r ? "Đăng nhập thành công" : "Email hoặc mật khẩu không khớp";
      // lụm nó cho thầy
      if (r) {
        currentPassword = _passwordController.text;
        print("lấy pass ra cho thầy: $currentPassword");
      }
      setState(() {
        isLoading = false;
      });
      int role = await SecureStorage.getUserRole();
      if (role == 2) {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const AdminPage()));
        return;
      }
      if (context.mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(msg)));
        if (r) {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => currentpage));
        }
      }
    }
  }

  Widget tooglePassword() {
    return IconButton(
        onPressed: () {
          setState(() {
            _isSecurePassword = !_isSecurePassword;
          });
        },
        icon: _isSecurePassword
            ? const Icon(Icons.visibility_off_outlined)
            : const Icon(Icons.visibility_outlined));
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
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
                height: 8,
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 0, horizontal: 48),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        validator: validateEmail,
                        onChanged: (value) {},
                        controller: _emailController,
                        decoration: const InputDecoration(
                            hintText: 'Email',
                            hintStyle: TextStyle(
                                fontSize: 16,
                                color: Color.fromARGB(255, 167, 167, 167)),
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 20),
                            border: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(width: 3, color: Colors.grey)),
                            prefixIcon: Icon(Icons.email_outlined),
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
                        obscureText: _isSecurePassword,
                        onChanged: (value) {
                          print(value);
                        },
                        controller: _passwordController,
                        decoration: InputDecoration(
                            suffixIcon: tooglePassword(),
                            hintText: 'Password',
                            hintStyle: const TextStyle(
                                fontSize: 16,
                                color: Color.fromARGB(255, 167, 167, 167)),
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 20),
                            border: const UnderlineInputBorder(
                                borderSide:
                                    BorderSide(width: 3, color: Colors.grey)),
                            prefixIcon: const Icon(Icons.password),
                            focusedBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(
                                    width: 3, color: AppColors.primaryColor)),
                            enabledBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(
                                    width: 2, color: AppColors.greyColor))),
                      ),
                      const SizedBox(
                        height: 32,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          login(context);
                        },
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
                                  const Color.fromARGB(255, 238, 238, 238)),
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
                        height: 8,
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
                                      builder: (context) => currentpage));
                            },
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const Signup(),
                                    ));
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
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
        isLoading
            ? Center(
                child: LoadingAnimationWidget.flickr(
                leftDotColor: colorScheme.primary,
                rightDotColor: colorScheme.error,
                size: 70,
              ))
            : const SizedBox()
      ],
    );
  }
}
