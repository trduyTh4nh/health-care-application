import 'package:app_well_mate/const/color_scheme.dart';
import 'package:app_well_mate/main.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

class ReturnPage extends StatefulWidget {
  const ReturnPage({super.key});

  @override
  State<ReturnPage> createState() => _ReturnPageState();
}

class _ReturnPageState extends State<ReturnPage> {
  List<int> showingTooltipOnSpots = [1, 3, 5];
  List<FlSpot> get allSpots1 => const [
        FlSpot(0, 1),
        FlSpot(1, 2),
        FlSpot(2, 2.5),
        FlSpot(3, 3),
        FlSpot(4, 5.5),
        FlSpot(5, 5),
        FlSpot(6, 6),
        FlSpot(7, 6.5),
        FlSpot(8, 7),
        FlSpot(9, 7.4),
        FlSpot(10, 7.5),
        FlSpot(11, 9),
      ];
  List<FlSpot> get allSpots2 => const [
        FlSpot(0, 10),
        FlSpot(1, 6),
        FlSpot(2, 6.5),
        FlSpot(3, 4),
        FlSpot(4, 9.5),
        FlSpot(5, 4),
        FlSpot(6, 3.5),
        FlSpot(7, 7.5),
        FlSpot(8, 7),
        FlSpot(9, 7.4),
        FlSpot(10, 7.5),
        FlSpot(11, 15),
      ];
  List<FlSpot> get allSpots3 => const [
        FlSpot(0, 4.2),
        FlSpot(1, 2.3),
        FlSpot(2, 2.5),
        FlSpot(3, 4.8),
        FlSpot(4, 5.5),
        FlSpot(5, 5.9),
        FlSpot(6, 6.3),
        FlSpot(7, 7.5),
        FlSpot(8, 8),
        FlSpot(9, 4.4),
        FlSpot(10, 6.5),
        FlSpot(11, 7.5),
      ];
  List<FlSpot> get allSpots4 => const [
        FlSpot(0, 5.4),
        FlSpot(1, 4.5),
        FlSpot(2, 1.9),
        FlSpot(3, 3.3),
        FlSpot(4, 4.5),
        FlSpot(5, 5.6),
        FlSpot(6, 6.6),
        FlSpot(7, 9.5),
        FlSpot(8, 4),
        FlSpot(9, 4.4),
        FlSpot(10, 6.5),
        FlSpot(11, 7),
      ];
  List<List<FlSpot>> get monthSpots =>
      [allSpots1, allSpots2, allSpots3, allSpots4];

  Widget bottomTitleWidgets(double value, TitleMeta meta, double chartWidth) {
    final style = TextStyle(
      fontWeight: FontWeight.bold,
      color: colorScheme.primary,
      fontFamily: 'Digital',
      fontSize: 18 * chartWidth / 500,
    );

    String text;
    switch (value.toInt()) {
      case 0:
        text = '1';
        break;
      case 1:
        text = '2';
        break;
      case 2:
        text = '3';
        break;
      case 3:
        text = '4';
        break;
      case 4:
        text = '5';
        break;
      case 5:
        text = '6';
        break;
      case 6:
        text = '7';
        break;
      case 7:
        text = '8';
        break;
      case 8:
        text = '9';
        break;
      case 9:
        text = '10';
        break;
      case 10:
        text = '11';
        break;
      case 11:
        text = '12';
        break;
      default:
        return Container();
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: Text(text, style: style),
    );
  }

  final List<Map<String, dynamic>> _years = [
    {'id': 0, 'year': '2019'},
    {'id': 1, 'year': '2020'},
    {'id': 2, 'year': '2021'},
    {'id': 3, 'year': '2022'},
  ];

  Map<String, dynamic>? _dropDownValue;
  List<FlSpot>? currentPot;
  @override
  void initState() {
    super.initState();
    _dropDownValue = _years[0];
    currentPot = monthSpots[0];
  }

