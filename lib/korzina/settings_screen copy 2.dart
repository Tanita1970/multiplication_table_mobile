import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  RangeValues _firstNumberRange = const RangeValues(2, 9);
  RangeValues _secondNumberRange = const RangeValues(2, 9);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Настройка тренажёра'),
        backgroundColor: const Color.fromARGB(255, 236, 235, 235),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            setDigitsRangeSettings(),
            const SizedBox(height: 20),
            setOtherSettings(), // Другой контейнер для дополнительных настроек
          ],
        ),
      ),
    );
  }

  Widget setDigitsRangeSettings() {
    return Stack(
      children: [
        Container(
          // height: 100.0,
          margin: const EdgeInsets.only(top: 12), // Для размещения заголовка
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.all(
              Radius.circular(10),
            ),
            border: Border.all(width: 0.8, color: Colors.grey),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildNumberRangeSlider(
                  'Первая цифра', _firstNumberRange, Colors.green,
                  (RangeValues newRange) {
                setState(() {
                  _firstNumberRange = newRange;
                });
              }),
              const SizedBox(height: 10),
              _buildNumberRangeSlider(
                  'Вторая цифра', _secondNumberRange, Colors.green,
                  (RangeValues newRange) {
                setState(() {
                  _secondNumberRange = newRange;
                });
              }),
            ],
          ),
        ),
        Positioned(
          left: 10,
          top: 0,
          child: Container(
            color: Colors.white, // Цвет фона, чтобы скрыть границу контейнера
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: const Text(
              'Диапазон изменения цифр',
              style: TextStyle(fontSize: 16),
            ),
          ),
        ),
      ],
    );
  }

  Widget setOtherSettings() {
    return Stack(
      children: [
        Container(
          margin: const EdgeInsets.only(top: 12), // Для размещения заголовка
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.all(
              Radius.circular(10),
            ),
            border: Border.all(width: 0.8, color: Colors.grey),
          ),
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Другие настройки',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w300),
              ),
              // Здесь разместите другие настройки
            ],
          ),
        ),
        Positioned(
          left: 10,
          top: 0,
          child: Container(
            color: Colors.white, // Цвет фона, чтобы скрыть границу контейнера
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: const Text(
              'Режим тренировки',
              style: TextStyle(fontSize: 16),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildNumberRangeSlider(String label, RangeValues values, Color color,
      ValueChanged<RangeValues> onChanged) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text.rich(
            TextSpan(
              text: '$label: от ',
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w300),
              children: <TextSpan>[
                TextSpan(
                  text: '${values.start.toInt()}',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const TextSpan(
                  text: ' до ',
                ),
                TextSpan(
                  text: '${values.end.toInt()}',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          SliderTheme(
            data: SliderTheme.of(context).copyWith(
              showValueIndicator: ShowValueIndicator.always,
              thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 10.0),
              overlayShape: const RoundSliderOverlayShape(overlayRadius: 16.0),
              valueIndicatorShape: const PaddleSliderValueIndicatorShape(),
              valueIndicatorColor: color.withOpacity(0.3),
              valueIndicatorTextStyle:
                  const TextStyle(fontSize: 20, color: Colors.green),
              trackHeight: 10.0,
            ),
            child: RangeSlider(
              values: values,
              min: 0,
              max: 9,
              divisions: 9,
              labels: RangeLabels(
                values.start.round().toString(),
                values.end.round().toString(),
              ),
              onChanged: onChanged,
              activeColor: color,
              inactiveColor: color.withOpacity(0.3),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(
                10,
                (index) => Text(
                  '$index',
                  style: TextStyle(color: color),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
