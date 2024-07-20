import 'dart:io';

import 'package:app_well_mate/api/auth/api_repo.dart';
import 'package:app_well_mate/main.dart';
import 'package:app_well_mate/model/profile_model.dart';
import 'package:app_well_mate/screen/admin/hospital_management_page.dart';
import 'package:app_well_mate/screen/upload_img_avt.dart';
import 'package:app_well_mate/utils/app.colors.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditInfomationUser extends StatefulWidget {
  const EditInfomationUser({super.key});

  @override
  State<EditInfomationUser> createState() => _EditInfomationUserState();
}

class _EditInfomationUserState extends State<EditInfomationUser> {
  final TextEditingController addressController = TextEditingController();
  final TextEditingController weightController = TextEditingController();
  final TextEditingController genderController = TextEditingController();
  final TextEditingController heightController = TextEditingController();
  final TextEditingController birthDayController = TextEditingController();

  DateTime? selectedDate;
  String avatarPath = 'assets/images/avtUser.png';
  final ImagePicker picker = ImagePicker();
  bool isApiCallprocess = false;

  late Future<bool> futureUpdateProfile;

  @override
  void initState() {
    super.initState();
  }

  Future<void> pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        avatarPath = image.path;
      });
    }
  }

  Future<void> updateProfile() async {
    setState(() {
      isApiCallprocess = true;
    });

    ProfileModel profile = ProfileModel(
        height: int.parse(heightController.text),
        weight: int.parse(weightController.text),
        gender: "nam",
        age: int.parse(birthDayController.text),
        address: addressController.text,
        avtUser: avatarPath);
    ApiRepo apiRepo = ApiRepo();
    bool success = await apiRepo.updateProfile(profile, avatarPath);

    setState(() {
      isApiCallprocess = false;
    });

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(success ? "cập nhật thành công!" : "cập nhật thất bại!"),
      backgroundColor: success ? AppColors.primaryColor : colorScheme.error,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 2 / 5,
                decoration: const BoxDecoration(
                  gradient: const LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Color(0xff6a94ff), Colors.white],
                  ),
                  // color: colorScheme.surface),
                ),
              ),
              Expanded(
                  child: Container(
                color: colorScheme.surface,
              ))
            ],
          ),
        ),
        Scaffold(
          // backgroundColor: Colors.white,
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            // backgroundColor: Colors.white,
            backgroundColor: colorScheme.surface.withAlpha(100),
            titleSpacing: 0,
            title: const Text(
              'Chỉnh sửa thông tin cá nhân',
            ),
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.only(bottom: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    const SizedBox(
                      height: 16,
                    ),
                    Center(
                      child: Stack(
                        children: [
                          if (isApiCallprocess)
                            Center(
                              child: LoadingAnimationWidget.flickr(
                                leftDotColor: colorScheme.primary,
                                rightDotColor: colorScheme.error,
                                size: 48,
                              ),
                            ),
                          // Hình ảnh AVT
                          CircleAvatar(
                            radius: 80,
                            backgroundImage: FileImage(File(avatarPath)),
                            child: avatarPath.isEmpty
                                ? const Icon(Icons.person, size: 50)
                                : null,
                          ),
                          // Biểu tượng "edit" nằm trên hình ảnh AVT
                          Positioned(
                            bottom: 2,
                            right: -16,
                            child: RawMaterialButton(
                              onPressed: pickImage,
                              elevation: 2.0,
                              fillColor: const Color(0xFFF5F6F9),
                              padding: const EdgeInsets.all(15.0),
                              shape: const CircleBorder(),
                              child: const Icon(
                                Icons.edit,
                                color: AppColors.primaryColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Container(
                      alignment: Alignment.center,
                      child: Text(
                        'Trần Thanh Duy',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      'Đăng kí ngày : 23-06-2024',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      'Mã người dùng : 000043',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 16,
                      ),
                      Text(
                        "Địa chỉ",
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      TextField(
                        controller: addressController,
                        decoration: const InputDecoration(
                          hintText:
                              '84 Thành Thái, Phường 10, Quận 10, TP. Hồ Chí Minh',
                          hintStyle: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                            fontStyle: FontStyle.normal,
                            color: Color.fromARGB(255, 206, 206, 206),
                          ),
                          contentPadding:
                              EdgeInsets.symmetric(vertical: 10, horizontal: 0),
                          border: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: AppColors.primaryColor,
                              width: 2,
                            ),
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: AppColors.greyColor,
                              width: 2,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Text(
                        "Giới tính",
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      TextField(
                        controller: genderController,
                        decoration: const InputDecoration(
                          hintText: 'Nam',
                          hintStyle: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                            fontStyle: FontStyle.normal,
                            color: Color.fromARGB(255, 206, 206, 206),
                          ),
                          contentPadding:
                              EdgeInsets.symmetric(vertical: 10, horizontal: 0),
                          border: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: AppColors.primaryColor,
                              width: 2,
                            ),
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: AppColors.greyColor,
                              width: 2,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Text(
                        "Cân nặng",
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      TextField(
                        controller: weightController,
                        decoration: const InputDecoration(
                          hintText: '65',
                          suffixText: 'kg',
                          hintStyle: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                            fontStyle: FontStyle.normal,
                            color: Color.fromARGB(255, 206, 206, 206),
                          ),
                          contentPadding:
                              EdgeInsets.symmetric(vertical: 10, horizontal: 0),
                          border: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: AppColors.primaryColor,
                              width: 2,
                            ),
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: AppColors.greyColor,
                              width: 2,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Text(
                        "Chiều cao",
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      TextField(
                        controller: heightController,
                        decoration: const InputDecoration(
                          hintText: '180',
                          suffixText: 'cm',
                          hintStyle: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                            fontStyle: FontStyle.normal,
                            color: Color.fromARGB(255, 206, 206, 206),
                          ),
                          contentPadding:
                              EdgeInsets.symmetric(vertical: 10, horizontal: 0),
                          border: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: AppColors.primaryColor,
                              width: 2,
                            ),
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: AppColors.greyColor,
                              width: 2,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Text(
                        'Tuổi',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      // TextFormField(
                      //   controller: birthDayController,
                      //   onTap: () {
                      //     _selectDate(context);
                      //   },
                      //   readOnly: true,
                      //   decoration: const InputDecoration(
                      //     hintText: 'Chọn ngày sinh',
                      //     hintStyle: TextStyle(
                      //       fontSize: 14,
                      //       fontWeight: FontWeight.normal,
                      //       fontStyle: FontStyle.normal,
                      //       color: Color.fromARGB(255, 206, 206, 206),
                      //     ),
                      //     suffixIcon: Icon(Icons.calendar_month),
                      //     contentPadding:
                      //         EdgeInsets.symmetric(vertical: 10, horizontal: 0),
                      //     border: UnderlineInputBorder(
                      //       borderSide: BorderSide(
                      //         color: AppColors.primaryColor,
                      //         width: 2,
                      //       ),
                      //     ),
                      //     enabledBorder: UnderlineInputBorder(
                      //       borderSide: BorderSide(
                      //         color: AppColors.greyColor,
                      //         width: 2,
                      //       ),
                      //     ),
                      //   ),
                      // ),
                      TextField(
                        controller: birthDayController,
                        decoration: const InputDecoration(
                          hintText: '20',
                          hintStyle: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                            fontStyle: FontStyle.normal,
                            color: Color.fromARGB(255, 206, 206, 206),
                          ),
                          contentPadding:
                              EdgeInsets.symmetric(vertical: 10, horizontal: 0),
                          border: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: AppColors.primaryColor,
                              width: 2,
                            ),
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: AppColors.greyColor,
                              width: 2,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Center(
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
                            child: Container(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 0, vertical: 12),
                                child: ElevatedButton(
                                  onPressed: updateProfile,
                                  child: const Text(
                                    'Cập nhật',
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
