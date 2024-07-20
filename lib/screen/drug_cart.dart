import 'package:app_well_mate/api/auth/api_repo.dart';
import 'package:app_well_mate/api/cart/cart_repo.dart';
import 'package:app_well_mate/model/drug_cart_detail_model.dart';
import 'package:app_well_mate/model/drug_cart_model.dart';
import 'package:app_well_mate/model/drug_model.dart';
import 'package:app_well_mate/providers/cart_page_provider.dart';
import 'package:app_well_mate/storage/secure_storage.dart';
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
  //model cho gio hang hien thi
  final List<DrugCartModel> _cartItems = listDrugCartModel;
  final List<DrugModel> _drugs = generateSampleDrugs();
  final Set<int> _selectedCartItems = {};

  late double _totalPrice;

  Future<String> getAllDrugInCart() async {
    print("bat dau vo ham");
    int userId = await SecureStorage.getUserId();
    print("id user: $userId");
    return CartRepo().getAllDrugInCart(userId);
  }

  Future<List<DrugCartDetailModel>> fetchData() async {
    List<DrugCartDetailModel> item = [];
    int userId = await SecureStorage.getUserId();

    item = await CartRepo().getAllDrugInCartttt(userId);

    // for (var element in item) {
    //   print(element);
    // }
    print(item.length);

    return item;
  }

  @override
  void initState() {
    super.initState();
    _calculateTotalPrice();
    // getAllDrugInCart();
    // getAllDrug
    fetchData();
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
      return null;
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
      body: FutureBuilder(
        future: fetchData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // Trạng thái đang tải
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            // Trạng thái lỗi
            return Center(child: Text('Lỗi: ${snapshot.error}'));
          }
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      var item = snapshot.data![index];
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                            height: 100,
                            width: double.infinity,
                            color: Colors.pink[200],
                            child: Text(item.drug!.name!)),
                      );
                      // return Column(
                      //   crossAxisAlignment: CrossAxisAlignment.end,
                      //   children: [
                      //     Container(
                      //       padding: const EdgeInsets.only(
                      //           left: 4.0, top: 4.0, right: 4.0, bottom: 4.0),
                      //       child: Row(
                      //         children: [
                      //           Checkbox(
                      //             value: _selectedCartItems.contains(item.idDrug),
                      //             onChanged: (_) => _toggleSelection(item.idDrug!),
                      //           ),
                      //           const SizedBox(width: 8),
                      //           Container(
                      //             padding: const EdgeInsets.all(8),
                      //             decoration: BoxDecoration(
                      //                 color: AppColors.greyColor,
                      //                 borderRadius: BorderRadius.circular(50)),
                      //             child: Image.network(
                      //               errorBuilder: (context, error, stackTrace) =>
                      //                   Icon(Icons.image),
                      //               // drug!.drugImage ?? '',
                      //               item.drug!.drugImage ?? '',
                      //               width: 50,
                      //               height: 50,
                      //             ),
                      //           ),
                      //           const SizedBox(width: 8),
                      //           Expanded(
                      //             child: Column(
                      //               crossAxisAlignment: CrossAxisAlignment.start,
                      //               children: [
                      //                 Text(
                      //                     // drug.name ?? '',
                      //                     item.drug!.name ?? '',
                      //                     style: Theme.of(context)
                      //                         .textTheme
                      //                         .bodyMedium!
                      //                         .copyWith(fontWeight: FontWeight.bold)),
                      //                 const SizedBox(height: 4),
                      //                 Text(_formatCurrency(item.drug!.price ?? 0),
                      //                     style: Theme.of(context)
                      //                         .textTheme
                      //                         .bodyMedium!
                      //                         .copyWith(color: Colors.grey)),
                      //               ],
                      //             ),
                      //           ),
                      //           const SizedBox(width: 8),
                      //           Text(item.drug!.unit ?? "",
                      //               style: Theme.of(context)
                      //                   .textTheme
                      //                   .bodyMedium!
                      //                   .copyWith(fontWeight: FontWeight.bold)),
                      //           const SizedBox(width: 8),
                      //           IconButton(
                      //             icon: const Icon(Icons.delete),
                      //             // onPressed: () => _removeItem(item),
                      //             onPressed: () {},
                      //           ),
                      //         ],
                      //       ),
                      //     ),
                      //     Container(
                      //       decoration: BoxDecoration(
                      //         borderRadius: BorderRadius.circular(8),
                      //         color: AppColors.greyColor,
                      //       ),
                      //       child: Row(
                      //         mainAxisSize: MainAxisSize.min,
                      //         children: [
                      //           IconButton(
                      //             iconSize: 15.0,
                      //             icon: const Icon(
                      //               Icons.arrow_back_ios_new_rounded,
                      //             ),
                      //             // onPressed: () =>
                      //             //     _decrementQuantity(item),
                      //             onPressed: () {},
                      //           ),
                      //           Text('${item.quantity}',
                      //               style:
                      //                   const TextStyle(fontWeight: FontWeight.bold)),
                      //           IconButton(
                      //             iconSize: 15.0,
                      //             icon: const Icon(Icons.arrow_forward_ios_rounded),
                      //             // onPressed: () =>
                      //             //     _incrementQuantity(item),
                      //             onPressed: () {},
                      //           ),
                      //         ],
                      //       ),
                      //     ),
                      //     const Divider(),
                      //   ],
                      // );
                    }),
              ),

              //           //PHAN NAY TINH TONG TIEN
              const SizedBox(height: 16),
              Text(
                'Tổng tiền: ${_formatCurrency(_totalPrice)}',
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
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 48),

                ),
              ),
            ],
          );
        },
      ),
