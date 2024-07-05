import 'package:flutter/material.dart';
import 'package:app_well_mate/utils/app.colors.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Changerepassword extends StatefulWidget {
  const Changerepassword({super.key});

  @override
  State<Changerepassword> createState() => _ChangerepasswordState();
}

class _ChangerepasswordState extends State<Changerepassword> {
  final TextEditingController passCurrentController = TextEditingController();
  final TextEditingController newPassController = TextEditingController();
  final TextEditingController newRepassController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Đổi mật khẩu',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Thêm hình ảnh
                    Center(
                      child: SvgPicture.asset(
                        'assets/images/undraw_forgot_password.svg',
                      ),
                    ),
                    const SizedBox(height: 32),
                    Center(
                      child: Text(
                        'Đổi mật khẩu hiện tại',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ),
                    const SizedBox(
                      height: 32,
                    ),
                    Text(
                      'Mật khẩu hiện tại',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    TextField(
                      controller: passCurrentController,
                      decoration: const InputDecoration(
                        hintText: 'Nhập mật khẩu hiện tại',
                        hintStyle: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w100,
                          fontStyle: FontStyle.normal,
                          color: Color.fromARGB(255, 216, 206, 206),
                        ),
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                        border: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey, width: 3),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: AppColors.primaryColor, width: 3),
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: AppColors.greyColor, width: 2),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),

                    // Mật khẩu mới
                    const Text(
                      'Mật khẩu mới',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    TextField(
                      controller: newPassController,
                      decoration: const InputDecoration(
                        hintText: 'Nhập mật khẩu mới',
                        hintStyle: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w100,
                          fontStyle: FontStyle.normal,
                          color: Color.fromARGB(255, 216, 206, 206),
                        ),
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                        border: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey, width: 3),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: AppColors.primaryColor, width: 3),
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: AppColors.greyColor, width: 2),
                        ),
                      ),
                    ),
                    const SizedBox(height: 32),

                    // Nhập lại mật khẩu
                    const Text(
                      'Nhập lại mật khẩu',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    TextField(
                      controller: newRepassController,
                      decoration: const InputDecoration(
                        hintText: 'Nhập lại mật khẩu mới',
                        hintStyle: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w100,
                          fontStyle: FontStyle.normal,
                          color: Color.fromARGB(255, 216, 206, 206),
                        ),
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                        border: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey, width: 3),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: AppColors.primaryColor, width: 3),
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: AppColors.greyColor, width: 2),
                        ),
                      ),
                    ),
                    // Nút Cập nhật
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryColor,
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 0, vertical: 16),
                  child: Text(
                    'Cập nhật',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
