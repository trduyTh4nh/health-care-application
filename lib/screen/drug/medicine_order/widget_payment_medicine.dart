import 'package:app_well_mate/main.dart';
import 'package:flutter/material.dart';
import 'package:app_well_mate/api/address/address_repo.dart';
import 'package:app_well_mate/model/address_model.dart';
import 'package:app_well_mate/storage/secure_storage.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:material_symbols_icons/symbols.dart';

enum MedicationItemAction { delete, edit, snooze, buy, confirm }

class WidgetPaymentMedicine extends StatefulWidget {
  const WidgetPaymentMedicine({super.key});

  @override
  State<WidgetPaymentMedicine> createState() => _WidgetPaymentMedicine();
}

class _WidgetPaymentMedicine extends State<WidgetPaymentMedicine> {
  String paymentMethod = 'Momo';
  AddressModel? selectedAddress;
  final _userName = TextEditingController();
  Future<List<AddressModel>>? _addressesFuture;
  final TextEditingController _newAddressController = TextEditingController();
  final TextEditingController _editAddressController = TextEditingController();

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
      _addressesFuture = AddressRepo().getAddressByUserId(token!);
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
              Text("Phương thức thanh toán"),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Radio(
                        value: "Visa",
                        groupValue: paymentMethod,
                        onChanged: (value) {
                          setState(() {
                            paymentMethod = value!;
                          });
                        },
                      ),
                      Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(25),
                          child: Image.network(
                              "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSGxsoe7iPccCnGraliGFCLCvbg3bO3PDtELQ&s"),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Visa",
                              style: Theme.of(context).textTheme.titleMedium),
                          const Text("******12"),
                        ],
                      )
                    ],
                  ),
                  PopupMenuButton(
                    style: Theme.of(context).iconButtonTheme.style,
                    itemBuilder: (context) => const [
                      PopupMenuItem(
                          value: MedicationItemAction.delete,
                          child: ListTile(
                              leading: Icon(Symbols.delete),
                              title: Text("Xoá thẻ ngân hàng  này"))),
                    ],
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: InkWell(
                  onTap: () {
                    showModalBottomSheet(
                      isScrollControlled: true,
                      backgroundColor: Colors.white,
                      context: context,
                      builder: (context) {
                        return SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.only(
                              bottom: 50,
                              left: 12,
                              right: 12,
                              top: 20,
                            ),
                            child: Container(
                              child: SingleChildScrollView(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Center(
                                        child: Text(
                                          "Thêm thẻ",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyLarge,
                                        ),
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text("Thông tin liên hệ"),
                                          TextFormField(
                                            controller: _userName,
                                            decoration: InputDecoration(
                                              labelText: "Tên thẻ ngân hàng",
                                            ),
                                          ),
                                          TextField(
                                            decoration: InputDecoration(
                                                labelText: "Số thẻ ngân hàng"),
                                          ),
                                          Row(
                                            children: [
                                              Expanded(
                                                flex: 3,
                                                child: TextField(
                                                  decoration: InputDecoration(
                                                      labelText:
                                                          "Ngày hết hạn(MM/YY)"),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 20,
                                              ),
                                              Expanded(
                                                flex: 1,
                                                child: TextField(
                                                  decoration: InputDecoration(
                                                      labelText: "Mã CVV"),
                                                ),
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      SizedBox(
                                        width: double.infinity,
                                        child: ElevatedButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: const Text("Xong"),
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
                  },
                  child: Row(
                    children: [
                      Icon(Icons.add),
                      Text("Thêm thẻ ngân hàng",
                          style: Theme.of(context).textTheme.titleMedium),
                    ],
                  ),
                ),
              ),
              Text("Địa chỉ giao hàng"),
              FutureBuilder<List<AddressModel>>(
                future: _addressesFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: LoadingAnimationWidget.flickr(
                                            leftDotColor: colorScheme.primary,
                                            rightDotColor: colorScheme.error,
                                            size: 48,
                                          ),);
                  } else if (snapshot.hasError) {
                    return Center(
                        child: Text("Lỗi khi tải địa chỉ: ${snapshot.error}"));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(child: Text("Không có địa chỉ nào"));
                  }

                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      final address = snapshot.data![index];
                      var item=snapshot.data![index];
                      return ListTile(
                        title: Text(address.address ?? 'Địa chỉ không rõ'),
                        leading: Radio<AddressModel>(
                          value: address,
                          groupValue: selectedAddress,
                          onChanged: (AddressModel? value) {
                            setState(() {
                              selectedAddress = value;
                            });
                          },
                        ),
                        trailing: PopupMenuButton(
                          itemBuilder: (context) => [
                            PopupMenuItem(
                              value: MedicationItemAction.delete,
                              child: ListTile(
                                leading: Icon(Symbols.delete),
                                title: Text("Xoá địa chỉ này"),
                                onTap: () {
                                  // if (selectedAddress != null) {
                                  //   _deleteAddress(selectedAddress?.id_address[index]);
                                  //   print(selectedAddress!.id_address!);
                                  // } else {
                                  //   print('Không có địa chỉ nào được chọn để xóa.');
                                  // }
                                  _deleteAddress(
                                    item.id_address!
                                  );
                                  Navigator.pop(context);
                                },
                              ),
                            ),
                            PopupMenuItem(
                              value: MedicationItemAction.edit,
                              child: ListTile(
                                leading: Icon(Symbols.edit),
                                title: Text("Chỉnh sửa địa chỉ này"),
                                onTap: () {
                                  showModalBottomSheet(
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
                                          child: Container(
                                            height: 0.51 * sizeHeight,
                                            child: SingleChildScrollView(
                                              child: Padding(
                                                padding: const EdgeInsets.symmetric(
                                                    horizontal: 12),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Center(
                                                      child: Text(
                                                        "Chỉnh sửa địa chỉ",
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .bodyLarge,
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      height: 15,
                                                    ),
                                                    Text("Thông tin địa chỉ"),
                                                    TextFormField(
                                                      controller: _editAddressController,
                                                      decoration: InputDecoration(
                                                        labelText: address.address,
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets.all(18.0),
                                                      child: SizedBox(
                                                        width: double.infinity,
                                                        child: ElevatedButton(
                                                          onPressed: () {
                                                            _updateAddress(address.id_address!, _editAddressController.text);
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
                                      );
                                    },
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
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15),
                child: InkWell(
                  onTap: () {
                    showModalBottomSheet(
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
                            child: Container(
                              height: 0.51 * sizeHeight,
                              child: SingleChildScrollView(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Center(
                                        child: Text(
                                          "Thêm địa chỉ mới",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyLarge,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      Text("Thông tin địa chỉ"),
                                      TextFormField(
                                        controller: _newAddressController,
                                        decoration: InputDecoration(
                                            labelText:
                                                "Nhập địa chỉ mới tại đây"),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(18.0),
                                        child: SizedBox(
                                          width: double.infinity,
                                          child: ElevatedButton(
                                            onPressed: () {
                                              _addAddress(_newAddressController.text);
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
                        );
                      },
                    );
                  },
                  child: Row(
                    children: [
                      Icon(Icons.add),
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
}
