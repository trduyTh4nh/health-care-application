import 'package:flutter/material.dart';
import 'package:app_well_mate/style/style.dart';

class FFMIPage extends StatefulWidget {
  @override
  _FFMIPageState createState() => _FFMIPageState();
}

class _FFMIPageState extends State<FFMIPage> {
  final _weightController = TextEditingController();
  final _heightController = TextEditingController();
  final _fatController = TextEditingController();

  String _gender = 'Nam';
  String _metricMeasurement = 'Hệ Mét';

  double _ffmi = 0.0;
  double _leanBodyMass = 0.0;
  double _ffmiNormalized = 0.0;

  void _calculateFFMI() {
    final weight = double.tryParse(_weightController.text) ?? 0.0;
    final height = double.tryParse(_heightController.text) ?? 0.0;
    final bodyFat = double.tryParse(_fatController.text) ?? 0.0;

    // thực hiện tính toán nếu đúng
    if (weight > 0 && height > 0) {
      final leanBodyMass = weight * (1 - bodyFat / 100);
      final heightInMeters = height / 100;
      final ffmi = leanBodyMass / (heightInMeters * heightInMeters);
      final ffmiNormalized = ffmi + 6.1 * (1.8 - heightInMeters);

      setState(() {
        _ffmi = ffmi;
        _leanBodyMass = leanBodyMass;
        _ffmiNormalized = ffmiNormalized;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tính FFMI'),
        // leading: IconButton(
        //   icon: Icon(Icons.arrow_back),
        //   onPressed: () {},
        // ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: <Widget>[
            Padding(
                padding: EdgeInsets.only(bottom: 10),
                child: Text("Hệ đo lường",
                    style: Theme.of(context).textTheme.titleMedium)),
            // const Text('Hệ đo lường',
            // style: TextStyle(fontWeight: FontWeight.w900),),
            // ToggleButtons(
            //   isSelected: [_metricMeasurement == 'Hệ Mét', _metricMeasurement == 'Hệ Mỹ'],
            //   onPressed: (index) {
            //     setState(() {
            //       _metricMeasurement = index == 0 ? 'Hệ Mét' : 'Hệ Mỹ';
            //     });
            //   },
            //   children: [
            //     Padding(
            //       padding: const EdgeInsets.symmetric(horizontal: 16.0),
            //       child: Text('Mét mét'),

            //     ),
            //     Padding(
            //       padding: const EdgeInsets.symmetric(horizontal: 16.0),
            //       child: Text('Hệ Mỹ'),
            //     ),
            //   ],
            // ),

            SegmentedButton(
              style: ButtonStyle(
                        iconColor: MaterialStateProperty.all(Colors.white)),
              segments: [
                ButtonSegment(
                  value: 'Hệ Mét',
                  label: Text('Mét Mét',
                  style: TextStyle(
                            color: _metricMeasurement.contains("Hệ Mét")
                                ? Colors.white
                                : Colors.black,
                          ),),
                  
                ),
                ButtonSegment(
                  value: 'Hệ Mỹ',
                  label: Text('Hệ Mỹ',
                  style: TextStyle(
                            color: _metricMeasurement.contains("Hệ Mỹ")
                                ? Colors.white
                                : Colors.black,
                          ),),
                ),
              ],
              selected: {_metricMeasurement},
              onSelectionChanged: (newSelection) {
                setState(() {
                  _metricMeasurement = newSelection.first;
                });
              },
            ),
            SizedBox(height: 16),
            TextField(
              controller: _weightController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Cân nặng',
                suffixText: _metricMeasurement == 'Hệ Mét' ? 'kg' : 'lbs',
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _heightController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Chiều cao',
                suffixText: _metricMeasurement == 'Hệ Mét' ? 'cm' : 'inches',
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _fatController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Lượng mỡ trong cơ thể',
                suffixText: '%',
              ),
            ),
            SizedBox(height: 16),
            DropdownButton<String>(
              isExpanded: true,
              value: _gender,
              onChanged: (String? newValue) {
                setState(() {
                  _gender = newValue!;
                });
              },
              items: <String>['Nam', 'Nữ']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _calculateFFMI,
              child: Text('Tính FFMI'),
            ),
            SizedBox(height: 16),
            if (_ffmi > 0)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Kết quả',
                      style: Theme.of(context).textTheme.titleLarge),
                  Text('FFMI: ', style: Theme.of(context).textTheme.titleSmall),
                  Text('${_ffmi.toStringAsFixed(1)} kg/m²',
                      style: Theme.of(context).textTheme.displayMedium),
                  Text('Trên trung bình',
                      style: Theme.of(context).textTheme.titleSmall),
                  Text('FFMI Bình thường hoá: ',
                      style: Theme.of(context).textTheme.titleSmall),
                  Text('${_ffmiNormalized.toStringAsFixed(1)} kg/m²',
                      style: Theme.of(context).textTheme.titleMedium),
                  Text('Khối lượng khi loại trừ mỡ: ',
                      style: Theme.of(context).textTheme.titleSmall),
                  Text('${_leanBodyMass.toStringAsFixed(1)} kg',
                      style: Theme.of(context).textTheme.titleMedium),
                  Text('Tổng khối lượng mỡ: ',
                      style: Theme.of(context).textTheme.titleSmall),
                  Text('${_fatController.text} %',
                      style: Theme.of(context).textTheme.titleMedium)
                ],
              ),
          ],
        ),
      ),
    );
  }
}
