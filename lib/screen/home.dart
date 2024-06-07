import 'package:app_well_mate/components/shotcut.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const CircleAvatar(
              backgroundImage: NetworkImage(
                  "https://images-ext-1.discordapp.net/external/GzOumY3Ty-mCaQNSxtMOVR5BPLNstdlilADmc80Wfm8/%3Fsize%3D4096/https/cdn.discordapp.com/avatars/515061888258670602/69eaf1984e071ba575fe531b70b200c3.png?format=webp&quality=lossless&width=452&height=452"),
            ),
            const SizedBox(
              width: 20,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Xin chào,",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                Text("Trí Quang", style: Theme.of(context).textTheme.bodyMedium)
              ],
            )
          ],
        ),
        
      ),
      body: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text("Tác vụ nhanh")),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                    child: Shortcut(
                  icon: Icons.monitor_weight_outlined,
                  text: "Tính BMI",
                )),
                Expanded(
                    child: Shortcut(
                  icon: Icons.leaderboard_outlined,
                  text: "Theo dõi",
                )),
                Expanded(
                    child: Shortcut(
                  icon: Icons.camera_alt_outlined,
                  text: "Quét mã QR",
                )),
                Expanded(
                    child: Shortcut(
                  icon: Symbols.pill,
                  text: "Xem toa thuốc",
                )),
              ],
            ),
          ),
          Divider(
            indent: 20,
            endIndent: 20,
          )
        ],
      ),
    );
  }
}
