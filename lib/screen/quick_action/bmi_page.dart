import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class BmiPage extends StatefulWidget {
  const BmiPage({super.key});

  @override
  State<BmiPage> createState() => _BmiPageState();
}

class _BmiPageState extends State<BmiPage> {
  Set<String> _selectedItem = {'Hệ mét'};
  String dropdownValue = 'Nam';
  var resultBmi = 0.0;
  var weighController = TextEditingController();
  var heightController = TextEditingController();

  void updateSelected(Set<String> newSelection) {
    setState(() {
      _selectedItem = newSelection;
    });
  }

  @override
  Widget build(BuildContext context) {
    const List<String> list = <String>[
      'Nam',
      'Nữ',
      'Khác',
    ];
    return Scaffold(
      appBar: AppBar(
        title: Text("Tính BMI"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 30,
              ),
              Text(
                "Hệ đo lường",
                style: Theme.of(context)
                    .textTheme
                    .labelLarge!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Container(
                  width: double.infinity,
                  child: SegmentedButton(
                    style: ButtonStyle(
                        iconColor: MaterialStateProperty.all(Colors.white)),
                    segments: <ButtonSegment<String>>[
                      ButtonSegment<String>(
                        value: "Hệ mét",
                        label: Text(
                          "Hệ mét",
                          style: TextStyle(
                            color: _selectedItem.contains("Hệ mét")
                                ? Colors.white
                                : Colors.black,
                          ),
                        ),
                      ),
                      ButtonSegment<String>(
                        value: "Hệ mỹ",
                        label: Text(
                          "Hệ mỹ",
                          style: TextStyle(
                            color: _selectedItem.contains("Hệ mỹ")
                                ? Colors.white
                                : Colors.black,
                          ),
                        ),
                      ),
                    ],
                    selected: _selectedItem,
                    onSelectionChanged: updateSelected,
                  ),
                ),
              ),
              Text(
                "Cân nặng",
                style: Theme.of(context)
                    .textTheme
                    .labelLarge!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              TextField(
                controller: weighController,
                decoration: InputDecoration(
                  hintText: "Điền cân nặng",
                  suffixText: "kg",
                ),
                keyboardType: TextInputType.number,
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Chiều cao",
                style: Theme.of(context)
                    .textTheme
                    .labelLarge!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              TextField(
                controller: heightController,
                decoration: InputDecoration(
                  hintText: "Điền chiều cao",
                  suffixText: "cm",
                ),
                keyboardType: TextInputType.number,
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Giới tính",
                style: Theme.of(context)
                    .textTheme
                    .labelLarge!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              DropdownButton(
                  isExpanded: true,
                  value: dropdownValue,
                  items: list.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Row(
                        children: [
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
                      dropdownValue = value!; // Cập nhật biến trạng thái
                    });
                  }),
              SizedBox(
                height: 20,
              ),
              Text(
                "Kết quả",
                style: Theme.of(context)
                    .textTheme
                    .labelLarge!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              Container(
                width: double.infinity,
                height: 80,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Icon(
                      Icons.monitor_weight_outlined,
                      size: 30,
                    ),
                    Text(
                      resultBmi.toString(),
                      style: Theme.of(context).textTheme.displayMedium,
                    ),
                    Text(
                      "BMI",
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                "Bình thường",
                style: Theme.of(context).textTheme.titleMedium,
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                "Thước đo",
                style: Theme.of(context).textTheme.titleSmall,
              ),
              Container(
                child: SfLinearGauge(
                  markerPointers: [
                    LinearWidgetPointer(
                      value: resultBmi,
                      position: LinearElementPosition.cross,
                      child:
                          Container(height: 30, width: 2, color: Colors.black),
                    ),
                  ],
                  ranges: [
                    LinearGaugeRange(
                        startValue: 0,
                        endValue: 18.5,
                        position: LinearElementPosition.cross,
                        color: Color(0xff6B94FF)),
                    LinearGaugeRange(
                        startValue: 18.5,
                        endValue: 24.9,
                        position: LinearElementPosition.cross,
                        color: Color(0xffACFF6B)),
                    LinearGaugeRange(
                        startValue: 24.9,
                        endValue: 29.9,
                        position: LinearElementPosition.cross,
                        color: Color(0xffFFBB6B)),
                    LinearGaugeRange(
                        startValue: 29.9,
                        endValue: 40,
                        position: LinearElementPosition.cross,
                        color: Color(0xffFF6B6B)),
                  ],
                  minimum: 16.0,
                  maximum: 40.0,
                  orientation: LinearGaugeOrientation.horizontal,
                  majorTickStyle: LinearTickStyle(length: 10),
                  axisLabelStyle:
                      TextStyle(fontSize: 12.0, color: Colors.black),
                ),
                margin: const EdgeInsets.all(10),
              ),
              Center(
                  child: ElevatedButton(
                onPressed: () {
                  var we = weighController.text.toString();
                  var he = heightController.text.toString();

                  var iWe = int.parse(we);
                  var iHe = int.parse(he) * 0.01;

                  var result = (iWe / (iHe * iHe)).toStringAsFixed(2);

                  print("can nang ${iWe}");
                  print("chieu cao ${iHe}");
                  print("chieu cao ${result}");
                  setState(() {
                    resultBmi = double.parse(result);
                  });
                },
                child: Text("Tính"),
              ))
            ],
          ),
        ),
      ),
    );
  }
}