  @override
  Widget build(BuildContext context) {
    var sizeHeight = MediaQuery.of(context).size.height;
    final lineBarsData = [
      LineChartBarData(
        showingIndicators: showingTooltipOnSpots,
        spots: currentPot!,
        isCurved: true,
        barWidth: 4,
        belowBarData: BarAreaData(
          show: true,
          gradient: LinearGradient(
            colors: [
              const Color.fromARGB(255, 193, 207, 255).withOpacity(0.4),
              const Color.fromARGB(255, 127, 157, 255).withOpacity(0.4),
              const Color.fromARGB(255, 29, 82, 255).withOpacity(0.4),
            ],
          ),
        ),
        dotData: const FlDotData(show: false),
        gradient: const LinearGradient(
          colors: [
            Color.fromARGB(255, 193, 207, 255),
            Color.fromARGB(255, 127, 157, 255),
            Color.fromARGB(255, 29, 82, 255),
          ],
          stops: [0.1, 0.4, 0.9],
        ),
      ),
    ];

    final tooltipsOnBar = lineBarsData[0];

    return SingleChildScrollView(
        child: Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
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
                    color: Colors
                        .blue, // Adjust colorScheme.primary to Colors.blue for example
                  ),
                  items: _years.map<DropdownMenuItem<Map<String, dynamic>>>(
                    (Map<String, dynamic> value) {
                      return DropdownMenuItem<Map<String, dynamic>>(
                        value: value,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Icon(Symbols.calendar_today),
                            Text(
                              value['year'] as String,
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      );
                    },
                  ).toList(),
                  onChanged: (Map<String, dynamic>? value) {
                    setState(() {
                      _dropDownValue = value;
                      currentPot = monthSpots[_dropDownValue?['id']];
                      print(_dropDownValue?['id']);
                    });
                  },
                )),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 12, 0),
            child: LayoutBuilder(
              builder: (context, constraints) {
                return SizedBox(
                  width: double.infinity,
                  height: sizeHeight * 0.7,
                  child: LineChart(LineChartData(
                    showingTooltipIndicators:
                        showingTooltipOnSpots.map((index) {
                      return ShowingTooltipIndicators([
                        LineBarSpot(
                          tooltipsOnBar,
                          lineBarsData.indexOf(tooltipsOnBar),
                          tooltipsOnBar.spots[index],
                        ),
                      ]);
                    }).toList(),
                    lineTouchData: LineTouchData(
                      enabled: true,
                      handleBuiltInTouches: false,
                      touchCallback:
                          (FlTouchEvent event, LineTouchResponse? response) {
                        if (response == null || response.lineBarSpots == null) {
                          return;
                        }
                        if (event is FlTapUpEvent) {
                          final spotIndex =
                              response.lineBarSpots!.first.spotIndex;
                          setState(() {
                            if (showingTooltipOnSpots.contains(spotIndex)) {
                              showingTooltipOnSpots.remove(spotIndex);
                            } else {
                              showingTooltipOnSpots.add(spotIndex);
                            }
                          });
                        }
                      },
                      mouseCursorResolver:
                          (FlTouchEvent event, LineTouchResponse? response) {
                        if (response == null || response.lineBarSpots == null) {
                          return SystemMouseCursors.basic;
                        }
                        return SystemMouseCursors.click;
                      },
                      getTouchedSpotIndicator:
                          (LineChartBarData barData, List<int> spotIndexes) {
                        return spotIndexes.map((index) {
                          return TouchedSpotIndicatorData(
                            FlLine(
                              color: colorScheme.primary,
                            ),
                            FlDotData(
                              show: true,
                              getDotPainter: (spot, percent, barData, index) =>
                                  FlDotCirclePainter(
                                radius: 8,
                                color: lerpGradient(
                                  barData.gradient!.colors,
                                  barData.gradient!.stops!,
                                  percent / 100,
                                ),
                                strokeWidth: 2,
                                strokeColor: AppColor.red,
                              ),
                            ),
                          );
                        }).toList();
                      },
                      touchTooltipData: LineTouchTooltipData(
                          getTooltipColor: (touchedSpot) => colorScheme.primary,
                          tooltipRoundedRadius: 8,
                          getTooltipItems: (List<LineBarSpot> lineBarsSpot) {
                            return lineBarsSpot.map((lineBarSpot) {
                              return LineTooltipItem(
                                lineBarSpot.y.toString(),
                                const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              );
                            }).toList();
                          }),
                    ),
                    lineBarsData: lineBarsData,
                    minY: 0,
                    titlesData: FlTitlesData(
                      leftTitles: AxisTitles(
                        axisNameWidget: Text(
                          'Lợi nhuận',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        axisNameSize: 24,
                        sideTitles: const SideTitles(
                          showTitles: false,
                          reservedSize: 0,
                        ),
                      ),
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          interval: 1,
                          getTitlesWidget: (value, meta) {
                            return bottomTitleWidgets(
                              value,
                              meta,
                              constraints.maxWidth,
                            );
                          },
                          reservedSize: 30,
                        ),
                      ),
                      rightTitles: const AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: false,
                          reservedSize: 0,
                        ),
                      ),
                      topTitles: AxisTitles(
                        axisNameWidget: Text(
                          'Tháng',
                          textAlign: TextAlign.left,
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        axisNameSize: 24,
                        sideTitles: const SideTitles(
                          showTitles: true,
                          reservedSize: 0,
                        ),
                      ),
                    ),
                    gridData: const FlGridData(
                      show: true,
                    ),
                    borderData: FlBorderData(
                      show: true,
                      border: Border.all(
                        color: colorScheme.primary,
                        width: 2,
                      ),
                    ),
                  )),
                );
              },
            ),
          ),
        ],
      ),
    ));
  }
}

Color lerpGradient(List<Color> colors, List<double> stops, double t) {
  if (colors.isEmpty) {
    throw ArgumentError('"colors" is empty.');
  } else if (colors.length == 1) {
    return colors[0];
  }

  if (stops.length != colors.length) {
    stops = [];

    /// provided gradientColorStops is invalid and we calculate it here
    colors.asMap().forEach((index, color) {
      final percent = 1.0 / (colors.length - 1);
      stops.add(percent * index);
    });
  }

  for (var s = 0; s < stops.length - 1; s++) {
    final leftStop = stops[s];
    final rightStop = stops[s + 1];
    final leftColor = colors[s];
    final rightColor = colors[s + 1];
    if (t <= leftStop) {
      return leftColor;
    } else if (t < rightStop) {
      final sectionT = (t - leftStop) / (rightStop - leftStop);
      return Color.lerp(leftColor, rightColor, sectionT)!;
    }
  }
  return colors.last;
}
