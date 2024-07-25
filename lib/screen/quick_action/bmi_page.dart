import 'package:app_well_mate/components/thuoc_do.dart';
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
  String result = "Bình thường";
  var resultBmi = 0.0;
  var weighController = TextEditingController();
  var heightController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  void updateSelected(Set<String> newSelection) {
    setState(() {
      _selectedItem = newSelection;
      if (_selectedItem.contains("Hệ mét")) {
        weighController.clear();
        heightController.clear();
      } else if (_selectedItem.contains("Hệ mỹ")) {
        weighController.clear();
        heightController.clear();
      }
    });
  }

  getNumber(iwe, ihe) {
    var result = 0.0;
    var iHe = ihe * 0.01;
    if (_selectedItem.contains("Hệ mét")) {
      result = (iwe / (iHe * iHe));
    } else if (_selectedItem.contains("Hệ mỹ")) {
      result = (iwe / (ihe * ihe)) * 703;
    }

    return result;
  }

  String getResult() {
    if (resultBmi < 18.5) {
      setState(() {
        result = "Thiếu cân";
      });
    }
    if (resultBmi > 18.5 && resultBmi < 24.9) {
      setState(() {
        result = "Bình thường";
      });
    }

    if (resultBmi > 24.9 && resultBmi < 29.9) {
      setState(() {
        result = "Thừa cân";
      });
    }
    if (resultBmi > 29.9) {
      setState(() {
        result = "Béo phì";
      });
    }
    return result;
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
        title: const Text("Tính BMI"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
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
                TextFormField(
                  controller: weighController,
                  decoration: InputDecoration(
                    hintStyle: const TextStyle(color: Color(0xFF807D7D)),
                    hintText: "Điền cân nặng",
                    suffixText:
                        _selectedItem.contains("Hệ mét") ? "kg" : "pound",
                  ),
                  validator: (weight) {
                    // return weight!.isEmpty ? "Vui lòng điền cân nặng" : null;
                    if (weight == null || weight.isEmpty) {
                      return 'Vui lòng nhập cân nặng';
                    } else if (weight.contains(',') ||
                        weight.contains('.') ||
                        weight.length > 3) {
                      return 'Cân nặng không phù hợp';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  "Chiều cao",
                  style: Theme.of(context)
                      .textTheme
                      .labelLarge!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
                TextFormField(
                  controller: heightController,
                  decoration: InputDecoration(
                    hintText: "Điền chiều cao",
                    suffixText:
                        _selectedItem.contains("Hệ mét") ? "cm" : "inch",
                    hintStyle: const TextStyle(color: Color(0xFF807D7D)),
                  ),
                  validator: (height) {
                    // return weight!.isEmpty ? "Vui lòng điền cân nặng" : null;
                    if (height == null || height.isEmpty) {
                      return 'Vui lòng nhập chiều cao';
                    } else if (height.contains(',') ||
                        height.contains('.') ||
                        height.length > 4) {
                      return 'Chiều cao không phù hợp';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.number,
                ),

                const SizedBox(
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
                const SizedBox(
                  height: 20,
                ),
                Text(
                  "Kết quả",
                  style: Theme.of(context)
                      .textTheme
                      .labelLarge!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  width: double.infinity,
                  height: 80,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const Icon(
                        Icons.monitor_weight_outlined,
                        size: 30,
                      ),
                      TweenAnimationBuilder(
                        tween: Tween<double>(begin: resultBmi, end: resultBmi),
                        duration: const Duration(milliseconds: 1000),
                        builder: (context, value, child) {
                          return Text(
                            value.toStringAsFixed(2),
                            style: Theme.of(context).textTheme.displayMedium,
                          );
                        },
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
                  getResult(),
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(
                  height: 30,
                ),
                Text(
                  "Thước đo",
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                      child: thuocdo_widget(
                        color: const Color(0xff6B94FF),
                        title: "Thiếu cân",
                      ),
                    ),
                    Expanded(
                      child: thuocdo_widget(
                        color: const Color(0xffACFF6B),
                        title: "Bình thường",
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: thuocdo_widget(
                        color: const Color(0xffFFBB6B),
                        title: "Thừa cân",
                      ),
                    ),
                    Expanded(
                      child: thuocdo_widget(
                        color: const Color(0xffFF6B6B),
                        title: "Béo phì",
                      ),
                    ),
                  ],
                ),
                Container(
                  child: SfLinearGauge(
                    markerPointers: [
                      LinearWidgetPointer(
                        value: resultBmi,
                        position: LinearElementPosition.cross,
                        child: Container(
                            height: 30, width: 2, color: Colors.black),
                      ),
                    ],
                    ranges: const [
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
                    majorTickStyle: const LinearTickStyle(length: 10),
                    axisLabelStyle:
                        const TextStyle(fontSize: 12.0, color: Colors.black),
                  ),
                  margin: const EdgeInsets.all(10),
                ),
                Center(
                    child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        var we = weighController.text.toString();
                        var he = heightController.text.toString();

                        var iWe = double.parse(we);
                        var iHe = double.parse(he);

                        var re = getNumber(iWe, iHe);
                        print("kết quả ${re}");
                        setState(() {
                          resultBmi = re;
                        });
                      }
                    },
                    child: const Text("Tính"),
                  ),
                )),
                // SizedBox(
                //   height: 20,
                // )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
