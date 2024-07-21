import 'package:app_well_mate/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class InfoPage extends StatelessWidget {
  const InfoPage({super.key});
  Future<PackageInfo> getVer() async {
    return await PackageInfo.fromPlatform();
  }

  Future<void> _launchUrl(String url) async {
    Uri uri = Uri.parse(url);
    if (!await launchUrl(uri)) {}
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Expanded(
            child: Container(
          decoration: BoxDecoration(color: colorScheme.surface),
        )),
        Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xffFF7D6B), Colors.white],
          )),
          height: MediaQuery.of(context).size.height * 1 / 2,
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: colorScheme.surface.withAlpha(100),
          ),
          body: FutureBuilder(
              future: getVer(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: LoadingAnimationWidget.flickr(
                                            leftDotColor: colorScheme.primary,
                                            rightDotColor: colorScheme.error,
                                            size: 48,
                                          ),
                  );
                }
                if (snapshot.data == null) {
                  return Center(
                    child: LoadingAnimationWidget.flickr(
                                            leftDotColor: colorScheme.primary,
                                            rightDotColor: colorScheme.error,
                                            size: 48,
                                          ),
                  );
                }
                return SingleChildScrollView(
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset("assets/images/banner.svg"),
                          Text("Phiên bản ${snapshot.data!.version}"),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Expanded(
                                  child: FilledButton.icon(
                                      onPressed: () {
                                        _launchUrl(
                                            "https://github.com/trduyTh4nh/health-care-application");
                                      },
                                      label: SvgPicture.asset(
                                          "assets/images/github_logo.svg"))),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Toàn bộ mã nguồn của dự án này được đăng tải công khai trên GitHub",
                            textAlign: TextAlign.center,
                            style:
                                GoogleFonts.inter(fontWeight: FontWeight.bold),
                          ),
                          TextButton(
                              onPressed: () {},
                              child: Text(
                                "Xem giấy phép nguồn mở",
                                textAlign: TextAlign.center,
                                style: GoogleFonts.inter(
                                    fontWeight: FontWeight.bold),
                              )),
                          const SizedBox(
                            height: 20,
                          ),
                          const Text("Xin trân trọng cảm ơn team",
                              textAlign: TextAlign.center),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Wrap(
                                  alignment: WrapAlignment.center,
                                  spacing: 10,
                                  runSpacing: 10,
                                  children: [
                                    InkWell(
                                      onTap: () => _launchUrl(
                                          "https://github.com/trduyTh4nh"),
                                      child: const Material(
                                        elevation: 10,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(100)),
                                        child: CircleAvatar(
                                          backgroundImage: AssetImage(
                                              "assets/images/thanh_avt.jpeg"),
                                        ),
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () => _launchUrl(
                                          "https://github.com/wu4ngg"),
                                      child: const Material(
                                        elevation: 10,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(100)),
                                        child: CircleAvatar(
                                          backgroundImage: AssetImage(
                                              "assets/images/quang_avt.jpeg"),
                                        ),
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () => _launchUrl(
                                          "https://github.com/NguyenexDuy"),
                                      child: const Material(
                                        elevation: 10,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(100)),
                                        child: CircleAvatar(
                                          backgroundImage: AssetImage(
                                              "assets/images/avt_duy.jpeg"),
                                        ),
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () => _launchUrl(
                                          "https://github.com/PhatNgo03"),
                                      child: const Material(
                                        elevation: 10,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(100)),
                                        child: CircleAvatar(
                                          backgroundImage: AssetImage(
                                              "assets/images/phat_avt.jpeg"),
                                        ),
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () => _launchUrl(
                                          "https://github.com/Blackherro"),
                                      child: const Material(
                                        elevation: 10,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(100)),
                                        child: CircleAvatar(
                                          backgroundImage: AssetImage(
                                              "assets/images/vinh_avt.jpeg"),
                                        ),
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () => _launchUrl(
                                          "https://github.com/tuanhuynh0209"),
                                      child: const Material(
                                        elevation: 10,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(100)),
                                        child: CircleAvatar(
                                          backgroundImage: AssetImage(
                                              "assets/images/tuan_avt.jpeg"),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                );
              }),
        ),
      ],
    );
  }
}
