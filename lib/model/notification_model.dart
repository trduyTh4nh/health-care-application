import 'dart:math';
import 'package:intl/intl.dart';

import 'package:json_annotation/json_annotation.dart';


part 'json/notification_model.g.dart';
@JsonSerializable()
class NotificationModel {
  int? id;
  String? content;
  DateTime? time;
  String? priority;
  bool? status; // trạng thái đã đọc hay chưa động
  bool? isComfirmed; // trạng thái đã comfirm thông báo chưa
  int? userId; // khóa ngoại
  int? idDonThuocCT; // khóa ngoại
  int? idOrder; // khóa ngoại
  int? idPayment;  // khóa ngoại

  
  NotificationModel(
      {this.id,
      this.content,
      this.time,
      this.priority,
      this.status,
      this.userId,
      this.idDonThuocCT,
      this.idOrder,
      this.idPayment,
      this.isComfirmed});

  factory NotificationModel.fromJson(Map<String, dynamic> json) => _$NotificationModelFromJson(json);
  Map<String, dynamic> toJson() => _$NotificationModelToJson(this);

  String convertTime(DateTime time) {
    final now = DateTime.now();
    final difference = now.difference(time);

    if (difference.inMinutes < 1) {
      return "Vừa xong";
    } else if (difference.inMinutes < 60) {
      return "${difference.inMinutes} Phút trước";
    } else if (difference.inHours < 24) {
      return "${difference.inHours} Giờ trước";
    } else if (difference.inDays < 7) {
      return "${difference.inDays} Ngày trước";
    } else {
      return "${(difference.inDays / 7).floor()} Tuần trước";
    }
  }
}

var enumPriority = [
  "normal",
  "overdue", // red
  "delivery",
  "confirm",
  "runoutof" // red
];

DateFormat dateFormat = DateFormat("yyyy-MM-dd HH:mm:ss");
DateTime dateTime = dateFormat.parse("2019-07-19 8:40:23");
String string = dateFormat.format(DateTime.now());

var listNotification = [
  NotificationModel(
      id: 1,
      content:
          "Đã hết thuốc Paracetamol 30mg, ấn vào thông báo này để xem chi tiết",
      time: dateFormat.parse("2024-04-19 8:40:23"),
      priority: enumPriority[Random().nextInt(enumPriority.length)],
      status: true,
      userId: 1,
      idDonThuocCT: 1001),
  NotificationModel(
      id: 2,
      content: "Đã quá 2 giờ kế từ giờ uống Paracetamol của bạn",
      time: dateFormat.parse("2024-06-13 8:40:23"),
      priority: enumPriority[Random().nextInt(enumPriority.length)],
      status: false,
      userId: 1,
      idDonThuocCT: 1001),
  NotificationModel(
      id: 3,
      content: "Đã đến giờ uống Paracetamol 30mg",
      time: dateFormat.parse("2024-03-12 8:40:23"),
      priority: enumPriority[Random().nextInt(enumPriority.length)],
      status: true,
      userId: 1,
      idDonThuocCT: 1001),
  NotificationModel(
      id: 4,
      content: "Đơn thuốc #2491 của bạn đang được giao",
      time: dateFormat.parse("2024-01-12 8:40:23"),
      priority: enumPriority[Random().nextInt(enumPriority.length)],
      status: false,
      userId: 1,
      idDonThuocCT: 1001),
  NotificationModel(
      id: 5,
      content: "Đã đến giờ sử dụng thuốc Nhỏ mắt 1 giọt",
      time: dateFormat.parse("2024-06-14 2:40:23"),
      priority: enumPriority[Random().nextInt(enumPriority.length)],
      status: true,
      userId: 1,
      idDonThuocCT: 1001),
  NotificationModel(
      id: 6,
      content: "Đơn thuốc #3002 của bạn đang được giao",
      time: dateFormat.parse("2023-12-12 1:40:23"),
      priority: enumPriority[Random().nextInt(enumPriority.length)],
      status: false,
      userId: 1,
      idDonThuocCT: 1001),
  NotificationModel(
      id: 7,
      content: "Đơn thuốc #333301 của bạn đang được giao",
      time: dateFormat.parse("2023-01-11 8:40:23"),
      priority: enumPriority[Random().nextInt(enumPriority.length)],
      status: true,
      userId: 1,
      idDonThuocCT: 1001),
];
