import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

Widget leftTitleWidgets(double value, TitleMeta meta) {
  const style = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 15,
  );
  String text;
  switch (value.toInt()) {
    case 2:
      text = '2k';
      break;
    case 4:
      text = '4k';
      break;
    case 7:
      text = '7k';
      break;
    default:
      return Container();
  }

  return Text(text, style: style, textAlign: TextAlign.left);
}
