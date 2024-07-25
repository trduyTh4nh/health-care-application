import 'package:intl/intl.dart';

String convertCurrency(amount) {
  var currencyFormat = NumberFormat.currency(locale: 'vi_VN', symbol: 'vnđ');

  return currencyFormat.format(amount);
}

String formatDate(DateTime date) {
  return DateFormat('dd/MM/yyyy').format(date);
}

List<Map<String, dynamic>> vietNemprovince = [
  {"id": 1, "name": "An Giang", "postal_code": "880000", "area_code": 296},
  {
    "id": 2,
    "name": "Bà Rịa Vũng Tàu",
    "postal_code": "790000",
    "area_code": 254
  },
  {"id": 3, "name": "Bạc Liêu", "postal_code": "260000", "area_code": 291},
  {"id": 4, "name": "Bắc Kạn", "postal_code": "960000", "area_code": 209},
  {"id": 5, "name": "Bắc Giang", "postal_code": "220000", "area_code": 204},
  {"id": 6, "name": "Bắc Ninh", "postal_code": "790000", "area_code": 222},
  {"id": 7, "name": "Bến Tre", "postal_code": "930000", "area_code": 275},
  {"id": 8, "name": "Bình Dương", "postal_code": "590000", "area_code": 274},
  {"id": 9, "name": "Bình Định", "postal_code": "820000", "area_code": 256},
  {"id": 10, "name": "Bình Phước", "postal_code": "830000", "area_code": 271},
  {"id": 11, "name": "Bình Thuận", "postal_code": "800000", "area_code": 252},
  {"id": 12, "name": "Cà Mau", "postal_code": "970000", "area_code": 290},
  {"id": 13, "name": "Cao Bằng", "postal_code": "270000", "area_code": 206},
  {"id": 14, "name": "Cần Thơ", "postal_code": "900000", "area_code": 292},
  {"id": 15, "name": "Đà Nẵng", "postal_code": "550000", "area_code": 236},
  {"id": 16, "name": "Điện Biên", "postal_code": "380000", "area_code": 215},
  {"id": 17, "name": "Đắk Lắk", "postal_code": "630000", "area_code": 262},
  {"id": 18, "name": "Đắc Nông", "postal_code": "640000", "area_code": 261},
  {"id": 19, "name": "Đồng Nai", "postal_code": "810000", "area_code": 251},
  {"id": 20, "name": "Đồng Tháp", "postal_code": "870000", "area_code": 277},
  {"id": 21, "name": "Gia Lai", "postal_code": "600000", "area_code": 269},
  {"id": 22, "name": "Hà Giang", "postal_code": "310000", "area_code": 219},
  {"id": 23, "name": "Hà Nam", "postal_code": "400000", "area_code": 226},
  {"id": 24, "name": "Hà Nội", "postal_code": "100000", "area_code": 24},
  {"id": 25, "name": "Hà Tĩnh", "postal_code": "480000", "area_code": 239},
  {"id": 26, "name": "Hải Dương", "postal_code": "170000", "area_code": 220},
  {"id": 27, "name": "Hải Phòng", "postal_code": "180000", "area_code": 225},
  {"id": 28, "name": "Hậu Giang", "postal_code": "910000", "area_code": 293},
  {"id": 29, "name": "Hòa Bình", "postal_code": "350000", "area_code": 218},
  {"id": 30, "name": "Hồ Chí Minh", "postal_code": "700000", "area_code": 28},
  {"id": 31, "name": "Hưng Yên", "postal_code": "160000", "area_code": 221},
  {"id": 32, "name": "Khánh Hoà", "postal_code": "650000", "area_code": 258},
  {"id": 33, "name": "Kiên Giang", "postal_code": "920000", "area_code": 297},
  {"id": 34, "name": "Kon Tum", "postal_code": "580000", "area_code": 260},
  {"id": 35, "name": "Lai Châu", "postal_code": "390000", "area_code": 213},
  {"id": 36, "name": "Lạng Sơn", "postal_code": "240000", "area_code": 205},
  {"id": 37, "name": "Lào Cai", "postal_code": "330000", "area_code": 214},
  {"id": 38, "name": "Lâm Đồng", "postal_code": "670000", "area_code": 263},
  {"id": 39, "name": "Long An", "postal_code": "850000", "area_code": 272},
  {"id": 40, "name": "Nam Định", "postal_code": "420000", "area_code": 228},
  {
    "id": 41,
    "name": "Nghệ An",
    "postal_code": "460000 - 470000",
    "area_code": 238
  },
  {"id": 42, "name": "Ninh Bình", "postal_code": "430000", "area_code": 229},
  {"id": 43, "name": "Ninh Thuận", "postal_code": "660000", "area_code": 259},
  {"id": 44, "name": "Phú Thọ", "postal_code": "290000", "area_code": 210},
  {"id": 45, "name": "Phú Yên", "postal_code": "620000", "area_code": 257},
  {"id": 46, "name": "Quảng Bình", "postal_code": "510000", "area_code": 232},
  {"id": 47, "name": "Quảng Nam", "postal_code": "560000", "area_code": 235},
  {"id": 48, "name": "Quảng Ngãi", "postal_code": "570000", "area_code": 255},
  {"id": 49, "name": "Quảng Ninh", "postal_code": "200000", "area_code": 203},
  {"id": 50, "name": "Quảng Trị", "postal_code": "520000", "area_code": 233},
  {"id": 51, "name": "Sóc Trăng", "postal_code": "950000", "area_code": 299},
  {"id": 52, "name": "Sơn La", "postal_code": "360000", "area_code": 212},
  {"id": 53, "name": "Tây Ninh", "postal_code": "840000", "area_code": 276},
  {"id": 54, "name": "Thái Bình", "postal_code": "410000", "area_code": 227},
  {"id": 55, "name": "Thái Nguyên", "postal_code": "250000", "area_code": 208},
  {
    "id": 56,
    "name": "Thanh Hoá",
    "postal_code": "440000 - 450000",
    "area_code": 237
  },
  {
    "id": 57,
    "name": "Thừa Thiên Huế",
    "postal_code": "530000",
    "area_code": 234
  },
  {"id": 58, "name": "Tiền Giang", "postal_code": "860000", "area_code": 273},
  {"id": 59, "name": "Trà Vinh", "postal_code": "940000", "area_code": 294},
  {"id": 60, "name": "Tuyên Quang", "postal_code": "300000", "area_code": 207},
  {"id": 61, "name": "Vĩnh Long", "postal_code": "890000", "area_code": 270},
  {"id": 62, "name": "Vĩnh Phúc", "postal_code": "280000", "area_code": 211},
  {"id": 63, "name": "Yên Bái", "postal_code": "320000", "area_code": 216}
];
