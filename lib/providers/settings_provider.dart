import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class SettingsProvider extends ChangeNotifier {
  // Переменные для хранения настроек
  RangeValues _firstNumberRange = const RangeValues(2, 9);
  RangeValues _secondNumberRange = const RangeValues(2, 9);
  double _minutes = 0;
  double _seconds = 30;
  String _selectedMode = 'Количество примеров';
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

  // Конструктор, который загружает настройки
  SettingsProvider() {
    _loadSettings();
  }

  // Метод для загрузки настроек из Hive
  void _loadSettings() {
    var box = Hive.box('settingsBox');
    _firstNumberRange = _listToRangeValues(
        (box.get('firstNumberRange', defaultValue: [2.0, 9.0]) as List)
            .cast<num>()
            .map((e) => e.toDouble())
            .toList());
    _secondNumberRange = _listToRangeValues(
        (box.get('secondNumberRange', defaultValue: [2.0, 9.0]) as List)
            .cast<num>()
            .map((e) => e.toDouble())
            .toList());
    _minutes = (box.get('minutes', defaultValue: 0)).toDouble();
    _seconds = (box.get('seconds', defaultValue: 30)).toDouble();
    _selectedMode =
        box.get('selectedMode', defaultValue: 'Количество примеров');
    _exampleCount = (box.get('exampleCount', defaultValue: 10)).toDouble();
    notifyListeners();
  }

  // Методы для обновления значений
  void setFirstNumberRange(RangeValues range) {
    _firstNumberRange = range;
    _saveSettings();
    notifyListeners(); // Уведомляем слушателей об изменении
  }

  void setSecondNumberRange(RangeValues range) {
    _secondNumberRange = range;
    _saveSettings();
    notifyListeners(); // Уведомляем слушателей об изменении
  }

  void setMinutes(double minutes) {
    _minutes = minutes;
    _saveSettings();
    notifyListeners(); // Уведомляем слушателей об изменении
  }

  void setSeconds(double seconds) {
    _seconds = seconds;
    _saveSettings();
    notifyListeners(); // Уведомляем слушателей об изменении
  }

  void setSelectedMode(String mode) {
    _selectedMode = mode;
    _saveSettings();
    notifyListeners(); // Уведомляем слушателей об изменении
  }

  void setExampleCount(double count) {
    _exampleCount = count;
    _saveSettings();
    notifyListeners(); // Уведомляем слушателей об изменении
  }

  void notifySettingsChanged() {
    notifyListeners(); // Уведомляем слушателей об изменении
  }

  // Метод для сохранения настроек в Hive
  void _saveSettings() {
    var box = Hive.box('settingsBox');
    box.put('firstNumberRange', _rangeValuesToList(_firstNumberRange));
    box.put('secondNumberRange', _rangeValuesToList(_secondNumberRange));
    box.put('minutes', _minutes);
    box.put('seconds', _seconds);
    box.put('selectedMode', _selectedMode);
    box.put('exampleCount', _exampleCount);
  }

  // Преобразование RangeValues в список
  List<double> _rangeValuesToList(RangeValues range) {
    return [range.start, range.end];
  }

  // Преобразование списка в RangeValues
  RangeValues _listToRangeValues(List<double> list) {
    return RangeValues(list[0], list[1]);
  }
}
