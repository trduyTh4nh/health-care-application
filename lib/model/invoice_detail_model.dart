import 'package:app_well_mate/model/drug_model.dart';

class InvoiceDetailModel {
  int? idInvoiceDetail;
  int? idDrug;
  int? quantity;
  int? idInvoice;
  DrugModel? drug;
  InvoiceDetailModel({this.idInvoiceDetail, this.idInvoice, this.quantity, this.idDrug, this.drug});
  factory InvoiceDetailModel.fromJson(Map<String, dynamic> json){
    return InvoiceDetailModel(
      idInvoiceDetail: json["id_invoice_detail"],
      idDrug: json["id_drug"],
      quantity: json["quantity"],
      idInvoice: json["id_invoice"],
      drug: DrugModel.fromJson(json["drug"])
    );
  }
  factory InvoiceDetailModel.fromSeperateJson(Map<String, dynamic> invoiceDetailJson, Map<String, dynamic> drugJson){
    return InvoiceDetailModel(
      idInvoiceDetail: invoiceDetailJson["id_invoice_detail"],
      idDrug: invoiceDetailJson["id_drug"],
      quantity: invoiceDetailJson["quantity"],
      idInvoice: invoiceDetailJson["id_invoice"],
      drug: DrugModel.fromJson(drugJson)
    );
  }
}