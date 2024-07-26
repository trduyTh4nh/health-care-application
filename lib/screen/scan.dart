import 'dart:developer';

import 'package:app_well_mate/api/application/application_repo.dart';
import 'package:app_well_mate/components/custom_dialog.dart';
import 'package:app_well_mate/screen/prescription_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:simple_barcode_scanner/simple_barcode_scanner.dart';

class ScanPage extends StatefulWidget {
  const ScanPage({super.key, this.automaticallyImplyLeading = false});
  final bool? automaticallyImplyLeading;
  @override
  State<ScanPage> createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> with WidgetsBindingObserver {
  ApplicationRepo repo = ApplicationRepo();
  var result;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: widget.automaticallyImplyLeading ?? false,
        ),
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 300,
              height: 300,
              child: FilledButton(
                  onPressed: () async {
                    var res = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              const SimpleBarcodeScannerPage(),
                        ));
                    if (res is String && context.mounted && res != '-1') {
                      result = res;
                      int? resInt = int.tryParse(res);
                      if (resInt == null) {
                        showDialog(
                            context: context,
                            builder: (c) => CustomDialog(
                                  icon: Symbols.close,
                                  title: "Mã vạch không hợp lệ",
                                  subtitle:
                                      "Hãy quét một mã vạch hợp lệ và thử lại",
                                  onPositive: () {},
                                  onlyOption: true,
                                  positiveText: "OK",
                                ));
                        return;
                      }
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PrescriptionPreview(
                                  idPre: int.tryParse(result) ?? -1)));
                    }
                    setState(() {});
                  },
                  child: Image.asset('assets/images/loader.gif')),
            ),
            const SizedBox(
              height: 32,
            ),
            Text(
              'Nhấn vào để quét mã đơn thuốc!',
              style: Theme.of(context).textTheme.bodyLarge,
            )
          ],
        )));
  }
}
