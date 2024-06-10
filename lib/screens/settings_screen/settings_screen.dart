import 'package:flutter/material.dart';
import 'sliders.dart';
import 'other_settings.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  RangeValues _firstNumberRange = const RangeValues(2, 9);
  RangeValues _secondNumberRange = const RangeValues(2, 9);

  String _selectedMode = 'Таймер';
  final List<String> _modes = ['Таймер', 'Количество примеров', 'Вся таблица'];

  double _minutes = 0;
  double _seconds = 30;
  double _exampleCount = 10;

  @override
  void initState() {
    super.initState();
    setDefaultValues();
  }

  void setDefaultValues() {
    setState(() {
      _firstNumberRange = const RangeValues(2, 9);
      _secondNumberRange = const RangeValues(2, 9);
      _minutes = 0;
      _seconds = 30;
      _selectedMode = 'Таймер';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
      ), // Задайте нужный цвет фона
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: const Text('Настройка тренажёра'),
          backgroundColor: Colors.amber,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              setDigitsRangeSettings(context),
              const SizedBox(height: 20),
              setTrainingModes(
                  context), // Другой контейнер для дополнительных настроек
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: setDefaultValues,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.amber,
                ),
                child: const Text(
                  'Установить значения по умолчанию',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget setDigitsRangeSettings(BuildContext context) {
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
            border: Border.all(width: 0.8, color: Colors.green),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildNumberRangeSlider(
                  context, 'Первая цифра', _firstNumberRange, Colors.green,
                  (RangeValues newRange) {
                setState(() {
                  _firstNumberRange = newRange;
                });
              }),
              const SizedBox(height: 10),
              buildNumberRangeSlider(
                  context, 'Вторая цифра', _secondNumberRange, Colors.green,
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
              style: TextStyle(fontSize: 16, color: Colors.green),
            ),
          ),
        ),
      ],
    );
  }

  Widget setTrainingModes(BuildContext context) {
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
            border: Border.all(width: 0.8, color: Colors.blue),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              DropdownButton<String>(
                dropdownColor: Colors.amber,
                value: _selectedMode,
                items: _modes.map((String mode) {
                  return DropdownMenuItem<String>(
                    value: mode,
                    child: Text(mode),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedMode = newValue!;
                  });
                },
              ),
              if (_selectedMode == 'Таймер') buildTimerSettings(context),
              if (_selectedMode == 'Количество примеров')
                buildExamplesCountSettings(context),
              if (_selectedMode == 'Вся таблица') buildFullTableSettings(),
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
              style: TextStyle(fontSize: 16, color: Colors.blue),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildTimerSettings(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 10),
        const Text(
          'Режим с таймером: решите как можно больше примеров за заданное время.',
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.w300),
        ),
        const SizedBox(height: 10),
        buildSlider(
          context,
          'Минуты',
          _minutes,
          0,
          9,
          (double newValue) {
            setState(() {
              _minutes = newValue;
            });
          },
          divisions: 9,
        ),
        buildSlider(
          context,
          'Секунды',
          _seconds,
          0,
          60,
          (double newValue) {
            setState(() {
              _seconds = newValue;
            });
          },
          divisions: 6,
          labels: List.generate(7, (index) => (index * 10).toString()),
        ),
      ],
    );
  }

  Widget buildExamplesCountSettings(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 10),
        const Text(
          'Режим по количеству примеров: решите заданное количество примеров.',
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.w300),
        ),
        const SizedBox(height: 10),
        buildSlider(
          context,
          'Количество примеров',
          _exampleCount,
          10,
          50,
          (double newValue) {
            setState(() {
              _exampleCount = newValue;
            });
          },
          divisions: 8,
          labels: List.generate(9, (index) => (index * 5 + 10).toString()),
        ),
      ],
    );
  }
}
