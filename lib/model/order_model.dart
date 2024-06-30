import 'package:app_well_mate/model/order_detail_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'json/order_model.g.dart';

@JsonSerializable()
class OrderModel {
  int? idOrder;
  int? idUser; // khóa ngoại
  DateTime? datePay;
  String? paymentMethod;
  String? status;
  String? notes;
  int? totalMoney;
  int? idPre;
  List<OrderDetailModel>? orderDetailList = [];
  OrderModel(
      {this.idUser,
      this.datePay,
      this.paymentMethod,
      this.status,
      this.notes,
      this.totalMoney,
      this.idPre,
      this.idOrder,
      this.orderDetailList = const []});
  factory OrderModel.fromJson(Map<String, dynamic> json) => _$OrderModelFromJson(json);
  Map<String, dynamic> toJson() => _$OrderModelToJson(this);
}


List<OrderModel> generateSampleOrders() {
  return [
    OrderModel(
      idOrder: 1,
      idUser: 101,
      datePay: DateTime(2023, 6, 15),
      paymentMethod: "Credit Card",
      status: "paid",
      notes: "Order for medical supplies",
      totalMoney: 500000,
      idPre: 1,
    ),
    OrderModel(
      idOrder: 2,
      idUser: 102,
      datePay: DateTime(2023, 6, 16),
      paymentMethod: "Cash",
      status: "pending",
      notes: "Order for prescription drugs",
      totalMoney: 700000,
      idPre: 2,
    ),
    OrderModel(
      idOrder: 3,
      idUser: 103,
      datePay: DateTime(2023, 6, 17),
      paymentMethod: "Mobile Banking",
      status: "delivered",
      notes: "Order for medical equipment",
      totalMoney: 1200000,
      idPre: 3,
    ),
  ];
}
