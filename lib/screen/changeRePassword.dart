import 'package:app_well_mate/utils/app.colors.dart';
import 'package:flutter/material.dart';

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
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('Đổi mật khẩu'),
          ],
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(4),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 64,
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Mật khẩu hiện tại',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  TextField(
                    onChanged: (value) {
                      print(value);
                    },
                    controller: passCurrentController,
                    decoration: const InputDecoration(
                      hintText: '********************',
                      hintStyle: TextStyle(
                          fontSize: 16,
                          color: Color.fromARGB(255, 165, 165, 165)),
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                      border: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: 3),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide:
                            BorderSide(color: AppColors.primaryColor, width: 3),
                      ),
                      enabledBorder: UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: AppColors.greyColor, width: 2)),
                    ),
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                  const Text(
                    "Mật khẩu mới",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  TextField(
                    onChanged: (value) {
                      print(value);
                    },
                    controller: newPassController,
                    decoration: const InputDecoration(
                      hintText: '********************',
                      hintStyle: TextStyle(
                          fontSize: 16,
                          color: Color.fromARGB(255, 165, 165, 165)),
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                      border: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: 3),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide:
                            BorderSide(color: AppColors.primaryColor, width: 3),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide:
                            BorderSide(color: AppColors.greyColor, width: 2),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                  const Text(
                    "Nhập lại mật khẩu",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  TextField(
                    onChanged: (value) {
                      print(value);
                    },
                    controller: newRepassController,
                    decoration: const InputDecoration(
                        hintText: '********************',
                        hintStyle: TextStyle(
                            fontSize: 16,
                            color: Color.fromARGB(255, 165, 165, 165)),
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
                        )),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {},
                      child: const Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 0, vertical: 12),
                        child: Text(
                          'Cập nhật',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryColor,
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
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
    );
  }
}
