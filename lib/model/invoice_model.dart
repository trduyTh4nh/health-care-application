import 'package:app_well_mate/model/address_model.dart';

class InvoiceDetail {
  int? idInvoice;
  int? idUser;
  DateTime? createDate;
  double? totalPrice;
  bool? status;
  String? notes;
  int? idAddress;
  String? idPaypal;
  AddressModel? address;
  InvoiceDetail({this.idInvoice, this.idUser, this.createDate, this.totalPrice, this.status, this.notes, this.idAddress, this.idPaypal, this.address});
  factory InvoiceDetail.fromJson(Map<String, dynamic> json) {
    return InvoiceDetail(
      idInvoice: json["id_invoice"] ?? -1,
      idUser: json["id_user"] ?? -1,
      createDate: DateTime.tryParse(json["create_date"]) ?? DateTime(1900),
      totalPrice: json["total_price"] ?? -1,
      status: json["status"] ?? false,
      notes: json["notes"] ?? "",
      idAddress: json["id_address"] ?? "",
      idPaypal: json["id_paypal"] ?? "null"
    );
  }
}