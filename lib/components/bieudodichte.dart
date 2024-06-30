import 'package:app_well_mate/components/bottomTitleWidgets.dart';
import 'package:app_well_mate/components/leftTitleWidgets.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class Bieudodichte extends StatefulWidget {
  const Bieudodichte({super.key});

  @override
  State<Bieudodichte> createState() => _BieudodichteState();
}

class _BieudodichteState extends State<Bieudodichte>
    with TickerProviderStateMixin {
  String dropdownValue01 = 'Sốt xuất huyết';
  List<Color> gradientColors = [
    Colors.blue,
    Colors.white,
  ];
  @override
  Widget build(BuildContext context) {
    final sizeHeight = MediaQuery.of(context).size.height;
    final sizeWidht = MediaQuery.of(context).size.width;
    const List<String> list01 = <String>[
      'Sốt xuất huyết',
      'Cảm',
      'Ngứa',
      'Đậu Mùa'
    ];
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: DropdownButton<String>(
            isExpanded: true,
            value: dropdownValue01, // Sử dụng biến trạng thái ở đây
            items: list01.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Row(
                  children: [
                    const Icon(Icons.coronavirus_outlined),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(value)
                  ],
                ),
              );
            }).toList(),
            onChanged: (String? value) {
              setState(() {
                dropdownValue01 = value!; // Cập nhật biến trạng thái
                print(dropdownValue01);
              });
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 16, left: 10, right: 10),
          child: SizedBox(
            width: sizeWidht,
            height: sizeHeight * 0.35,
            child: LineChart(
              LineChartData(
                gridData: FlGridData(
                  show: true,
                  drawVerticalLine: true,
                  horizontalInterval: 1,
                  verticalInterval: 1,
                  getDrawingHorizontalLine: (value) {
                    return const FlLine(
                      color: Colors.black38,
                      strokeWidth: 1,
                    );
                  },
                  getDrawingVerticalLine: (value) {
                    return const FlLine(
                      color: Colors.black38,
                      strokeWidth: 1,
                    );
                  },
                ),
                titlesData: const FlTitlesData(
                  show: true,
                  rightTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  topTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 30,
                      interval: 1,
                      // tilte cho bên dưới
                      getTitlesWidget: bottomTitleWidgets,
                    ),
                  ),
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      interval: 1,
                      // title cho bên trái
                      getTitlesWidget: leftTitleWidgets,
                      reservedSize: 25,
                    ),
                  ),
                ),
                borderData: FlBorderData(
                  show: true,
                  border: Border.all(color: const Color(0xff37434d)),
                ),
                minX: 0,
                maxX: 12,
                minY: 0,
                maxY: 8,
                lineBarsData: [
                  // nơi lấy dữ liệu cho biểu đồ
                  LineChartBarData(
                    spots: const [
                      FlSpot(0, 3),
                      FlSpot(1, 2.1),
                      FlSpot(2, 3),
                      FlSpot(3, 6),
                      FlSpot(4, 7.3),
                      FlSpot(5, 1.3),
                      FlSpot(6, 4),
                      FlSpot(7, 0.6),
                      FlSpot(8, 2),
                      FlSpot(9, 1),
                      FlSpot(10, 3),
                      FlSpot(11, 5.5),
                      FlSpot(12, 2.6),
                    ],
                    isCurved: true,
                    // gradient: LinearGradient(
                    //   colors: gradientColors,
                    // ),
                    color: Colors.blue[400],
                    barWidth: 5,
                    isStrokeCapRound: true,
                    dotData: const FlDotData(
                      show: true,
                    ),
                    belowBarData: BarAreaData(
                      show: true,
                      gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          stops: [0.7, 1],
                          colors: gradientColors
                              .map((Color color) => color.withOpacity(0.7))
                              .toList()),
                    ),
                  ),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
