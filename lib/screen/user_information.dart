import 'dart:ui';

import 'package:app_well_mate/api/auth/api_repo.dart';
import 'package:app_well_mate/model/user_info_model.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:app_well_mate/main.dart';
import 'package:app_well_mate/screen/edit_infomation_user.dart';

class UserInformation extends StatefulWidget {
  UserInformation({super.key});
  @override
  State<UserInformation> createState() => _UserInformationState();
}

class _UserInformationState extends State<UserInformation> {
  Future<InfoUserModel?>? userInfoFuture;
  final ApiRepo apiRepo = ApiRepo();

  double calculateBMI(int weightm, int heightInCm) {
    double heightInMeters = heightInCm / 100.0;
    return weightm / (heightInMeters * heightInMeters);
  }

  InfoUserModel? userInfomation;

  @override
  void initState() {
    super.initState();
    userInfoFuture = apiRepo.getInfoUser();
    userInfoFuture?.then((value) {
      if (value != null && value.profile != null) {
        userInfomation = value;
        print("Weight: ${value.profile!.weight ?? 'N/A'}");
      } else {
        print("User info or profile is null");
      }
    }).catchError((e) => print('Lỗi: $e'));
  }

  void refeshPage() {
    setState(() {
      userInfoFuture = apiRepo.getInfoUser();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(color: colorScheme.surface),
          // Use Positioned or Align to place this element correctly
        ),
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          height: MediaQuery.of(context).size.height * 2.5 / 4,
          child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xff6a94ff), Colors.white],
              ),
            ),
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            title: Text(
              "Thông tin người dùng",
              style: Theme.of(context).textTheme.titleLarge,
            ),
            toolbarHeight: 50.0,
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
          body: FutureBuilder<InfoUserModel?>(
            future: userInfoFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Lỗi khi tải thông tin người dùng'));
              } else if (!snapshot.hasData) {
                return Center(child: Text('Không có thông tin người dùng'));
              } else {
                InfoUserModel userInfo = snapshot.data!;
                userInfomation = snapshot.data!;

                double bmi = 0.0;
                if (userInfo.profile?.weight != null &&
                    userInfo.profile?.height != null) {
                  bmi = calculateBMI(
                      userInfo.profile!.weight!, userInfo.profile!.height!);
                }
                return SingleChildScrollView(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: const EdgeInsets.all(10),
                          child: Stack(
                            children: [
                              Positioned.fill(
                                child: BackdropFilter(
                                  filter:
                                      ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                                  child: Container(
                                    color: Colors.transparent,
                                  ),
                                ),
                              ),
                              Center(
                                child: Hero(
                                  tag: "01",
                                  child: CircleAvatar(
                                    radius: 60,
                                    backgroundImage:
                                        NetworkImage(userInfo.profile!.avatar!),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.8),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            children: [
                              Hero(
                                tag: "02",
                                child: Text(
                                  userInfo.profile?.fullName ?? 'N/A',
                                  style: Theme.of(context).textTheme.titleLarge,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Hero(
                                tag: "03",
                                child: Text(
                                  userInfo.userName ?? 'N/A',
                                  style: Theme.of(context).textTheme.titleLarge,
                                ),
                              ),
                              const SizedBox(height: 10),
                              const SizedBox(height: 16),
                              Row(
                                children: [
                                  Expanded(
                                    child: ElevatedButton(
                                      style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                          Theme.of(context)
                                              .colorScheme
                                              .surfaceDim,
                                        ),
                                        shape: MaterialStateProperty.all(
                                          RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            side: BorderSide(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .onSurface,
                                              width: 2,
                                            ),
                                          ),
                                        ),
                                      ),
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                EditInfomationUser(
                                              infoModel: userInfomation!,
                                            ),
                                          ),
                                        );
                                      },
                                      child: Text(
                                        "Chỉnh sửa thông tin cá nhân",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.8),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Thông tin cá nhân",
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                              const SizedBox(height: 16),
                              Row(
                                children: [
                                  const Icon(Symbols.email),
                                  const SizedBox(width: 10),
                                  const Text("Email: "),
                                  Text(userInfo.email ?? 'N/A')
                                ],
                              ),
                              const SizedBox(height: 16),
                              Row(
                                children: [
                                  const Icon(Symbols.email),
                                  const SizedBox(width: 10),
                                  const Text("Họ Tên: "),
                                  Text(userInfo.profile?.fullName ?? 'N/A')
                                ],
                              ),
                              const SizedBox(height: 16),
                              Row(
                                children: [
                                  const Icon(Symbols.email),
                                  const SizedBox(width: 10),
                                  const Text("Số điện thoại: "),
                                  Text(userInfo.profile?.phone ?? 'N/A')
                                ],
                              ),
                              const SizedBox(height: 16),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 1),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            const Icon(Symbols.monitor_weight),
                                            const SizedBox(width: 10),
                                            const Text("Cân nặng: "),
                                            Text(
                                              "${userInfo.profile?.weight ?? 'N/A'} kg",
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 16),
                                        Row(
                                          children: [
                                            const Icon(Symbols.height),
                                            const SizedBox(width: 10),
                                            const Text("Chiều cao: "),
                                            Text(
                                              "${userInfo.profile?.height ?? 'N/A'} cm",
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          "BMI: ",
                                          style: Theme.of(context)
                                              .textTheme
                                              .displaySmall,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        Text(
                                          bmi.toStringAsFixed(1),
                                          style: Theme.of(context)
                                              .textTheme
                                              .displaySmall,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 16),
                              Row(
                                children: [
                                  const Icon(Symbols.cake),
                                  const SizedBox(width: 10),
                                  const Text("Tuổi hiện tại: "),
                                  Text(
                                    "${userInfo.profile?.age ?? 'N/A'} tuổi",
                                  ),
                                ],
                              ),
                              const SizedBox(height: 16),
                              Row(
                                children: [
                                  const Icon(Symbols.wc),
                                  const SizedBox(width: 10),
                                  const Text("Giới tính: "),
                                  Text(
                                    userInfo.profile?.gender?.trim() == "Nam"
                                        ? "Nam"
                                        : "Nữ",
                                  ),
                                ],
                              ),
                              const SizedBox(height: 16),
                              Row(
                                children: [
                                  const Icon(Symbols.home_pin),
                                  const SizedBox(width: 10),
                                  const Text("Địa chỉ: "),
                                  Flexible(
                                    child: Text(
                                      "${userInfo.profile?.address ?? 'N/A'}",
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 16),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }
            },
          ),
        ),
      ],
    );
  }
}
