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

  OrderModel(
      {this.idUser,
      this.datePay,
      this.paymentMethod,
      this.status,
      this.notes,
      this.totalMoney});
  factory OrderModel.fromJson(Map<String, dynamic> json) => _$OrderModelFromJson(json);
  Map<String, dynamic> toJson() => _$OrderModelToJson(this);
}
