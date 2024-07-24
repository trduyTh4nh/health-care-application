import 'dart:math';

import 'package:app_well_mate/main.dart';
import 'package:app_well_mate/model/notification_model.dart';
import 'package:app_well_mate/providers/cart_page_provider.dart';
import 'package:app_well_mate/utils/util.dart';
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
  final _formKey = GlobalKey<FormState>();
  List<Map<String, dynamic>> _filteredProvinces = [];

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

  void onProvinceSelected(Map<String, dynamic> province) {
    print("set state cho ");
    setState(() {
      _postalController.text = province['postal_code'];
      _coundtryCodeController.text = province['area_code'];
    });
  }

  String? validatorPhoneNumber(String? value) {
    if (value == null) {
      return 'Vui lòng nhập số điện thoại';
    } else if (value.length != 10) {
      // Changed to check length of the phone number
      return 'Số điện thoại không hợp lệ';
    }
    return null;
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

  void _onPaymentMethodChanged(String? value) {
    setState(() {
      paymentMethod = value!;
    });
  }

  void _onAddressSelected(AddressModel? address) {
    setState(() {
      selectedAddress = address;
    });
  }

  String getAddress() {
    String address =
        "${_nameStreetController.text},${_cityNameController.text},${_coundtryCodeController.text},${_postalController.text},${_phoneNumberressController.text}";
    return address;
  }

  @override
  void dispose() {
    super.dispose();
    _newAddressController.dispose();
    _editAddressController.dispose();
    _nameStreetController.dispose();
    _nameAddressController.dispose();
    _cityNameController.dispose();
    _coundtryCodeController.dispose();
    _postalController.dispose();
    _phoneNumberressController.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                                      _nameStreetController.text =
                                          splitString[0];
                                      _cityNameController.text = splitString[1];
                                      _coundtryCodeController.text =
                                          splitString[2];
                                      _postalController.text = splitString[3];
                                      _phoneNumberressController.text =
                                          splitString[4];
                                      newMethod(
                                          context, sizeHeight, isAdd, address);
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
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Form(
                    key: _formKey,
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
                          validator: (nameAddress) => nameAddress!.isEmpty
                              ? "Vui lòng nhập tên đường!"
                              : "",
                          controller: _nameStreetController,
                          decoration: const InputDecoration(
                              labelText: "Nhập tên đường"),
                        ),
                        const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Chọn khu vực'),
                            AutocompleteBasicExample(),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                validator: (coundtryCode) =>
                                    coundtryCode!.isEmpty
                                        ? "Vui lòng nhập mã vùng!"
                                        : "",
                                controller: _coundtryCodeController,
                                decoration:
                                    const InputDecoration(labelText: "Mã vùng"),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: TextFormField(
                                validator: (postalCode) => postalCode!.isEmpty
                                    ? "Vui lòng nhập postal code!"
                                    : "",
                                controller: _postalController,
                                decoration: const InputDecoration(
                                    labelText: "Postal code"),
                              ),
                            ),
                          ],
                        ),
                        TextFormField(
                          validator: validatorPhoneNumber,
                          controller: _phoneNumberressController,
                          decoration:
                              const InputDecoration(labelText: "Số điện thoại"),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(18.0),
                          child: SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: isAdd
                                  ? () {
                                      if (_formKey.currentState!.validate()) {
                                        String allinFo = getAddress();
                                        _addAddress(allinFo);
                                        Navigator.pop(context);

                                        _nameStreetController.clear();
                                        _cityNameController.clear();
                                        _coundtryCodeController.clear();
                                        _postalController.clear();
                                        _phoneNumberressController.clear();
                                      }
                                    }
                                  : () {
                                      String newAddress = getAddress();

                                      _updateAddress(
                                          addressA!.id_address!, newAddress);
                                      _nameStreetController.clear();
                                      _cityNameController.clear();
                                      _coundtryCodeController.clear();
                                      _postalController.clear();
                                      _phoneNumberressController.clear();
                                      Navigator.pop(context);
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
          ),
        );
      },
    );
  }
}

class AutocompleteBasicExample extends StatelessWidget {
  const AutocompleteBasicExample({super.key});

  static final List<Map<String, dynamic>> _kOptions = vietNemprovince;

  @override
  Widget build(BuildContext context) {
    return Autocomplete<String>(
      optionsBuilder: (TextEditingValue textEditingValue) {
        if (textEditingValue.text == '') {
          return const Iterable<String>.empty();
        }
        return _kOptions.where((Map<String, dynamic> option) {
          return option['name']
              .toLowerCase()
              .contains(textEditingValue.text.toLowerCase());
        }).map((option) => option['name'] as String);
      },
      onSelected: (String selection) {
        debugPrint('You just selected $selection');
        // Gọi hàm onProvinceSelected với province đã chọn
        final selectedProvince = _kOptions.firstWhere(
            (Map<String, dynamic> option) => option['name'] == selection);
        // Đặt các giá trị đã chọn vào các TextEditingController tương ứng
        final parentState =
            context.findAncestorStateOfType<_WidgetPaymentMedicine>();
        parentState?.onProvinceSelected(selectedProvince);
      },
      fieldViewBuilder: (BuildContext context,
          TextEditingController textEditingController,
          FocusNode focusNode,
          VoidCallback onFieldSubmitted) {
        return TextFormField(
          controller: textEditingController,
          focusNode: focusNode,
          decoration: const InputDecoration(
            labelText: "Nhập thành phố",
          ),
        );
      },
    );
  }
}
