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

  PaymentModel(
      {this.idPayment,
      this.datePay,
      this.paymentMethod,
      this.status,
      this.notes,
      this.totalMoney,
      this.idOrder});

  factory PaymentModel.fromJson(Map<String, dynamic> json) => _$PaymentModelFromJson(json);
  Map<String, dynamic> toJson() => _$PaymentModelToJson(this);
}
