import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

Widget bottomTitleWidgets(double value, TitleMeta meta) {
  const style = TextStyle(
    fontSize: 10,
  );
  Widget text;
  switch (value.toInt()) {
    case 0:
      text = const Text('0', style: style);
      break;
    case 1:
      text = const Text('JAN', style: style);
      break;
    case 2:
      text = const Text('FEB', style: style);
      break;
    case 3:
      text = const Text("MAR", style: style);
    case 4:
      text = const Text("APR", style: style);
    case 5:
      text = const Text("MAY", style: style);
    case 6:
      text = const Text("JUN", style: style);
    case 7:
      text = const Text("JUL", style: style);
    case 8:
      text = const Text("AUG", style: style);
    case 9:
      text = const Text("SEP", style: style);
    case 10:
      text = const Text("OCT", style: style);
    case 11:
      text = const Text("NOV", style: style);
    case 12:
      text = const Text("DEC", style: style);
    default:
      text = const Text('', style: style);
      break;
  }

  return SideTitleWidget(
    axisSide: meta.axisSide,
    child: text,
  );
}
