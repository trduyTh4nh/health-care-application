import 'package:flutter/material.dart';

class Policy extends StatefulWidget {
  const Policy({super.key});

  @override
  State<Policy> createState() => _PolicyState();
}

class _PolicyState extends State<Policy> {
  var dk1 =
      "Mô tả ngắn gọn: Ứng dụng sức khỏe của chúng tôi cung cấp các công cụ và dịch vụ để theo dõi, quản lý và cải thiện sức khỏe của bạn, bao gồm theo dõi hoạt động thể chất, quản lý dinh dưỡng, giám sát sức khỏe tim mạch và hỗ trợ tinh thần.";
  var dk2 =
      "Chấp nhận: Bằng việc tải xuống, cài đặt và sử dụng ứng dụng, bạn đồng ý tuân thủ các điều khoản và điều kiện này.";
  var dk3 =
      "Quyền sử dụng: Bạn được cấp quyền không độc quyền, không thể chuyển nhượng để sử dụng ứng dụng này cho mục đích cá nhân, phi thương mại";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: const Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Điều khoản",
              ),
            ],
          ),
        ),
        backgroundColor: Colors.white,
        body: ListView(
          padding: const EdgeInsets.all(24),
          children: [
            PolicyItem(
              title: "Điều khoản 1",
              content: dk1,
            ),
            SizedBox(
              height: 20,
            ),
            PolicyItem(
              title: "Điều Khoản 2",
              content: dk2,
            ),
            SizedBox(
              height: 20,
            ),
            PolicyItem(title: "Điều khoản 3", content: dk3),
          ],
        ));
  }
}

class PolicyItem extends StatelessWidget {
  final String title;
  final String content;

  const PolicyItem({
    required this.title,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        SizedBox(height: 8),
        Text(
          content,
          style: const TextStyle(
            fontSize: 16,
          ),
        ),
      ],
    );
  }
}
