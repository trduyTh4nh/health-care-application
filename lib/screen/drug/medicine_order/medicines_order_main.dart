import 'dart:convert';
import 'dart:developer';

import 'package:app_well_mate/api/notification/notification_repo.dart';
import 'package:app_well_mate/api/payment/payment_repo.dart';
import 'package:app_well_mate/components/custom_dialog.dart';
import 'package:app_well_mate/components/snack_bart.dart';
import 'package:app_well_mate/main.dart';
import 'package:app_well_mate/model/drug_cart_detail_model.dart';
import 'package:app_well_mate/providers/cart_page_provider.dart';
import 'package:app_well_mate/screen/checkout.dart';
import 'package:app_well_mate/screen/drug/medicine_order/widget_buy_medicine.dart';
import 'package:app_well_mate/screen/drug/medicine_order/widget_complete_medicine.dart';
import 'package:app_well_mate/screen/drug/medicine_order/widget_payment_medicine.dart';
import 'package:app_well_mate/screen/drug_cart.dart';
import 'package:app_well_mate/screen/home.dart';
import 'package:app_well_mate/storage/secure_storage.dart';
import 'package:app_well_mate/utils/app.colors.dart';
import 'package:app_well_mate/utils/util.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:app_well_mate/screen/drug/medicine_order/widget_prescriptionstatus_medicine.dart';
import 'package:flutter_paypal_checkout/flutter_paypal_checkout.dart';

class MedicinesOrder extends StatefulWidget {
  const MedicinesOrder({super.key});

  @override
  State<MedicinesOrder> createState() => _MedicinesOrderState();
}

class _MedicinesOrderState extends State<MedicinesOrder> {
  int _currentPageIndex = 0;
  final PageController _pageController = PageController();
  final List<Widget> _pages = [
    const WidgetBuyMedicine(),
    const WidgetPaymentMedicine(),
    const WidgetCompleteMedicine(),
  ];
  final List<String> _tittle = [
    "Mua thuốc",
    "Thanh toán",
    "Hoàn tất",
  ];

