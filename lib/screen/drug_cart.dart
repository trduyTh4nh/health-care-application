import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:app_well_mate/model/drug_model.dart';
import 'package:app_well_mate/model/drug_cart_model.dart';
import 'package:app_well_mate/screen/drug/medicine_order/medicines_order_main.dart';

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final List<DrugCartModel> _cartItems = listDrugCartModel;
  final List<DrugModel> _drugs = generateSampleDrugs();
  final Set<int> _selectedCartItems = {};

  late double _totalPrice;

  @override
  void initState() {
    super.initState();
    _calculateTotalPrice();
  }

  void _calculateTotalPrice() {
    _totalPrice = _selectedCartItems.fold(
        0,
        (sum, idCart) =>
            sum +
            (_findDrugById(idCart)?.price ?? 0) *
                (_cartItems
                        .firstWhere((item) => item.idCart == idCart)
                        .quantity ??
                    0));
  }

  DrugModel? _findDrugById(int id) {
    try {
      return _drugs.firstWhere((drug) => drug.idDrug == id);
    } catch (e) {
      return null; // Trả về null nếu không tìm thấy
    }
  }

  void _toggleSelection(int idCart) {
    setState(() {
      if (_selectedCartItems.contains(idCart)) {
        _selectedCartItems.remove(idCart);
      } else {
        _selectedCartItems.add(idCart);
      }
      _calculateTotalPrice();
    });
  }

  void _incrementQuantity(DrugCartModel item) {
    setState(() {
      item.quantity = item.quantity! + 1;
      if (_selectedCartItems.contains(item.idCart)) {
        _calculateTotalPrice();
      }
    });
  }

  void _decrementQuantity(DrugCartModel item) {
    setState(() {
      if (item.quantity! > 1) {
        item.quantity = item.quantity! - 1;
        if (_selectedCartItems.contains(item.idCart)) {
          _calculateTotalPrice();
        }
      }
    });
  }

  void _selectAllItems() {
    setState(() {
      if (_selectedCartItems.length == _cartItems.length) {
        _selectedCartItems.clear();
      } else {
        _selectedCartItems.addAll(_cartItems.map((item) => item.idCart!));
      }
      _calculateTotalPrice();
    });
  }

  void _removeItem(DrugCartModel item) {
    setState(() {
      _cartItems.remove(item);
      _selectedCartItems.remove(item.idCart!);
      _calculateTotalPrice();
    });
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
                _selectAllItems();
              },
              icon: const Badge(
                  child: Icon(Icons.checklist),
                  smallSize: 0 /*và 5*/,
                  largeSize: 0)),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: _cartItems.length,
                itemBuilder: (context, index) {
                  final item = _cartItems[index];
                  final drug = _findDrugById(item.idCart!);

                  return Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.only(
                            left: 4.0, top: 8.0, right: 4.0, bottom: 8.0),
                        child: Row(
                          children: [
                            Checkbox(
                              value: _selectedCartItems.contains(item.idCart),
                              onChanged: (_) => _toggleSelection(item.idCart!),
                            ),
                            const SizedBox(width: 8),
                            Image.network(
                              drug!.drugImage ?? '',
                              width: 50,
                              height: 50,
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(drug.name ?? '',
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold)),
                                  const SizedBox(height: 4),
                                  Text(_formatCurrency(drug.price ?? 0),
                                      style:
                                          const TextStyle(color: Colors.grey)),
                                ],
                              ),
                            ),
                            const SizedBox(width: 8),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Colors.grey[200],
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    iconSize: 15.0,
                                    icon: const Icon(
                                      Icons.arrow_back_ios_new_rounded,
                                    ),
                                    onPressed: () => _decrementQuantity(item),
                                  ),
                                  Text('${item.quantity}',
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold)),
                                  IconButton(
                                    iconSize: 15.0,
                                    icon: const Icon(
                                        Icons.arrow_forward_ios_rounded),
                                    onPressed: () => _incrementQuantity(item),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text("Vi",
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            SizedBox(width: 8),
                            IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: () => _removeItem(item),
                            ),
                          ],
                        ),
                      ),
                      Divider(),
                    ],
                  );
                },
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Tổng tiền: ${_formatCurrency(_totalPrice)}',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _selectedCartItems.isEmpty
                  ? null
                  : () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const MedicinesOrder(),
                        ),
                      );
                    },
              child: Text('Mua thuốc'),
              // style: ElevatedButton.styleFrom(
              //   minimumSize: Size(double.infinity, 48),
              // ),
            ),
          ],
        ),
      ),
    );
  }
}
