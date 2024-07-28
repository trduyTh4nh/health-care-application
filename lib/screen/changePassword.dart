import 'package:app_well_mate/api/user/user_repo.dart';
import 'package:app_well_mate/components/loginByEmail.dart';
import 'package:app_well_mate/storage/secure_storage.dart';
import 'package:flutter/material.dart';
import 'package:app_well_mate/main.dart';
import 'package:app_well_mate/utils/app.colors.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final TextEditingController passCurrentController = TextEditingController();
  final TextEditingController newPassController = TextEditingController();
  final TextEditingController newRepassController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isLoading = false;
  bool _isSecurePassword = true;

  void _changePassword(String newPassword) async {
    if (!mounted) return;

    setState(() {
      isLoading = true;
    });

    String? token = await SecureStorage.getToken();
    bool success = await UserRepo().changePassword(newPassword, token);

    if (!mounted) return;

    setState(() {
      isLoading = false;
      if (success) {
        currentPassword = newPassword;
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(
                success ? 'Đổi mật khẩu thành công' : 'Đổi mật khẩu thất bại')),
      );
    });
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
        Scaffold(
          appBar: AppBar(
            title: const Text(
              'Đổi mật khẩu',
              style: TextStyle(color: Colors.black),
            ),
            backgroundColor: Colors.white,
          ),
          body: Form(
            key: _formKey,
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
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
                            height: 10,
                          ),
                          TextFormField(
                            controller: passCurrentController,
                            obscureText: _isSecurePassword,
                            onChanged: (value) {},
                            decoration: InputDecoration(
                              suffixIcon: tooglePassword(),
                              hintText: 'Nhập mật khẩu hiện tại',
                              hintStyle: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w100,
                                fontStyle: FontStyle.normal,
                                color: Color.fromARGB(255, 216, 206, 206),
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 16),
                              border: const UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.grey, width: 3),
                              ),
                              focusedBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: AppColors.primaryColor, width: 3),
                              ),
                              enabledBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: AppColors.greyColor, width: 2),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Vui lòng nhập mật khẩu hiện tại';
                              }
                              if (value != currentPassword) {
                                return 'Mật khẩu hiện tại không đúng';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 10),
                          const Text(
                            'Mật khẩu mới',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          TextFormField(
                            controller: newPassController,
                            decoration: const InputDecoration(
                              hintText: 'Nhập mật khẩu mới',
                              hintStyle: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w100,
                                fontStyle: FontStyle.normal,
                                color: Color.fromARGB(255, 216, 206, 206),
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 16),
                              border: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.grey, width: 3),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: AppColors.primaryColor, width: 3),
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: AppColors.greyColor, width: 2),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Vui lòng nhập mật khẩu mới';
                              } else if (!RegExp(
                                      r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$')
                                  .hasMatch(value)) {
                                return 'Mật khẩu phải có ít nhất 8 ký tự,\n bao gồm chữ cái và số';
                              }

                              if (value == currentPassword) {
                                return 'Vui lòng không nhập trùng với mật khẩu cũ';
                              }

                              return null;
                            },
                          ),
                          const SizedBox(height: 10),
                          const Text(
                            'Nhập lại mật khẩu',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          TextFormField(
                            controller: newRepassController,
                            decoration: const InputDecoration(
                              hintText: 'Nhập lại mật khẩu mới',
                              hintStyle: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w100,
                                fontStyle: FontStyle.normal,
                                color: Color.fromARGB(255, 216, 206, 206),
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 16),
                              border: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.grey, width: 3),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: AppColors.primaryColor, width: 3),
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: AppColors.greyColor, width: 2),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Vui lòng nhập lại mật khẩu';
                              }
                              if (value != newPassController.text) {
                                return 'Mật khẩu không khớp';
                              }
                              return null;
                            },
                          ),
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
                      onPressed: () {
                        if (_formKey.currentState?.validate() ?? false) {
                          _changePassword(newPassController.text);
                          // ScaffoldMessenger.of(context).showSnackBar(
                          //   const SnackBar(
                          //       content: Text('Đổi mật khẩu thành công')),
                          // );
                          // Navigator.pop(context);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryColor,
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 0, vertical: 16),
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
          ),
        ),
        isLoading
            ? Container(
                width: double.infinity,
                height: double.infinity,
                color: Colors.grey.withOpacity(0.5),
                child: Center(
                  child: LoadingAnimationWidget.flickr(
                    leftDotColor: colorScheme.primary,
                    rightDotColor: colorScheme.error,
                    size: 48,
                  ),
                ))
            : const SizedBox()
      ],
    );
  }
}
