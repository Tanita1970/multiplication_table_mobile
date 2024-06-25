import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../models/task.dart';
import '../providers/settings_provider.dart';

class TasksManager with ChangeNotifier {
  final Box<Task> tasksBox;
  final int initialTaskCount;
  List<Task> tasks = [];
  int correctAnswersCount = 0;
  int wrongAnswersCount = 0;
  SettingsProvider? settingsProvider; // Добавляем ссылку на SettingsProvider

  TasksManager(this.tasksBox, this.initialTaskCount) {
    _initializeTasks();
  }

  void _initializeTasks() {
    tasks = List.generate(initialTaskCount, (index) {
      int numOne = (index % 9) + 1;
      int numTwo = ((index + 1) % 9) + 1;
      return Task(numOne: numOne, numTwo: numTwo, result: numOne * numTwo);
    });
    notifyListeners();
  }

  void checkAnswer(Task task, int answer) {
    if (task.result == answer) {
      correctAnswersCount++;
    } else {
      wrongAnswersCount++;
    }
    tasks.remove(task);
    notifyListeners();
  }

  // Обновленный метод reset для учета текущих настроек
  void reset() {
    if (settingsProvider != null) {
      updateTasks(
        settingsProvider!.firstNumberRange,
        settingsProvider!.secondNumberRange,
        settingsProvider!.exampleCount.toInt(),
      );
    } else {
      correctAnswersCount = 0;
      wrongAnswersCount = 0;
      _initializeTasks();
    }
  }

  // Обновленный метод для обновления задач в соответствии с настройками пользователя и ограничением по количеству задач
  void updateTasks(RangeValues firstNumberRange, RangeValues secondNumberRange,
      int taskCount) {
    correctAnswersCount = 0;
    wrongAnswersCount = 0;
    tasks = [];
    for (int i = firstNumberRange.start.toInt();
        i <= firstNumberRange.end.toInt();
        i++) {
      for (int j = secondNumberRange.start.toInt();
          j <= secondNumberRange.end.toInt();
          j++) {
        tasks.add(Task(numOne: i, numTwo: j, result: i * j));
      }
    }
    tasks.shuffle();
    if (tasks.length > taskCount) {
      tasks = tasks.sublist(0, taskCount);
    }
    notifyListeners();
  }

  // Метод для задания SettingsProvider извне
  void setSettingsProvider(SettingsProvider provider) {
    settingsProvider = provider;
  }
}
