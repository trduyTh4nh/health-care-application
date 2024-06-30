import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class EmergencyCall extends StatelessWidget {
  const EmergencyCall({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(18),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                children: [
                  Container(
                    width: 250,
                    child: Lottie.asset('assets/images/customer_service.json'),
                    alignment: Alignment.center,
                  ),
                  Padding(
                      padding: EdgeInsets.zero,
                      child: Text("Gọi khẩn cấp",
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.headlineLarge)),
                  Padding(
                      padding: const EdgeInsets.all(12),
                      child: Text(
                          "Ấn nút dưới đây trong 5 giây để gọi khẩn cấp đến bệnh viện của bạn",
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.labelSmall)),
                ],
              ),
              InkWell(
                onTap: () {},
                child: Container(
                  child: Lottie.asset('assets/images/sos.json'),
                  alignment: Alignment.center,
                  width: 350,
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text(
                      "Bệnh viện: Bệnh viện Đại học Y Dược Thành phố Hồ Chí Minh",
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyMedium),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
