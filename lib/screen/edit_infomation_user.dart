import 'dart:io';

import 'package:app_well_mate/api/auth/api_repo.dart';
import 'package:app_well_mate/main.dart';
import 'package:app_well_mate/model/profile_model.dart';
import 'package:app_well_mate/model/user_info_model.dart';
import 'package:app_well_mate/screen/user_information.dart';
import 'package:app_well_mate/utils/app.colors.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class EditInfomationUser extends StatefulWidget {
  EditInfomationUser({super.key, required this.infoModel});
  final InfoUserModel infoModel;
  @override
  State<EditInfomationUser> createState() => _EditInfomationUserState();
}

class _EditInfomationUserState extends State<EditInfomationUser> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
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

  String? fullName;
  String? userName;
  InfoUserModel? userInfomation;
  Future<void>? future;

  Future<void> fetchData() async {
    var userInfo = await ApiRepo().getInfoUser();
    if (userInfo != null) {
      // userInfomation = userInfo;
      fullName = userInfo.profile?.fullName ?? '';

      setState(() {
        userInfomation = userInfo;
        userName = userInfo.userName;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    print("User Name: ${widget.infoModel.userName}");
    fullNameController.text = widget.infoModel.profile!.fullName ?? '';
    phoneController.text = widget.infoModel.profile!.phone ?? '';
    addressController.text = widget.infoModel.profile!.address ?? '';
    weightController.text = widget.infoModel.profile!.weight?.toString() ?? '';
    genderController.text = widget.infoModel.profile!.gender ?? '';
    heightController.text = widget.infoModel.profile!.height?.toString() ?? '';
    birthDayController.text = widget.infoModel.profile!.age?.toString() ?? '';
    if (widget.infoModel.profile!.avatar != null &&
        widget.infoModel.profile!.avatar!.isNotEmpty) {
      avatarPath = widget.infoModel.profile!.avatar!;
    }
    // future = fetchData();
  }

  File? file;
  Future<void> pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        file = File.fromUri(Uri.parse(image.path));
        avatarPath = image.path;
      });
    }
  }

  Future<void> updateProfile() async {
    if (_formkey.currentState?.validate() ?? false) {
      setState(() {
        isApiCallprocess = true;
      });

      ProfileModel profile = ProfileModel(
          fullName: fullNameController.text,
          phone: phoneController.text,
          height: int.parse(heightController.text),
          weight: int.parse(weightController.text),
          gender: genderController.text,
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
      // widget.refeshPage!();
      Navigator.pop(context);
    }
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
            child: Form(
              key: _formkey,
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
                            // Hình ảnh AVT
                            CircleAvatar(
                              radius: 80,
                              backgroundImage: file == null
                                  ? NetworkImage(avatarPath)
                                  : FileImage(file!),
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
                          // 'Trần Thanh Duy',
                          // fullName ?? "Full Name",
                          fullNameController.text.isNotEmpty
                              ? fullNameController.text
                              : "Full name",
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ),
                      const SizedBox(
                        height: 8,
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
                          "Họ Tên",
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        TextFormField(
                          controller: fullNameController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Vui lòng nhập họ tên!";
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                            hintText: 'Nguyễn Văn A..',
                            hintStyle: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.normal,
                              fontStyle: FontStyle.normal,
                              color: Color.fromARGB(255, 206, 206, 206),
                            ),
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 0),
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
                          "Số điện thoại",
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        TextFormField(
                          controller: phoneController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Vui lòng nhập số điện thoại!";
                            }
                            if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                              return "Số điện thoại không hợp lệ";
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                            hintText: '0123456789',
                            hintStyle: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.normal,
                              fontStyle: FontStyle.normal,
                              color: Color.fromARGB(255, 206, 206, 206),
                            ),
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 0),
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
                          "Địa chỉ",
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        TextFormField(
                          controller: addressController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Vui lòng nhập địa chỉ!";
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                            hintText: 'địa chỉ...',
                            hintStyle: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.normal,
                              fontStyle: FontStyle.normal,
                              color: Color.fromARGB(255, 206, 206, 206),
                            ),
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 0),
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
                        DropdownButtonFormField<String>(
                          value: genderController.text.isNotEmpty
                              ? (['Nam', 'Nữ'].contains(genderController.text)
                                  ? genderController.text
                                  : null)
                              : null,
                          onChanged: (String? newValue) {
                            setState(() {
                              genderController.text = newValue ?? '';
                            });
                          },
                          items: <String>['Nam', 'Nữ']
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Vui lòng chọn giới tính!";
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                            hintText: 'Chọn giới tính',
                            hintStyle: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 0, 0, 0),
                            ),
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 0),
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
                        TextFormField(
                          controller: weightController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Vui lòng nhập cân nặng!";
                            }
                            final int? weight = int.tryParse(value);
                            if (weight == null) {
                              return "Vui lòng nhập cân nặng là số! vd : 65...";
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                            hintText: '65',
                            suffixText: 'kg',
                            suffixStyle: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 0, 0, 0),
                            ),
                            hintStyle: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.normal,
                              fontStyle: FontStyle.normal,
                              color: Color.fromARGB(255, 206, 206, 206),
                            ),
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 0),
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
                        TextFormField(
                          controller: heightController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Vui lòng nhập chiều cao!";
                            }
                            final int? height = int.tryParse(value);
                            if (height == null) {
                              return "Vui lòng nhập chiều cao là số! vd : 165";
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                            hintText: '180',
                            suffixText: 'cm',
                            suffixStyle: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 0, 0, 0),
                            ),
                            hintStyle: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.normal,
                              fontStyle: FontStyle.normal,
                              color: Color.fromARGB(255, 206, 206, 206),
                            ),
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 0),
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
                        TextFormField(
                          controller: birthDayController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Vui lòng nhập tuổi của bạn!";
                            }
                            final int? height = int.tryParse(value);
                            if (height == null) {
                              return "Vui lòng nhập tuổi là số! vd : 20";
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                            hintText: '20',
                            suffixText: 'tuổi',
                            suffixStyle: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 0, 0, 0),
                            ),
                            hintStyle: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.normal,
                              fontStyle: FontStyle.normal,
                              color: Color.fromARGB(255, 206, 206, 206),
                            ),
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 0),
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
                            child: Container(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 0, vertical: 12),
                                child: ElevatedButton(
                                  onPressed: updateProfile,
                                  child: isApiCallprocess
                                      ? Center(
                                          child: LoadingAnimationWidget.flickr(
                                            leftDotColor: colorScheme.surface,
                                            rightDotColor: colorScheme.error,
                                            size: 48,
                                          ),
                                        )
                                      : const Text(
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
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
