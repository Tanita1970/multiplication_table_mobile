import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RangeSlider Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: RangeSliderExample(),
    );
  }
}

class RangeSliderExample extends StatefulWidget {
  @override
  _RangeSliderExampleState createState() => _RangeSliderExampleState();
}

class _RangeSliderExampleState extends State<RangeSliderExample> {
  RangeValues _currentRangeValues = RangeValues(2, 7);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('RangeSlider Example'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              'Выберите диапазон:',
              style: TextStyle(fontSize: 20),
            ),
            SliderTheme(
              data: SliderTheme.of(context).copyWith(
                showValueIndicator: ShowValueIndicator.always,
                thumbShape: RoundSliderThumbShape(enabledThumbRadius: 22.0),
                overlayShape: RoundSliderOverlayShape(overlayRadius: 26.0),
                valueIndicatorShape: PaddleSliderValueIndicatorShape(),
                valueIndicatorColor: Colors.red,
                trackHeight: 16.0,
              ),
              child: RangeSlider(
                values: _currentRangeValues,
                min: 0,
                max: 9,
                divisions: 9,
                labels: RangeLabels(
                  _currentRangeValues.start.round().toString(),
                  _currentRangeValues.end.round().toString(),
                ),
                onChanged: (RangeValues values) {
                  setState(() {
                    _currentRangeValues = values;
                  });
                },
                activeColor: Colors.blue,
                inactiveColor: Colors.blue.withOpacity(0.3),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(10, (index) => Text('$index')),
            ),
            SizedBox(height: 20),
            Text(
              'Начало диапазона: ${_currentRangeValues.start.round()}',
              style: TextStyle(fontSize: 16),
            ),
            Text(
              'Конец диапазона: ${_currentRangeValues.end.round()}',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
