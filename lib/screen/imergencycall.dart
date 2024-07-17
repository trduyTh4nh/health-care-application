import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:url_launcher/url_launcher.dart';

class EmergencyCall extends StatelessWidget {
  const EmergencyCall({super.key});

  void launPhoneDialer(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }

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
                          "Ấn nút dưới đây trong 3 giây để gọi khẩn cấp đến bệnh viện của bạn",
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.labelSmall)),
                ],
              ),

              // InkWell(
              //   onTap: () {},
              //   borderRadius: BorderRadius.circular(200),
              //   child: Container(
              //     child: Lottie.asset('assets/images/sos.json'),
              //     alignment: Alignment.center,
              //     width: 350,
              //     padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
              //   ),
              // ),
              GestureDetector(
                onLongPress: () {
                  launPhoneDialer('0902832040');
                },
                child: Container(
                  child: Lottie.asset('assets/images/sos.json'),
                  alignment: Alignment.center,
                  width: 350,
                  padding: const EdgeInsets.all(0),
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
