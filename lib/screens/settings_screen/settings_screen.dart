import 'package:flutter/material.dart';
import 'package:multiplication_table_mobile/providers/settings_provider.dart';
import 'package:multiplication_table_mobile/screens/settings_screen/sliders.dart';
import 'package:provider/provider.dart'; // Импортируем пакет provider

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  // Эти переменные больше не нужны, так как мы будем использовать SettingsProvider для управления состоянием
  // RangeValues _firstNumberRange = const RangeValues(2, 9);
  // RangeValues _secondNumberRange = const RangeValues(2, 9);
  // String _selectedMode = 'Таймер';
  // final List<String> _modes = ['Таймер', 'Количество примеров', 'Вся таблица'];
  // double _minutes = 0;
  // double _seconds = 30;
  // double _exampleCount = 10;

  @override
  Widget build(BuildContext context) {
    // Получаем доступ к SettingsProvider
    final settingsProvider = Provider.of<SettingsProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Настройка тренажёра'),
        backgroundColor: const Color.fromARGB(255, 236, 235, 235),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            // Передаем settingsProvider в методы для отображения и обновления настроек
            setDigitsRangeSettings(settingsProvider),
            const SizedBox(height: 20),
            setOtherSettings(
                settingsProvider), // Другой контейнер для дополнительных настроек
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Устанавливаем значения по умолчанию при нажатии кнопки
                settingsProvider.setFirstNumberRange(const RangeValues(2, 9));
                settingsProvider.setSecondNumberRange(const RangeValues(2, 9));
                settingsProvider.setMinutes(0);
                settingsProvider.setSeconds(30);
              },
              child: const Text('Установить значения по умолчанию'),
            ),
          ],
        ),
      ),
    );
  }

  Widget setDigitsRangeSettings(SettingsProvider settingsProvider) {
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Используем значения из SettingsProvider для отображения текущих настроек и обновления их при изменении
              buildNumberRangeSlider(
                context,
                'Первая цифра',
                settingsProvider.firstNumberRange,
                Colors.green,
                (RangeValues newRange) {
                  settingsProvider.setFirstNumberRange(newRange);
                },
              ),
              const SizedBox(height: 10),
              buildNumberRangeSlider(
                context,
                'Вторая цифра',
                settingsProvider.secondNumberRange,
                Colors.green,
                (RangeValues newRange) {
                  settingsProvider.setSecondNumberRange(newRange);
                },
              ),
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

  Widget setOtherSettings(SettingsProvider settingsProvider) {
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Выбор режима тренировки',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w300),
              ),
              const SizedBox(height: 10),
              DropdownButton<String>(
                value: settingsProvider.selectedMode,
                items: settingsProvider.modes.map((String mode) {
                  return DropdownMenuItem<String>(
                    value: mode,
                    child: Text(mode),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  settingsProvider.setSelectedMode(newValue!);
                },
              ),
              if (settingsProvider.selectedMode == 'Таймер')
                buildTimerSettings(settingsProvider),
              if (settingsProvider.selectedMode == 'Количество примеров')
                buildExamplesCountSettings(settingsProvider),
              if (settingsProvider.selectedMode == 'Вся таблица')
                buildFullTableSettings(),
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

  Widget buildTimerSettings(SettingsProvider settingsProvider) {
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
          settingsProvider.minutes,
          0,
          9,
          (double newValue) {
            settingsProvider.setMinutes(newValue);
          },
          divisions: 9,
        ),
        buildSlider(
          context,
          'Секунды',
          settingsProvider.seconds,
          0,
          60,
          (double newValue) {
            settingsProvider.setSeconds(newValue);
          },
          divisions: 6,
          labels: List.generate(7, (index) => (index * 10).toString()),
        ),
      ],
    );
  }

  Widget buildExamplesCountSettings(SettingsProvider settingsProvider) {
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
          settingsProvider.exampleCount,
          10,
          50,
          (double newValue) {
            settingsProvider.setExampleCount(newValue);
          },
          divisions: 8,
          labels: List.generate(9, (index) => (index * 5 + 10).toString()),
        ),
      ],
    );
  }

  Widget buildFullTableSettings() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        SizedBox(height: 10),
        Text(
          'Режим полной таблицы: решите все примеры таблицы умножения.',
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.w300),
        ),
      ],
    );
  }
}
