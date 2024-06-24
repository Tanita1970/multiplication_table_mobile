import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../models/task.dart';

class TasksManager with ChangeNotifier {
  final Box<Task> tasksBox;
  final int taskCount;
  List<Task> tasks = [];
  int correctAnswersCount = 0;
  int wrongAnswersCount = 0;

  TasksManager(this.tasksBox, this.taskCount) {
    _initializeTasks();
  }

  void _initializeTasks() {
    tasks = List.generate(taskCount, (index) {
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

  void reset() {
    correctAnswersCount = 0;
    wrongAnswersCount = 0;
    _initializeTasks();
  }
}
