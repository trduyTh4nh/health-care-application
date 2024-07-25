class HistoryStransactionModel {
  int? idInvoice;
  int? idUser;
  // DateTime? createDate;
  String? createDate;
  double? totalPrice;
  bool? status;
  String? notes;
  int? idAddress;
  String? idPayPal;

  HistoryStransactionModel({
    this.idInvoice,
    this.idUser,
    this.createDate,
    this.totalPrice,
    this.status,
    this.notes,
    this.idAddress,
    this.idPayPal,
  });

  factory HistoryStransactionModel.fromJson(Map<String, dynamic> json) {
    return HistoryStransactionModel(
      idInvoice: json['id_invoice'],
      idUser: json['id_user'],
      // createDate: DateTime.parse(
      //     json['create_date'] ?? DateTime.now().toIso8601String()),
      createDate: json['create_date'],
      totalPrice: json['total_price'] is String
          ? double.tryParse(json['total_price']) ?? 0
          : json['total_price'].toDouble(),
      status: json['status'],
      notes: json['notes'],
      idAddress: json['id_address'],
      idPayPal: json['id_paypal'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id_invoice': idInvoice,
      'id_user': idUser,
      // 'create_date': createDate?.toIso8601String(),
      'create_date': createDate,
      'total_price': totalPrice,
      'status': status,
      'notes': notes,
      'id_address': idAddress,
      'id_paypal': idPayPal,
    };
  }
}
