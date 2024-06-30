import 'package:app_well_mate/utils/app.colors.dart';
import 'package:flutter/material.dart';

class EditInfomationUser extends StatefulWidget {
  const EditInfomationUser({super.key});

  @override
  State<EditInfomationUser> createState() => _EditInfomationUserState();
}

class _EditInfomationUserState extends State<EditInfomationUser> {
  final TextEditingController hoTenController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController weightController = TextEditingController();
  final TextEditingController heightController = TextEditingController();
  final TextEditingController birthDayController = TextEditingController();

  DateTime? selectedDate;
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        birthDayController.text =
            "${picked.day}-${picked.month}-${picked.year}";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
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
                Center(
                  child: Stack(
                    children: [
                      // Hình ảnh AVT
                      Image.asset(
                        'assets/images/avtUser.png',
                      ),
                      // Biểu tượng "edit" nằm trên hình ảnh AVT
                      Positioned(
                        bottom: 2,
                        right: -16,
                        child: RawMaterialButton(
                          onPressed: () {},
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
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Họ Tên',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  TextField(
                    controller: hoTenController,
                    decoration: const InputDecoration(
                      hintText: 'Trần Thanh Duy',
                      hintStyle: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                        fontStyle: FontStyle.normal,
                        color:  Color.fromARGB(255, 206, 206, 206),
                      ),
                      contentPadding: EdgeInsetsDirectional.symmetric(
                          vertical: 10, horizontal: 0),
                      border: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: 3),
                      ),
                      focusedErrorBorder: UnderlineInputBorder(
                        borderSide:
                            BorderSide(color: AppColors.primaryColor, width: 3),
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
                    "Email",
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  TextField(
                    controller: emailController,
                    decoration: const InputDecoration(
                      hintText: 'thanhduy69@gmail.com',
                      hintStyle: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                        fontStyle: FontStyle.normal,
                        color:  Color.fromARGB(255, 206, 206, 206),
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
                        color:  Color.fromARGB(255, 206, 206, 206),
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
                    "Số điện thoại",
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  TextField(
                    controller: phoneController,
                    decoration: const InputDecoration(
                      hintText: '0908291415',
                      hintStyle: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                        fontStyle: FontStyle.normal,
                        color:  Color.fromARGB(255, 206, 206, 206),
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
                        color:  Color.fromARGB(255, 206, 206, 206),
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
                        color:  Color.fromARGB(255, 206, 206, 206),
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
                    'Ngày sinh',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  TextFormField(
                    controller: birthDayController,
                    onTap: () {
                      _selectDate(context);
                    },
                    readOnly: true,
                    decoration: const InputDecoration(
                      hintText: 'Chọn ngày sinh',
                      hintStyle: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                        fontStyle: FontStyle.normal,
                        color:  Color.fromARGB(255, 206, 206, 206),
                      ),
                      suffixIcon: Icon(Icons.calendar_month),
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
