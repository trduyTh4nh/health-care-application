import 'package:intl/intl.dart';

String convertCurrency(amount) {
  var currencyFormat = NumberFormat.currency(locale: 'vi_VN', symbol: 'vnđ');

  return currencyFormat.format(amount);
}
