import 'package:app_well_mate/api/disease/disease_admin_repo.dart';
import 'package:app_well_mate/components/bottomTitleWidgets.dart';
import 'package:app_well_mate/components/leftTitleWidgets.dart';
import 'package:app_well_mate/main.dart';
import 'package:app_well_mate/model/disease.dart';
import 'package:app_well_mate/model/diseaseOfYear.dart';
import 'package:app_well_mate/screen/search/component_crawl.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class Bieudodichte extends StatefulWidget {
  const Bieudodichte({super.key});

  @override
  State<Bieudodichte> createState() => _BieudodichteState();
}

class _BieudodichteState extends State<Bieudodichte>
    with TickerProviderStateMixin {

  String? dropdownValue01;
  List<String> diseaseNames = [];
  List<Color> gradientColors = [
    Colors.blue,
    Colors.white,
  ];
  List<Disease> allDes=[];
    List<Diseaseofyear> diseaseDataOfYear = [];

 



  @override
  void initState() {
    super.initState();
    fetchDiseaseNames();
    getAllDisease();
    DiseaseAdminRepo().getNumDiseaseOfYear(10, 2024);
  }
  Future<void> fetchDiseaseDataOfYear(int idDis, int year)async{
    try {
      DiseaseAdminRepo repo = DiseaseAdminRepo();
      List<Diseaseofyear> data = await repo.getNumDiseaseOfYear(idDis, year);

      setState(() {
        diseaseDataOfYear = data; // Lưu dữ liệu bệnh của năm vào biến
      });
    } catch (ex) {
      print("Error fetching disease data: $ex");
    }
  }
 Future<List<Disease>> getAllDisease()async{
     allDes=await DiseaseAdminRepo().getAllDisease();
    setState(() {
      if(allDes.isNotEmpty){
         dropdownValue01 =allDes[0].disease_name; 
      }
    });
    return allDes;
  }
  Future<void> fetchDiseaseNames() async {
    try {
      DiseaseAdminRepo repo = DiseaseAdminRepo();
      List<String> names = await repo.getDiseaseNames();

      setState(() {
        if (names.isNotEmpty) {
          diseaseNames = names;
          dropdownValue01 = diseaseNames.first; 
        }
      });
    } catch (ex) {
      print("Error fetching disease names: $ex");
    }
  }

  @override
  Widget build(BuildContext context) {
    final sizeHeight = MediaQuery.of(context).size.height;
    final sizeWidth = MediaQuery.of(context).size.width;

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: DropdownButton<String>(
            isExpanded: true,
            value: dropdownValue01,
            items: allDes.map<DropdownMenuItem<String>>((Disease valuee) {
              return DropdownMenuItem<String>(
                value: valuee.disease_name,
                child: Row(
                  children: [
                    const Icon(Icons.coronavirus_outlined),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(valuee.disease_name!),
                  ],
                ),
              );
            }).toList(),
            onChanged: (String? value)async {
              log("day la nguoi duoc chon: $value");
              setState(() {
                dropdownValue01 = value;
              });
               Disease? selectedDisease = allDes.firstWhere(
                  (disease) => disease.disease_name == value,
                  );

              if (selectedDisease != null) {
                await fetchDiseaseDataOfYear(selectedDisease.id_disease!, 2024); // Sửa thành đúng ID và năm
              }
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 16, left: 10, right: 10),
          child: SizedBox(
            width: sizeWidth,
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
                      getTitlesWidget: bottomTitleWidgets,
                    ),
                  ),
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      interval: 1,
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
                  LineChartBarData(
                    spots: _generateSpotsForSelectedDisease(),
                    isCurved: true,
                    color: colorScheme.primary,
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
                          stops: const [0.7, 1],
                          colors: gradientColors
                              .map((Color color) => color.withOpacity(0.7))
                              .toList()),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

List<FlSpot> _generateSpotsForSelectedDisease() {
    if (diseaseDataOfYear.isEmpty) {
      return [];
    }

    return diseaseDataOfYear.map((disease) {
      int month = int.parse(disease.month ?? '0'); // Tháng
      double count = double.parse(disease.count ?? '0.0'); // Số lượng b  ệnh
      return FlSpot(month.toDouble(), count);
    }).toList();
  }
}
