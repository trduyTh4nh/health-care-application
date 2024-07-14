import 'package:app_well_mate/model/drug_cart_detail_model.dart';
import 'package:app_well_mate/providers/cart_page_provider.dart';
import 'package:app_well_mate/utils/app.colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:app_well_mate/screen/drug/medicine_order/medicines_order_main.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  void initState() {
    super.initState();
  }

  String _formatCurrency(double amount) {
    final format = NumberFormat.currency(locale: 'vi_VN', symbol: '₫');
    return format.format(amount);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Giỏ hàng'),
        actions: [
          IconButton(
            onPressed: () {
              Provider.of<CartPageProvider>(context, listen: false).selectAll();
            },
            icon: const Icon(Icons.select_all),
          ),
          IconButton(
            onPressed: () {
              Provider.of<CartPageProvider>(context, listen: false).deselectAll();
            },
            icon: const Icon(Icons.deselect),
          ),
        ],
      ),
      body: Consumer<CartPageProvider>(
        builder: (context, value, child) {
          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                Expanded(
                  child: value.listDrugCart.isEmpty
                      ? const Center(
                          child: Text("Không có item"),
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
                                        value: value.selectedItems.contains(index),
                                        onChanged: (selected) {
                                          Provider.of<CartPageProvider>(context, listen: false)
                                              .toggleSelection(index);
                                        },
                                      ),
                                      const SizedBox(width: 8),
                                      Container(
                                        padding: const EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                            color: AppColors.greyColor,
                                            borderRadius: BorderRadius.circular(50)),
                                        child: Image.network(
                                          item.drug!.drugImage ?? '',
                                          width: 50,
                                          height: 50,
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                                item.drug!.name ?? '',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyMedium!
                                                    .copyWith(fontWeight: FontWeight.bold)),
                                            const SizedBox(height: 4),
                                            Text(
                                                _formatCurrency(item.drug!.price ?? 0),
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyMedium!
                                                    .copyWith(color: Colors.grey)),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      Text(item.drug!.unit ?? "",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium!
                                              .copyWith(fontWeight: FontWeight.bold)),
                                      const SizedBox(width: 8),
                                      IconButton(
                                        icon: const Icon(Icons.delete),
                                        onPressed: () {
                                          Provider.of<CartPageProvider>(context, listen: false)
                                              .deleteDrugCart(index);
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
                                          icon: const Icon(Icons.arrow_back_ios_new_rounded),
                                          onPressed: () {
                                            if (item.quantity != null && item.quantity! > 1) {
                                              setState(() {
                                                item.quantity = item.quantity! - 1;
                                              });
                                            }
                                          }),
                                      Text('${item.quantity}',
                                          style: const TextStyle(fontWeight: FontWeight.bold)),
                                      IconButton(
                                          iconSize: 15.0,
                                          icon: const Icon(Icons.arrow_forward_ios_rounded),
                                          onPressed: () {
                                            setState(() {
                                              item.quantity = item.quantity! + 1;
                                            });
                                          }),
                                    ],
                                  ),
                                ),
                                const Divider(),
                              ],
                            );
                          },
                        ),
                ),
                const SizedBox(height: 16),
                Text(
                  'Tổng tiền: ${_formatCurrency(value.calculateTotalPrice())}',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: value.selectedItems.isEmpty
                      ? null
                      : () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MedicinesOrder(),
                            ),
                          );
                        },
                  child: const Text('Mua thuốc'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
