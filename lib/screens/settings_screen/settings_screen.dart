// lib/screens/settings_screen/settings_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:multiplication_table_mobile/providers/settings_provider.dart';
import 'package:multiplication_table_mobile/repositories/tasks_manager.dart';
import 'digit_range_settings.dart';
import 'timer_settings.dart';
import 'example_count_settings.dart';
import 'full_table_settings.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final settingsProvider = Provider.of<SettingsProvider>(context);
    final tasksManager = Provider.of<TasksManager>(context, listen: false);

    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.amber,
          title: const Text('Настройка тренажёра'),
          automaticallyImplyLeading: false, // Убираем кнопку "Назад"
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              DigitRangeSettings(),
              const SizedBox(height: 20),
              Stack(
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 12),
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
                        const Text(
                          'Выбор режима тренировки',
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w300),
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
                          TimerSettings(),
                        if (settingsProvider.selectedMode ==
                            'Количество примеров')
                          ExampleCountSettings(),
                        if (settingsProvider.selectedMode == 'Вся таблица')
                          FullTableSettings(),
                      ],
                    ),
                  ),
                  Positioned(
                    left: 10,
                    top: 0,
                    child: Container(
                      color: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: const Text(
                        'Режим тренировки',
                        style: TextStyle(fontSize: 16, color: Colors.blue),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.amber,
                ),
                onPressed: () {
                  settingsProvider.notifySettingsChanged();
                  tasksManager.updateTasks(
                    settingsProvider.firstNumberRange,
                    settingsProvider.secondNumberRange,
                    settingsProvider.exampleCount.toInt(),
                  );
                  Navigator.of(context)
                      .pop(); // Возвращаемся на предыдущий экран
                },
                child: const Text(
                  'Начать тренировку с данными настройками',
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
