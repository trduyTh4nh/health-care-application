import 'package:intl/intl.dart';

import 'package:json_annotation/json_annotation.dart';
import 'package:timezone/timezone.dart';

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
  int? idPayment; // khóa ngoại
  int? idScheduleDetail;
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
      this.isComfirmed,
      this.idScheduleDetail});

  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      _$NotificationModelFromJson(json);
  Map<String, dynamic> toJson() => _$NotificationModelToJson(this);

  String convertTime(DateTime time) {
    final now = TZDateTime.now(local);
    final tzTime = TZDateTime.from(time, local);
    final difference = now.difference(tzTime);
    if (difference.inMinutes < 1) {
      return "Vừa xong • ${DateFormat("hh:mm").format(tzTime)}";
    } else if (difference.inMinutes < 60) {
      return "${difference.inMinutes} Phút trước • ${DateFormat("HH:mm").format(tzTime)}";
    } else if (difference.inHours < 24) {
      return "${difference.inHours} Giờ trước • ${DateFormat("HH:mm").format(tzTime)}";
    } else if (difference.inDays < 7) {
      return "${difference.inDays} Ngày trước • ${DateFormat("dd/MM/yyyy HH:mm").format(tzTime)}";
    } else {
      return "${(difference.inDays / 7).floor()} Tuần trước • ${DateFormat("dd/MM/yyyy HH:mm").format(tzTime)}";
    }
  }
}

var enumPriority = [
  "normal",
  "overdue", // red
  "delivery",
  "confirm",
  "runoutof", // red
  "important"
];

DateFormat dateFormat = DateFormat("yyyy-MM-dd HH:mm:ss");
DateTime dateTime = dateFormat.parse("2019-07-19 8:40:23");
String string = dateFormat.format(DateTime.now());

var listNotification = [];
