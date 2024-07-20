import 'package:app_well_mate/api/cart/cart_repo.dart';
import 'package:app_well_mate/components/snack_bart.dart';
import 'package:app_well_mate/providers/cart_page_provider.dart';
import 'package:app_well_mate/storage/secure_storage.dart';
import 'package:app_well_mate/utils/app.colors.dart';
import 'package:app_well_mate/utils/util.dart';
import 'package:flutter/material.dart';
import 'package:app_well_mate/screen/drug/medicine_order/medicines_order_main.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  //model cho gio hang hien thi

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Giỏ hàng'),
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Badge(
                child: Icon(Icons.checklist),
                smallSize: 0,
                largeSize: 0,
              )),
        ],
      ),
      body: Consumer<CartPageProvider>(
        builder: (context, value, child) {
          return Column(
            children: [
              Expanded(
                child: value.listDrugCart.isEmpty
                    ? const Center(
                        child: Text("Khong co san pham can thanh toan"),
                      )
                    : ListView.builder(
                        itemCount: value.listDrugCart.length,
                        itemBuilder: (context, index) {
                          var item = value.listDrugCart[index];
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Container(
                                padding: const EdgeInsets.only(
                                    left: 4.0,
                                    top: 4.0,
                                    right: 4.0,
                                    bottom: 4.0),
                                child: Row(
                                  children: [
                                    Checkbox(
                                      value: value.isChecked[index],
                                      onChanged: (bool? newValue) {
                                        value.toggleCheck(index);
                                      },
                                    ),
                                    const SizedBox(width: 8),
                                    Container(
                                      padding: const EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                          color: AppColors.greyColor,
                                          borderRadius:
                                              BorderRadius.circular(50)),
                                      child: Image.network(
                                        errorBuilder:
                                            (context, error, stackTrace) =>
                                                const Icon(Icons.image),
                                        // drug!.drugImage ?? '',
                                        item.drug!.drugImage ?? '',
                                        width: 50,
                                        height: 50,
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(item.drug!.name!,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium!
                                                  .copyWith(
                                                      fontWeight:
                                                          FontWeight.bold)),
                                          const SizedBox(height: 4),
                                          Text(convertCurrency(
                                              item.drug!.price!))
                                        ],
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Text(item.drug!.unit ?? "",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium!
                                            .copyWith(
                                                fontWeight: FontWeight.bold)),
                                    const SizedBox(width: 8),
                                    IconButton(
                                      icon: const Icon(Icons.delete),
                                      onPressed: () {
                                        value.deleteDrugCartFromCart(
                                            item.idDrugCartDetail!);
                                      },
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: AppColors.greyColor,
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                      iconSize: 15.0,
                                      icon: const Icon(
                                        Icons.arrow_back_ios_new_rounded,
                                      ),
                                      // onPressed: () async {
                                      //   await CartRepo().updateQuantityCartDetail(
                                      //       item.idDrugCartDetail!, -1);
                                      //   setState(() {
                                      //     item.quantity;
                                      //   });
                                      // },
                                      onPressed: () {
                                        item.quantity == 1
                                            ? showCustomSnackBar(context,
                                                "Bạn không thể giảm thêm được nữa")
                                            : value.updateQuantityDetial(
                                                item.idDrugCartDetail!, -1);
                                      },
                                    ),
                                    Text('${item.quantity}',
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold)),
                                    IconButton(
                                      iconSize: 15.0,
                                      icon: const Icon(
                                          Icons.arrow_forward_ios_rounded),
                                      onPressed: () {
                                        value.updateQuantityDetial(
                                            item.idDrugCartDetail!, 1);
                                      },
                                    ),
                                  ],
                                ),
                              ),
                              const Divider(),
                            ],
                          );
                        },
                      ),
              ),
              //           //PHAN NAY TINH TONG TIEN
              const SizedBox(height: 16),
              Text(
                'Tổng tiền:${convertCurrency(value.totalPrice)} ',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const MedicinesOrder(),
                    ),
                  );
                },
                child: const Text('Mua thuốc'),
              ),
            ],
          );
        },
      ),
    );
  }
}
