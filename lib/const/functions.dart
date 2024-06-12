import 'package:flutter/material.dart';

int toSecond(TimeOfDay time){
  return time.hour * 3600 + time.minute * 60;
}
TimeOfDay toTime(int second){
  var hour = (second / 3600).floor();
  return TimeOfDay(hour: hour, minute: ((second - (hour * 3600)) / 60).floor());
}