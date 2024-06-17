import 'package:flutter/material.dart';

class WidgetCompleteMedicine extends StatefulWidget {
  const WidgetCompleteMedicine({super.key});

  @override
  State<WidgetCompleteMedicine> createState() => _WidgetCompleteMedicine();
}

class _WidgetCompleteMedicine extends State<WidgetCompleteMedicine> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            Row(
              children: [
                Icon(Icons.ac_unit_outlined),
                SizedBox(
                  width: 15,
                ),
                Expanded(
                  child: Container(
                    width: double.infinity,
                    child: Text(
                      "Đơn thuốc đang được chuẩn bị bởi nhà thuốc",
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge!
                          .copyWith(fontSize: 24),
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
