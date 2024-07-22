import 'dart:math';

import 'package:app_well_mate/main.dart';
import 'package:app_well_mate/model/notification_model.dart';
import 'package:app_well_mate/providers/cart_page_provider.dart';
import 'package:flutter/material.dart';
import 'package:app_well_mate/api/address/address_repo.dart';
import 'package:app_well_mate/model/address_model.dart';
import 'package:app_well_mate/storage/secure_storage.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:provider/provider.dart';

enum MedicationItemAction { delete, edit, snooze, buy, confirm }

class WidgetPaymentMedicine extends StatefulWidget {
  const WidgetPaymentMedicine({super.key});

  @override
  State<WidgetPaymentMedicine> createState() => _WidgetPaymentMedicine();
}

class _WidgetPaymentMedicine extends State<WidgetPaymentMedicine> {
  String paymentMethod = 'Momo';
  AddressModel? selectedAddress;
  bool isAdd = true;
  Future<List<AddressModel>>? _addressesFuture;
  final TextEditingController _newAddressController = TextEditingController();
  final TextEditingController _editAddressController = TextEditingController();
  final TextEditingController _nameStreetController = TextEditingController();

  final TextEditingController _nameAddressController = TextEditingController();
  final TextEditingController _cityNameController = TextEditingController();
  final TextEditingController _coundtryCodeController = TextEditingController();
  final TextEditingController _postalController = TextEditingController();
  final TextEditingController _phoneNumberressController =
      TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadAddresses();
  }

  void _deleteAddress(int id) async {
    await AddressRepo().deleteAddress(id);
    _loadAddresses();
  }

  void _loadAddresses() async {
    String? token = await SecureStorage.getToken();
    setState(() {
      _addressesFuture = AddressRepo().getAddressByUserId(token);
    });
  }

  void _addAddress(String newAddress) async {
    String? token = await SecureStorage.getToken();
    await AddressRepo().addAddress(newAddress, token);
    _loadAddresses();
  }

  void _updateAddress(int idAddress, String newAddress) async {
    String? token = await SecureStorage.getToken();
    await AddressRepo().UpdateAddress(idAddress, newAddress, token);
    _loadAddresses();
  }

  String getAddress() {
    String address = _nameStreetController.text +
        "," +
        _cityNameController.text +
        "," +
        _coundtryCodeController.text +
        "," +
        _postalController.text +
        "," +
        _phoneNumberressController.text;
    return address;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final sizeWidth = MediaQuery.of(context).size.width;
    final sizeHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Địa chỉ giao hàng"),
              FutureBuilder<List<AddressModel>>(
                future: _addressesFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: LoadingAnimationWidget.flickr(
                        leftDotColor: colorScheme.primary,
                        rightDotColor: colorScheme.error,
                        size: 48,
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                        child: Text("Lỗi khi tải địa chỉ: ${snapshot.error}"));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text("Không có địa chỉ nào"));
                  }

                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      final address = snapshot.data![index];
                      //dung de tach chuoi dc lay tu api
                      final splitString = address.address!.split(",");
                      final addressTrue = "${splitString[0]} ${splitString[1]}";
                      return Consumer<CartPageProvider>(
                        builder: (context, cartProvider, child) {
                          return ListTile(
                            contentPadding: EdgeInsets.zero,
                            title: Text(addressTrue),
                            leading: Radio<AddressModel>(
                              value: address,
                              groupValue: cartProvider.selectedAddress,
                              onChanged: (AddressModel? value) {
                                cartProvider.setSelectedAddress(value!);
                              },
                            ),
                            trailing: PopupMenuButton(
                              itemBuilder: (context) => [
                                PopupMenuItem(
                                  value: MedicationItemAction.delete,
                                  child: ListTile(
                                    leading: const Icon(Symbols.delete),
                                    title: const Text("Xoá địa chỉ này"),
                                    onTap: () {
                                      _deleteAddress(address.id_address!);
                                      Navigator.pop(context);
                                    },
                                  ),
                                ),
                                PopupMenuItem(
                                  value: MedicationItemAction.edit,
                                  child: ListTile(
                                    leading: const Icon(Symbols.edit),
                                    title: const Text("Chỉnh sửa địa chỉ này"),
                                    onTap: () {
                                      isAdd = false;

                                      // showModalBottomSheet(
                                      //   isScrollControlled: true,
                                      //   backgroundColor: Colors.white,
                                      //   context: context,
                                      //   builder: (context) {
                                      //     return SingleChildScrollView(
                                      //       child: Padding(
                                      //         padding: EdgeInsets.only(
                                      //           bottom: MediaQuery.of(context)
                                      //               .viewInsets
                                      //               .bottom,
                                      //           left: 12,
                                      //           right: 12,
                                      //           top: 12,
                                      //         ),
                                      //         child: SizedBox(
                                      //           height: 0.51 * sizeHeight,
                                      //           child: SingleChildScrollView(
                                      //             child: Padding(
                                      //               padding: const EdgeInsets
                                      //                   .symmetric(
                                      //                   horizontal: 12),
                                      //               child: Column(
                                      //                 crossAxisAlignment:
                                      //                     CrossAxisAlignment
                                      //                         .start,
                                      //                 children: [
                                      //                   Center(
                                      //                     child: Text(
                                      //                       "Chỉnh sửa địa chỉ",
                                      //                       style: Theme.of(
                                      //                               context)
                                      //                           .textTheme
                                      //                           .bodyLarge,
                                      //                     ),
                                      //                   ),
                                      //                   const SizedBox(
                                      //                     height: 15,
                                      //                   ),
                                      //                   const Text(
                                      //                       "Thông tin địa chỉ"),
                                      //                   TextFormField(
                                      //                     controller:
                                      //                         _editAddressController,
                                      //                     decoration:
                                      //                         InputDecoration(
                                      //                       labelText:
                                      //                           address.address,
                                      //                     ),
                                      //                   ),
                                      //                   Padding(
                                      //                     padding:
                                      //                         const EdgeInsets
                                      //                             .all(18.0),
                                      //                     child: SizedBox(
                                      //                       width:
                                      //                           double.infinity,
                                      //                       child:
                                      //                           ElevatedButton(
                                      //                         onPressed: () {
                                      //                           _updateAddress(
                                      //                               address
                                      //                                   .id_address!,
                                      //                               _editAddressController
                                      //                                   .text);
                                      //                           Navigator.pop(
                                      //                               context);
                                      //                         },
                                      //                         child: const Text(
                                      //                             "Xong"),
                                      //                       ),
                                      //                     ),
                                      //                   )
                                      //                 ],
                                      //               ),
                                      //             ),
                                      //           ),
                                      //         ),
                                      //       ),
                                      //     );
                                      //   },
                                      // );
                                      newMethod(
                                        context,
                                        sizeHeight,
                                        isAdd,
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                  );
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15),
                child: InkWell(
                  onTap: () {
                    isAdd = true;
                    newMethod(context, sizeHeight, isAdd);
                  },
                  child: Row(
                    children: [
                      const Icon(Icons.add),
                      Text("Thêm địa chỉ giao hàng",
                          style: Theme.of(context).textTheme.titleMedium),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<dynamic> newMethod(BuildContext context, double sizeHeight, bool isAdd,
      [AddressModel? addressA]) {
    return showModalBottomSheet(
      isScrollControlled: true,
      backgroundColor: Colors.white,
      context: context,
      builder: (context) {
        return SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
              left: 12,
              right: 12,
              top: 12,
            ),
            child: SizedBox(
              height: 0.51 * sizeHeight,
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Text(
                          isAdd ? "Thêm địa chỉ mới" : "Chỉnh sửa địa chỉ",
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      const Text("Thông tin địa chỉ"),
                      TextFormField(
                        controller: _nameStreetController,
                        decoration: isAdd
                            ? const InputDecoration(labelText: "Nhập tên đường")
                            : InputDecoration(hintText: "aaa"),
                      ),
                      TextFormField(
                        controller: _cityNameController,
                        decoration: isAdd
                            ? const InputDecoration(labelText: "Nhập thành phố")
                            : InputDecoration(hintText: "aaa"),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: _coundtryCodeController,
                              decoration: isAdd
                                  ? const InputDecoration(
                                      labelText: "Coundtry code")
                                  : InputDecoration(hintText: ""),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: TextFormField(
                              controller: _postalController,
                              decoration: isAdd
                                  ? const InputDecoration(
                                      labelText: "Postal code")
                                  : InputDecoration(hintText: ""),
                            ),
                          ),
                        ],
                      ),
                      TextFormField(
                        controller: _phoneNumberressController,
                        decoration: isAdd
                            ? const InputDecoration(labelText: "Số điện thoại")
                            : InputDecoration(hintText: ""),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: isAdd
                                ? () {
                                    String allinFo = getAddress();
                                    print(
                                        "day la tat ca thong tin dia chi: $allinFo");
                                    _addAddress(allinFo);
                                    Navigator.pop(context);
                                    _nameStreetController.clear();
                                    _cityNameController.clear();
                                    _coundtryCodeController.clear();
                                    _postalController.clear();
                                    _phoneNumberressController.clear();
                                  }
                                : () {
                                    // _updateAddress(
                                    //     addressA!.id_address!, newAddress);
                                  },
                            child: const Text("Xong"),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