//       body: Consumer<CartPageProvider>(
//         builder: (context, value, child) {
//           return Padding(
//             padding: const EdgeInsets.all(10.0),
//             child: Column(
//               children: [
//                 Expanded(
//                   // child: ListView.builder(
//                   //   itemCount: _cartItems.length,
//                   //   itemBuilder: (context, index) {
//                   //     final item = _cartItems[index];
//                   //     final drug = _findDrugById(item.idCart!);

//                   //     return Column(
//                   //       crossAxisAlignment: CrossAxisAlignment.end,
//                   //       children: [
//                   //         Container(
//                   //           padding: const EdgeInsets.only(
//                   //               left: 4.0, top: 4.0, right: 4.0, bottom: 4.0),
//                   //           child: Row(
//                   //             children: [
//                   //               Checkbox(
//                   //                 value: _selectedCartItems.contains(item.idCart),
//                   //                 onChanged: (_) => _toggleSelection(item.idCart!),
//                   //               ),
//                   //               const SizedBox(width: 8),
//                   //               Container(
//                   //                 padding: const EdgeInsets.all(8),
//                   //                 decoration: BoxDecoration(
//                   //                     color: AppColors.greyColor,
//                   //                     borderRadius: BorderRadius.circular(50)),
//                   //                 child: Image.network(
//                   //                   drug!.drugImage ?? '',
//                   //                   width: 50,
//                   //                   height: 50,
//                   //                 ),
//                   //               ),
//                   //               const SizedBox(width: 8),
//                   //               Expanded(
//                   //                 child: Column(
//                   //                   crossAxisAlignment: CrossAxisAlignment.start,
//                   //                   children: [
//                   //                     Text(drug.name ?? '',
//                   //                         style: Theme.of(context)
//                   //                             .textTheme
//                   //                             .bodyMedium!
//                   //                             .copyWith(
//                   //                                 fontWeight: FontWeight.bold)),
//                   //                     const SizedBox(height: 4),
//                   //                     Text(_formatCurrency(drug.price ?? 0),
//                   //                         style: Theme.of(context)
//                   //                             .textTheme
//                   //                             .bodyMedium!
//                   //                             .copyWith(color: Colors.grey)),
//                   //                   ],
//                   //                 ),
//                   //               ),
//                   //               const SizedBox(width: 8),
//                   //               Text("Vỉ",
//                   //                   style: Theme.of(context)
//                   //                       .textTheme
//                   //                       .bodyMedium!
//                   //                       .copyWith(fontWeight: FontWeight.bold)),
//                   //               const SizedBox(width: 8),
//                   //               IconButton(
//                   //                 icon: const Icon(Icons.delete),
//                   //                 onPressed: () => _removeItem(item),
//                   //               ),
//                   //             ],
//                   //           ),
//                   //         ),
//                   //         Container(
//                   //           decoration: BoxDecoration(
//                   //             borderRadius: BorderRadius.circular(8),
//                   //             color: AppColors.greyColor,
//                   //           ),
//                   //           child: Row(
//                   //             mainAxisSize: MainAxisSize.min,
//                   //             children: [
//                   //               IconButton(
//                   //                 iconSize: 15.0,
//                   //                 icon: const Icon(
//                   //                   Icons.arrow_back_ios_new_rounded,
//                   //                 ),
//                   //                 onPressed: () => _decrementQuantity(item),
//                   //               ),
//                   //               Text('${item.quantity}',
//                   //                   style: const TextStyle(
//                   //                       fontWeight: FontWeight.bold)),
//                   //               IconButton(
//                   //                 iconSize: 15.0,
//                   //                 icon: const Icon(Icons.arrow_forward_ios_rounded),
//                   //                 onPressed: () => _incrementQuantity(item),
//                   //               ),
//                   //             ],
//                   //           ),
//                   //         ),
//                   //         const Divider(),
//                   //       ],
//                   //     );
//                   //   },
//                   // ),
//                   // child: value.listDrugCart.isEmpty
//                   //     ? const Center(
//                   //         child: Text("khong co item"),
//                   //       )
//                   child: ListView.builder(
//                     itemCount: value.listDrugCart.length,
//                     itemBuilder: (context, index) {
//                       var item = value.listDrugCart[index];
// //item
//                       return Column(
//                         crossAxisAlignment: CrossAxisAlignment.end,
//                         children: [
//                           Container(
//                             padding: const EdgeInsets.only(
//                                 left: 4.0, top: 4.0, right: 4.0, bottom: 4.0),
//                             child: Row(
//                               children: [
//                                 Checkbox(
//                                   value:
//                                       _selectedCartItems.contains(item.idDrug),
//                                   onChanged: (_) =>
//                                       _toggleSelection(item.idDrug!),
//                                 ),
//                                 const SizedBox(width: 8),
//                                 Container(
//                                   padding: const EdgeInsets.all(8),
//                                   decoration: BoxDecoration(
//                                       color: AppColors.greyColor,
//                                       borderRadius: BorderRadius.circular(50)),
//                                   child: Image.network(
//                                     errorBuilder:
//                                         (context, error, stackTrace) =>
//                                             Icon(Icons.image),
//                                     // drug!.drugImage ?? '',
//                                     item.drug!.drugImage ?? '',
//                                     width: 50,
//                                     height: 50,
//                                   ),
//                                 ),
//                                 const SizedBox(width: 8),
//                                 Expanded(
//                                   child: Column(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     children: [
//                                       Text(
//                                           // drug.name ?? '',
//                                           item.drug!.name ?? '',
//                                           style: Theme.of(context)
//                                               .textTheme
//                                               .bodyMedium!
//                                               .copyWith(
//                                                   fontWeight: FontWeight.bold)),
//                                       const SizedBox(height: 4),
//                                       Text(
//                                           _formatCurrency(
//                                               item.drug!.price ?? 0),
//                                           style: Theme.of(context)
//                                               .textTheme
//                                               .bodyMedium!
//                                               .copyWith(color: Colors.grey)),
//                                     ],
//                                   ),
//                                 ),
//                                 const SizedBox(width: 8),
//                                 Text(item.drug!.unit ?? "",
//                                     style: Theme.of(context)
//                                         .textTheme
//                                         .bodyMedium!
//                                         .copyWith(fontWeight: FontWeight.bold)),
//                                 const SizedBox(width: 8),
//                                 IconButton(
//                                   icon: const Icon(Icons.delete),
//                                   // onPressed: () => _removeItem(item),
//                                   onPressed: () {},
//                                 ),
//                               ],
//                             ),
//                           ),
//                           Container(
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(8),
//                               color: AppColors.greyColor,
//                             ),
//                             child: Row(
//                               mainAxisSize: MainAxisSize.min,
//                               children: [
//                                 IconButton(
//                                   iconSize: 15.0,
//                                   icon: const Icon(
//                                     Icons.arrow_back_ios_new_rounded,
//                                   ),
//                                   // onPressed: () =>
//                                   //     _decrementQuantity(item),
//                                   onPressed: () {},
//                                 ),
//                                 Text('${item.quantity}',
//                                     style: const TextStyle(
//                                         fontWeight: FontWeight.bold)),
//                                 IconButton(
//                                   iconSize: 15.0,
//                                   icon: const Icon(
//                                       Icons.arrow_forward_ios_rounded),
//                                   // onPressed: () =>
//                                   //     _incrementQuantity(item),
//                                   onPressed: () {},
//                                 ),
//                               ],
//                             ),
//                           ),
//                           const Divider(),
//                         ],
//                       );

//                       //phan con lai cua item
//                     },
//                   ),
//                 ),

      //           //PHAN NAY TINH TONG TIEN
      // const SizedBox(height: 16),
      // Text(
      //   'Tổng tiền: ${_formatCurrency(_totalPrice)}',
      //   style: Theme.of(context).textTheme.bodyLarge,
      // ),
      // const SizedBox(height: 16),
      // ElevatedButton(
      //   onPressed: _selectedCartItems.isEmpty
      //       ? null
      //       : () {
      //           Navigator.push(
      //             context,
      //             MaterialPageRoute(
      //               builder: (context) => const MedicinesOrder(),
      //             ),
      //           );
      //         },
      //   child: const Text('Mua thuốc'),
      //   style: ElevatedButton.styleFrom(
      //     minimumSize: Size(double.infinity, 48),
      //   ),
      // ),
      //         ],
      //       ),
      //     );
      //   },
      // ),
    );
  }
}
