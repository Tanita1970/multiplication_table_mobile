import 'package:flutter/material.dart';

class SettingsProvider extends ChangeNotifier {
  // Переменные для хранения настроек
  RangeValues _firstNumberRange = const RangeValues(2, 9);
  RangeValues _secondNumberRange = const RangeValues(2, 9);
  double _minutes = 0;
  double _seconds = 30;
  String _selectedMode = 'Таймер';
  final List<String> _modes = ['Таймер', 'Количество примеров', 'Вся таблица'];
  double _exampleCount = 10;

  // Геттеры для доступа к значениям
  RangeValues get firstNumberRange => _firstNumberRange;
  RangeValues get secondNumberRange => _secondNumberRange;
  double get minutes => _minutes;
  double get seconds => _seconds;
  String get selectedMode => _selectedMode;
  List<String> get modes => _modes;
  double get exampleCount => _exampleCount;

  // Методы для обновления значений
  void setFirstNumberRange(RangeValues range) {
    _firstNumberRange = range;
    notifyListeners(); // Уведомляем слушателей об изменении
  }

  void setSecondNumberRange(RangeValues range) {
    _secondNumberRange = range;
    notifyListeners(); // Уведомляем слушателей об изменении
  }

  void setMinutes(double minutes) {
    _minutes = minutes;
    notifyListeners(); // Уведомляем слушателей об изменении
  }

  void setSeconds(double seconds) {
    _seconds = seconds;
    notifyListeners(); // Уведомляем слушателей об изменении
  }

  void setSelectedMode(String mode) {
    _selectedMode = mode;
    notifyListeners(); // Уведомляем слушателей об изменении
  }

  void setExampleCount(double count) {
    _exampleCount = count;
    notifyListeners(); // Уведомляем слушателей об изменении
  }
}
