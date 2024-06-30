import 'package:app_well_mate/const/color_scheme.dart';
import 'package:app_well_mate/model/drug_model.dart';
import 'package:app_well_mate/model/notification_model.dart';
import 'package:app_well_mate/model/order_model.dart';
import 'package:app_well_mate/model/prescription_detail_model.dart';
import 'package:app_well_mate/model/prescription_model.dart';
import 'package:app_well_mate/screen/order/func_order/index.dart';
import 'package:app_well_mate/utils/app.colors.dart';
import 'package:app_well_mate/utils/util.dart';
import 'package:flutter/material.dart';

class OrderStatus extends StatefulWidget {
  const OrderStatus({super.key, required this.notifiItem});
  final NotificationModel notifiItem;

  @override
  State<OrderStatus> createState() => _OrderStatusState();
}

class _OrderStatusState extends State<OrderStatus> {
  // dùng id pre tìm ra model presctions trong
  // trong prescript của prescriptons detail có iddrug dùng
  // id drug tìm drug tạo thành danh sách sau đó lấy danh sách
  // nhớ loop qua lấy tổng tiền để tính tổng tiền đơn thốc phải trả
  // ủi vào sliver list
  // tạo model phương thức thanh toán, tạo dữ liệu mẫu hiển thị

  OrderModel? orderOfNotifi;
  PrescriptionModel? prescriptionOfnotifi;
  List<PrescriptionDetailModel>? _listPrescriptionDetail;
  List<DrugModel>? _listDrug = [];
  String? totalDeal;
  @override
  void initState() {
    super.initState();
    // dùng idOrder trong notification tìm order
    if (widget.notifiItem.idOrder != null) {
      print("DEBUG ID ${widget.notifiItem.idOrder}");

      orderOfNotifi = findOrderById(widget.notifiItem.idOrder!);
    }
    // có được order dùng idPre của match 1:1 với Prescription tìm prescription
    prescriptionOfnotifi = findPrescriptionByIdFromOrder(orderOfNotifi!.idPre!);
    if (prescriptionOfnotifi != null) {
      _listPrescriptionDetail = prescriptionOfnotifi!.prescriptionDetails;

      _listDrug = getListDrug(_listPrescriptionDetail!);
    }

    // // ${_listPrescriptionDetail![index].amount!} / ${(_listDrug![index].price! * _listPrescriptionDetail![index].quantity!)}
    // for (var element in _listPrescriptionDetail!) {
    //   print(element.drug!.idDrug);
    // }

    // for (var element in _listDrug!) {
    //   print(element.idDrug);
    // }

    // Check if prescription details and drugs list are not null before proceeding
    if (prescriptionOfnotifi != null) {
      _listPrescriptionDetail = prescriptionOfnotifi!.prescriptionDetails;

      // Ensure prescription details list is not null and iterate through each element
      if (_listPrescriptionDetail != null) {
        _listDrug = getListDrug(_listPrescriptionDetail!);

        // Print IDs of prescription details
        for (var element in _listPrescriptionDetail!) {
          print('Prescription Detail ID: ${element.idDrug}');
        }
      }

      // Ensure drugs list is not null and iterate through each element
      if (_listDrug != null) {
        // Print IDs of drugs
        for (var element in _listDrug!) {
          print('Drug ID: ${element.idDrug}');
        }

        // Calculate total price of the prescription
        int totalPrice = 0;
        for (var i = 0; i < _listPrescriptionDetail!.length; i++) {
          var prescriptionDetail = _listPrescriptionDetail![i];
          var drug = _listDrug![i];

          print(prescriptionDetail.quantity);
          print(drug.price);

          // Check for null values before calculating
          if (drug.price != null && prescriptionDetail.quantity != null) {
            totalPrice += (drug.price! * prescriptionDetail.quantity!).toInt();
          }
        }

        print('Total Price of Prescription: $totalPrice');
        setState(() {
          // ignore: unnecessary_null_comparison
          if (convertCurrency(totalPrice) != null) {
            totalDeal = convertCurrency(totalPrice);
          }
        });
        print('Converted currency ${convertCurrency(totalPrice)}');
      }
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {});

    // _showPaymentSheet(context);
  }

  void _showPaymentSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                child: Text(
                  'Phương thức thanh toán',
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall!
                      .copyWith(fontSize: 12),
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                              color: AppColor.gray,
                              borderRadius: BorderRadius.circular(50)),
                          width: 60,
                          height: 60,
                          child: Image.network(
                              'https://upload.wikimedia.org/wikipedia/commons/thumb/5/5e/Visa_Inc._logo.svg/2560px-Visa_Inc._logo.svg.png'),
                        ),
                        const SizedBox(
                          width: 16,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'VISA',
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                            const SizedBox(
                              height: 2,
                            ),
                            Text(
                              '**12',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(fontWeight: FontWeight.bold),
                            ),
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 8),
                child: Text('Địa chỉ giao hàng',
                    style: Theme.of(context).textTheme.bodySmall!),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: Expanded(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '100 đường Example, Thành phố Hồ Chí Minh, Việt Nam',
                                  style: Theme.of(context).textTheme.bodyLarge,
                                ),
                                Text('Địa chỉ 1',
                                    style:
                                        Theme.of(context).textTheme.bodySmall!)
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 16,
                          ),
                        ],
                      ),
                    ),
                  ],
                )),
              ),
              const SizedBox(
                height: 16,
              ),
              const Divider(),
              const SizedBox(
                height: 16,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: Expanded(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Tổng tiền',
                                    style:
                                        Theme.of(context).textTheme.bodySmall!),
                                Text(
                                  '$totalDeal',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(fontSize: 28),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 16,
                          ),
                        ],
                      ),
                    ),
                  ],
                )),
              ),
              const SizedBox(
                height: 16,
              ),
              ElevatedButton(
                onPressed: () {},
                child: Text('Hủy đơn thuốc'),
                style: ButtonStyle(
                  minimumSize:
                      WidgetStateProperty.all(Size(double.infinity, 50)),
                ),
              )
              // Add more widgets here
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tình trạng đơn thuốc'),
      ),
      floatingActionButton: ElevatedButton(
          onPressed: () => _showPaymentSheet(context),
          child: Text('Xem tình trạng')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: CustomScrollView(slivers: [
          SliverList.separated(
            itemCount: _listDrug!.length,
            itemBuilder: (context, index) {
              var priceOfDrug = _listPrescriptionDetail![index].quantity! *
                  _listDrug![index].price!;

              if (_listPrescriptionDetail == null || _listDrug == null) {
                return const CircularProgressIndicator();
              } else {
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 4, horizontal: 4),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 70,
                            height: 70,
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                                color: AppColor.gray,
                                borderRadius: BorderRadius.circular(50)),
                            child: Image.network(
                              _listDrug![index].drugImage!,
                              scale: 1,
                            ),
                          ),
                          const SizedBox(
                            width: 16,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                _listDrug![index].name!,
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                              const SizedBox(
                                height: 2,
                              ),
                              Text(
                                "${_listPrescriptionDetail![index].quantity} ${_listDrug![index].unit} - ${_listDrug![index].price} / ${_listDrug![index].unit}",
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                              const SizedBox(
                                height: 2,
                              ),
                              // ignore: unnecessary_null_comparison
                              priceOfDrug != null
                                  ? Text(
                                      convertCurrency(priceOfDrug),
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium!
                                          .copyWith(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14),
                                    )
                                  : const CircularProgressIndicator(),
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                );
              }
            },
            separatorBuilder: (context, index) => Divider(
              color: AppColors.greyColor,
            ),
          ),
        ]),
      ),
    );
  }
}
