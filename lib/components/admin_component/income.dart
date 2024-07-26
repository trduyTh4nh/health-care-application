import 'package:app_well_mate/main.dart';
import 'package:app_well_mate/utils/app.colors.dart';
import 'package:app_well_mate/utils/some.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

class IncomePage extends StatefulWidget {
  const IncomePage({super.key});

  @override
  State<IncomePage> createState() => _IncomePageState();
}

class _IncomePageState extends State<IncomePage> {
  final List<Map<String, dynamic>> _years = [
    {'id': 0, 'year': '2019'},
    {'id': 1, 'year': '2020'},
    {'id': 2, 'year': '2021'},
    {'id': 3, 'year': '2022'},
    {'id': 4, 'year': '2023'},
  ];

  List<List<BarChartGroupData>> get monthSpots =>
      [barGroups1, barGroups2, barGroups2, barGroups3, barGroups4];
  List<BarChartGroupData>? currentPot;
  List<BarChartGroupData>? beforePot;
  Map<String, dynamic>? _dropDownValue;

  double totalCurrentPot = 0;
  double totalBeforePot = 0;
  int totalUpPercent = 0;

  @override
  void initState() {
    _dropDownValue = _years[0];
    currentPot = monthSpots[0];
    totalCurrentPot = 0;
    totalBeforePot = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final sizeWidth = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                child: Text(
                  "Doanh thu trong năm",
                  style: Theme.of(context).textTheme.bodyLarge,
                )),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          height: 40,
                          decoration: BoxDecoration(
                              // color: const Color.fromARGB(255, 200, 211, 230),
                              borderRadius: BorderRadius.circular(6),
                              border: Border.all(
                                  color: totalUpPercent > 0
                                      ? Colors.greenAccent
                                      : Colors.redAccent,
                                  width: 2)),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                totalUpPercent > 0
                                    ? Symbols.arrow_upward_alt
                                    : Symbols.arrow_downward_alt,
                                color: totalUpPercent > 0
                                    ? Colors.greenAccent
                                    : Colors.redAccent,
                              ),
                              const SizedBox(
                                width: 4,
                              ),
                              Text(
                                "$totalUpPercent%",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                        color: AppColors.primaryColor,
                                        fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Text(
                              "${checkPercent(totalUpPercent)} so với năm ngoái",
                              style: Theme.of(context).textTheme.bodyMedium),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 0),
                    child: SizedBox(
                        width: 100,
                        child: DropdownButton<Map<String, dynamic>>(
                          isExpanded: true,
                          value: _dropDownValue,
                          icon: const Icon(Icons.arrow_drop_down),
                          elevation: 16,
                          style: const TextStyle(color: Colors.black),
                          underline: Container(
                            height: 4,
                            color: AppColors.primaryColor,
                          ),
                          items: _years
                              .map<DropdownMenuItem<Map<String, dynamic>>>(
                            (Map<String, dynamic> value) {
                              return DropdownMenuItem<Map<String, dynamic>>(
                                value: value,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Icon(Symbols.calendar_today),
                                      Text(
                                        value['year'] as String,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ).toList(),
                          onChanged: (Map<String, dynamic>? value) {
                            setState(() {
                              _dropDownValue = value;
                              totalCurrentPot = 0;
                              totalBeforePot = 0;
                              currentPot = monthSpots[_dropDownValue?['id']];
                              //
                              for (var element in currentPot!) {
                                totalCurrentPot += element.barRods[0].toY;
                              }

                              print("totalCurrentPot: ${totalCurrentPot}");
                              if (_dropDownValue?['id'] > 0) {
                                beforePot =
                                    monthSpots[(_dropDownValue)?['id'] - 1];
                                for (var element in beforePot!) {
                                  totalBeforePot += element.barRods[0].toY;
                                }
                                print("totalBeforePot: ${totalBeforePot}");

                                totalUpPercent =
                                    (((totalCurrentPot - totalBeforePot) /
                                                totalBeforePot) *
                                            100)
                                        .toInt();

                                print("totalUpPercent: ${totalUpPercent}");
                              } else {
                                beforePot = monthSpots[(_dropDownValue)?['id']];
                              }
                              // kiểm tra current lớn hơn thì nó đang giảm, còn ngược lại thì nó tăng
                            });
                          },
                        )),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 600,
              width: sizeWidth,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: BarChart(
                  BarChartData(
                    barTouchData: barTouchData,
                    titlesData: titlesData,
                    borderData: borderData,
                    barGroups: currentPot,
                    gridData: FlGridData(
                      show: true,
                      drawVerticalLine: true,
                      horizontalInterval: 2,
                      verticalInterval: 2,
                      getDrawingHorizontalLine: (value) {
                        return const FlLine(
                          color: Colors.black38,
                          strokeWidth: 0,
                        );
                      },
                      getDrawingVerticalLine: (value) {
                        return const FlLine(
                          color: Colors.white,
                          strokeWidth: 6,
                        );
                      },
                    ),
                    alignment: BarChartAlignment.spaceAround,
                    maxY: 35,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  BarTouchData get barTouchData => BarTouchData(
        touchTooltipData: BarTouchTooltipData(
          getTooltipColor: (group) => Colors.transparent,
          tooltipPadding: EdgeInsets.zero,
          tooltipMargin: 5,
          getTooltipItem: (
            BarChartGroupData group,
            int groupIndex,
            BarChartRodData rod,
            int rodIndex,
          ) {
            return BarTooltipItem(
              rod.toY.round().toString(),
              const TextStyle(
                color: Colors.redAccent,
                fontWeight: FontWeight.bold,
              ),
            );
          },
        ),
      );

  Widget getTitles(double value, TitleMeta meta) {
    var style = const TextStyle(
      color: AppColors.primaryColor,
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );
    String text;
    switch (value.toInt()) {
      case 0:
        text = '1';
        break;
      case 1:
        text = '2';
        break;

      case 3:
        text = '4';
        break;

      case 5:
        text = '6';
        break;
      case 7:
        text = '8';
        break;
      case 9:
        text = '10';
        break;
      case 11:
        text = '12';
        break;
      default:
        text = '';
        break;
    }
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 4,
      child: Text(text, style: style),
    );
  }

  FlTitlesData get titlesData => FlTitlesData(
        show: true,
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            getTitlesWidget: getTitles,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 28,
            interval: 3,
            getTitlesWidget: (value, meta) {
              return Text(
                value.toString(),
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: value % 2 == 0
                      ? colorScheme.primary
                      : Colors
                          .green, // Different colors for even and odd values
                ),
              );
            },
          ),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        rightTitles: const AxisTitles(),
      );

  FlBorderData get borderData => FlBorderData(
        show: true,
        border: Border.all(
          color: colorScheme.primary,
          width: 2,
        ),
      );

  LinearGradient get _barsGradient => const LinearGradient(
        colors: [
          Color.fromARGB(255, 208, 255, 221),
          Color.fromARGB(255, 129, 255, 150),
          Color.fromARGB(255, 116, 248, 121),
        ],
        begin: Alignment.bottomCenter,
        end: Alignment.topCenter,
      );
}

String checkPercent(int number) {
  if (number > 0) {
    return "Tăng";
  } else if (number < 0) {
    return "Giảm";
  } else {
    return "Bằng";
  }
}