  void _nextPage(BuildContext context) {
    final cartProvider = Provider.of<CartPageProvider>(context, listen: false);

    if (_currentPageIndex == 1 && cartProvider.selectedAddress == null) {
      showCustomSnackBar(context, "Vui lòng chọn địa chỉ giao hàng");
      return;
    }

    if (_currentPageIndex < 2) {
      setState(() {
        _currentPageIndex++;
      });
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CartPageProvider>(
      builder: (context, value, child) {
        return Scaffold(
          appBar: AppBar(
            title: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              transitionBuilder: (Widget child, Animation<double> animation) {
                return ScaleTransition(scale: animation, child: child);
              },
              child: Text(
                _tittle[_currentPageIndex],
                key: ValueKey(_tittle[_currentPageIndex]),
              ),
            ),
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: SmoothPageIndicator(
                  controller: _pageController,
                  count: _pages.length,
                  axisDirection: Axis.horizontal,
                  effect: const SlideEffect(
                    spacing: 8.0,
                    radius: 4.0,
                    dotWidth: 36.0,
                    dotHeight: 10.0,
                    strokeWidth: 1,
                    dotColor: AppColors.greyColor,
                    activeDotColor: AppColors.primaryColor,
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: PageView(
                    physics: const NeverScrollableScrollPhysics(),
                    controller: _pageController,
                    children: _pages,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Tổng tiền",
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                    Text(
                      convertCurrency(value.totalPrice),
                      style: Theme.of(context).textTheme.displayMedium,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _currentPageIndex != _pages.length - 1
                              ? FilledButton(
                                  onPressed: () {
                                    if (_currentPageIndex > 0) {
                                      setState(() {
                                        _currentPageIndex--;
                                      });
                                      _pageController.animateToPage(
                                        _currentPageIndex,
                                        duration:
                                            const Duration(milliseconds: 500),
                                        curve: Curves.easeInOutCubicEmphasized,
                                      );
                                    } else {
                                      Navigator.push(context, MaterialPageRoute(
                                        builder: (context) {
                                          return const CartPage();
                                        },
                                      ));
                                    }
                                  },
                                  child: const Text("Quay lại"),
                                )
                              : const SizedBox.shrink(),
                          _currentPageIndex != _pages.length - 1
                              ? ElevatedButton(
                                  onPressed: () => _nextPage(context),
                                  child: const Text("Tiếp theo"),
                                )
                              : Expanded(
                                  child: SizedBox(
                                    child: Consumer<CartPageProvider>(
                                        builder: (context, value, child) {
                                      return ElevatedButton(
                                        onPressed: () async {
                                          String name =
                                              await SecureStorage.getUserName();
                                          int idUser =
                                              await SecureStorage.getUserId();
                                          int idAddress = value
                                              .selectedAddress!.id_address!;

                                          String token =
                                              await SecureStorage.getToken();

                                          List<DrugCartDetailModel>
                                              listDrugCartDetail =
                                              value.listChecked;

                                          var address =
                                              value.selectedAddress!.address;

                                          var totalPrice =
                                              (value.totalPrice / 23000)
                                                  .round();

                                          List<Map<String, dynamic>>
                                              drugCartList =
                                              listDrugCartDetail.map((item) {
                                            return {
                                              "id_drug": item.drug!.idDrug,
                                              "quantity": item.quantity,
                                              "id_app_detail":
                                                  item.idAppDetail ?? -1,
                                            };
                                          }).toList();

                                          var listAddress = address!.split(',');

                                          for (var element in listAddress) {
                                            log(element);
                                          }

                                          var line1 = listAddress[0];
                                          var city = listAddress[1];
                                          var postalCode = listAddress[3];
                                          var phone = listAddress[4];

                                          Map<String, dynamic> requestBody = {
                                            "listDrugCart": drugCartList
                                          };

                                          String jsonString =
                                              jsonEncode(requestBody);

                                          print("requestBody: ${jsonString}");

                                          Navigator.of(context)
                                              .push(MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                                PaypalCheckout(
                                              sandboxMode: true,
                                              clientId:
                                                  "AWT3S_MSMRg62AQDEotKcZx-04Lek3APj48M6S0Lvm2eNFLuVhunAxYF7dEXW0wX7dAcVCPFpFNQkznE",
                                              secretKey:
                                                  "EJfpAGaYHV3jwZpZ5tBxpDKlDKMjpaeLDviFhQtRuVvPuNl3jfPRVLCLr2Dm9KOe-oI2CZssTHBEmw9q",
                                              returnURL:
                                                  "success.snippetcoder.com",
                                              cancelURL:
                                                  "cancel.snippetcoder.com",
                                              transactions: [
                                                {
                                                  "amount": {
                                                    "total": '$totalPrice',
                                                    "currency": "USD",
                                                  },
                                                  "description":
                                                      "Cổng thanh toán thuốc WELL-MATE",
                                                  "item_list": {
                                                    "shipping_address": {
                                                      "recipient_name": name,
                                                      "line1": line1,
                                                      "city": city,
                                                      "country_code": "VN",
                                                      "postal_code": postalCode,
                                                      "phone": phone,
                                                    }
                                                  }
                                                }
                                              ],
                                              note:
                                                  "Contact us for any questions on your order.",
                                              onSuccess: (Map params) async {
                                                log("onSuccess: ${params}");

                                                PaymentRepo paymentRepo =
                                                    new PaymentRepo();

                                                log("onSuccess: ${params}");

                                                // Directly access the nested id field
                                                String idPaypal =
                                                    params['data']['id'];

                                                // Print the id
                                                print('id_paypal: $idPaypal');

                                                int? isPay =
                                                    await paymentRepo.payment(
                                                        idAddress,
                                                        idUser,
                                                        value.totalPrice,
                                                        drugCartList,
                                                        token,
                                                        idPaypal);
                                                if (isPay != -1) {
                                                  int idUser =
                                                      await SecureStorage
                                                          .getUserId();
                                                  value.removeCart();
                                                  await NotificationRepo()
                                                      .insertNotification({
                                                    "content":
                                                        "Bạn đã thanh toán thành công đơn hàng số $idPaypal",
                                                    "time": DateTime.now()
                                                        .toString(),
                                                    "id_user": idUser,
                                                    "isconfirmed": false,
                                                    "priority": 2,
                                                    "id_invoice": isPay,
                                                    "id_schedule_detail": null
                                                  });
                                                  showCustomSnackBar(
                                                      navigatorKey
                                                          .currentContext!,
                                                      "Thanh toán thành công");
                                                  navigatorKey.currentState!
                                                      .push(MaterialPageRoute(
                                                    builder: (context) =>
                                                        const AppPage(),
                                                  ));
                                                } else {
                                                  showCustomSnackBar(context,
                                                      "Thanh toán thất bại!");
                                                }
                                              },
                                              onError: (error) {
                                                print("onError: $error");
                                                Navigator.pop(context);
                                              },
                                              onCancel: () {
                                                print('cancelled:');
                                              },
                                            ),
                                          ));
                                        },
                                        child:
                                            const Text("Tiến hành thanh toán"),
                                      );
                                    }),
                                  ),
                                ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class DrugCartDetailCustom {
  Drug? drug;
  int quantity;

  DrugCartDetailCustom({this.drug, required this.quantity});
}

class Drug {
  int? idDrug;

  Drug({this.idDrug});
}
