import 'package:app_well_mate/components/info_component.dart';
import 'package:app_well_mate/components/item_drug_cart_detail.dart';
import 'package:app_well_mate/providers/cart_page_provider.dart';
import 'package:app_well_mate/utils/util.dart';
import 'package:flutter/material.dart';
import 'package:app_well_mate/screen/drug/medicine_order/medicines_order_main.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:provider/provider.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  //model cho gio hang hien thi
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<CartPageProvider>(context, listen: false).fetchDrugCart();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Giỏ hàng'),
        actions: [
          IconButton(
              onPressed: () {
                Provider.of<CartPageProvider>(context, listen: false)
                    .toggleAllChecks();
              },
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
                        child: ErrorInfo(
                        title: "Không có sản phẩm nào trong giỏ hàng",
                        subtitle: "Vui lòng thêm một sản phẩm vào giỏ",
                        icon: Symbols.shopping_cart_off,
                      ))
                    : ListView.builder(
                        itemCount: value.listDrugCart.length,
                        itemBuilder: (context, index) {
                          var item = value.listDrugCart[index];
                          return itemDrugCartDetail(
                            item: item,
                            value: value,
                            index: index,
                          );
                        },
                      ),
              ),
              //           //PHAN NAY TINH TONG TIEN
              SizedBox(
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 16),
                      Text(
                        'Tổng tiền: ',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      Text(
                        convertCurrency(value.totalPrice),
                        style: Theme.of(context).textTheme.displayMedium,
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: ElevatedButton(
                          onPressed: value.listChecked.isEmpty
                              ? null
                              : () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const MedicinesOrder(),
                                    ),
                                  );
                                },
                          child: const Text('Mua thuốc'),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
