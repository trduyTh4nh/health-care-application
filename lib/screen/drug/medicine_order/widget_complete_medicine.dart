import 'package:app_well_mate/components/item_complete.dart';
import 'package:app_well_mate/providers/cart_page_provider.dart';
import 'package:app_well_mate/main.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';

enum MedicationItemAction { delete, edit, snooze, buy, confirm }

class WidgetCompleteMedicine extends StatefulWidget {
  const WidgetCompleteMedicine({super.key});

  @override
  State<WidgetCompleteMedicine> createState() => _WidgetCompleteMedicine();
}

class _WidgetCompleteMedicine extends State<WidgetCompleteMedicine> {
  bool isChecked = false;

  String getAdress(String name) {
    final splitString = name.split(",");
    final addressTrue = "${splitString[0]} ${splitString[1]}";
    return addressTrue;
  }

  @override
  Widget build(BuildContext context) {
    final sizeHeight = MediaQuery.of(context).size.height;

    return Consumer<CartPageProvider>(builder: (context, value, child) {
      return Scaffold(
        body: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 24,
                            height: 24,
                            child: LoadingAnimationWidget.flickr(
                              leftDotColor: colorScheme.primary,
                              rightDotColor: colorScheme.error,
                              size: 32,
                            ),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Expanded(
                            child: SizedBox(
                              width: double.infinity,
                              child: Text(
                                "Đang đợi thanh toán",
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge!
                                    .copyWith(fontSize: 24),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Consumer<CartPageProvider>(
                        builder: (context, value, child) {
                      return SizedBox(
                        height: sizeHeight * 0.40,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: ListView.builder(
                            itemCount: value.listChecked.length,
                            itemBuilder: (context, index) {
                              var item = value.listChecked[index];
                              return Column(
                                children: [
                                  item_complete(drug: item),
                                  const Divider(),
                                ],
                              );
                            },
                          ),
                        ),
                      );
                    }),
                  ],
                ),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: Material(
                    elevation: 50,
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: value.selectedAddress != null
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text("Địa chỉ giao hàng"),
                                Text(
                                  getAdress(value.selectedAddress!.address!),
                                  style:
                                      Theme.of(context).textTheme.titleMedium,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                )
                              ],
                            )
                          : const SizedBox(),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      );
    });
  }
}
