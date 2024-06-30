import 'dart:math';

import 'package:app_well_mate/model/order_detail_model.dart';
import 'package:app_well_mate/model/order_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'json/payment_model.g.dart';

@JsonSerializable()
class PaymentModel {
  int? idPayment;
  DateTime? datePay;
  String? paymentMethod;
  bool? status;
  String? notes;
  double? totalMoney;
  int? idOrder;
  OrderModel? order;
  PaymentModel(
      {this.idPayment,
      this.datePay,
      this.paymentMethod,
      this.status,
      this.notes,
      this.totalMoney,
      this.idOrder,
      this.order});

  factory PaymentModel.fromJson(Map<String, dynamic> json) =>
      _$PaymentModelFromJson(json);
  Map<String, dynamic> toJson() => _$PaymentModelToJson(this);
}

List<PaymentModel> generatePaymentList(int amount) {
  var paymentMethod = ["Thẻ tín dụng", "Tiền mặt"];
  return List.generate(
    amount,
    (i) => PaymentModel(
        idPayment: i,
        datePay: DateTime(2024, Random().nextInt(12), Random().nextInt(28), Random().nextInt(24), Random().nextInt(60), Random().nextInt(60)),
        paymentMethod: paymentMethod[Random().nextInt(2)],
        status: Random().nextInt(2) == 0,
        notes: "test",
        totalMoney: Random().nextInt(10000000).toDouble(),
        order: OrderModel(
            idOrder: i,
            orderDetailList: List.generate(
                Random().nextInt(10),
                (i2) => OrderDetailModel(
                      idDetailOrder: i2,
                    )))),
  );
}
