class TotalMoneyModel {
  String? month;
  String? totalMoney;

  TotalMoneyModel({this.month, this.totalMoney});

  factory TotalMoneyModel.fromJson(Map<String, dynamic> json) {
    return TotalMoneyModel(
      month: json['month'] as String?,
      totalMoney: (json['total_money'] as String?),
    );
  }

  // Method to convert an instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'month': month,
      'total_money': totalMoney,
    };
  }
}
