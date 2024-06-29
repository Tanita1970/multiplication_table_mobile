import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../repositories/tasks_manager.dart';
import '../../providers/settings_provider.dart';
import '../../widgets/counter_of_answers.dart';
import '../../widgets/keyboard_widget.dart';
import '../../widgets/multiplication_example.dart';

class TrainingScreen extends StatefulWidget {
  const TrainingScreen({super.key});

  @override
  _TrainingScreenState createState() => _TrainingScreenState();
}

class _TrainingScreenState extends State<TrainingScreen> {
  String _userAnswer = '';
  bool shouldUpdateTasks = true; // Флаг для проверки, нужно ли обновлять задачи
  bool _isAnswerChecked = false; // Флаг для проверки ответа
  bool _isCorrect = false; // Флаг правильного ответа
  String _correctAnswer = ''; // Правильный ответ

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (shouldUpdateTasks) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _updateTasks();
      });
      shouldUpdateTasks = false; // Сбрасываем флаг после обновления задач
    }
  }

  // Метод для обновления задач в соответствии с текущими настройками
  void _updateTasks() {
    final settingsProvider =
        Provider.of<SettingsProvider>(context, listen: false);
    final tasksManager = Provider.of<TasksManager>(context, listen: false);

    tasksManager.setSettingsProvider(
        settingsProvider); // Передаем SettingsProvider в TasksManager

    // Обновляем задачи в зависимости от выбранного режима и количества задач
    if (settingsProvider.selectedMode == 'Количество примеров') {
      tasksManager.updateTasks(
        settingsProvider.firstNumberRange,
        settingsProvider.secondNumberRange,
        settingsProvider.exampleCount
            .toInt(), // Передаем количество задач из настроек
      );
    } else {
      tasksManager.reset();
    }
  }

  // Метод для обработки нажатий на кнопки клавиатуры
  void _onKeyboardTap(String value) {
    if (_userAnswer.length < 2) {
      // Ограничение длины ответа двумя цифрами
      setState(() {
        _userAnswer += value;
      });
    }
  }

  // Метод для очистки ответа
  void _clearAnswer() {
    setState(() {
      _userAnswer = '';
    });
  }

  // Метод для отправки ответа с задержкой
  void _submitAnswer(BuildContext context, TasksManager tasksManager) {
    if (_userAnswer.isNotEmpty) {
      int answer = int.parse(_userAnswer);
      _isCorrect = tasksManager.tasks.first.result == answer;
      _correctAnswer = tasksManager.tasks.first.result.toString();
      setState(() {
        _isAnswerChecked = true;
      });
      Future.delayed(const Duration(seconds: 2), () {
        tasksManager.checkAnswer(tasksManager.tasks.first, answer);
        setState(() {
          _isAnswerChecked = false;
          _clearAnswer();
        });
      });
    }
  }

  // Метод для удаления последнего символа ответа
  void _backspace() {
    setState(() {
      if (_userAnswer.isNotEmpty) {
        _userAnswer = _userAnswer.substring(0, _userAnswer.length - 1);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final tasksManager = Provider.of<TasksManager>(context);
    return PopScope(
      onPopInvoked: (value) {
        setState(() {
          shouldUpdateTasks =
              true; // Устанавливаем флаг для обновления задач при возвращении
        });
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Учим таблицу умножения'),
          backgroundColor: Colors.amber,
          actions: [
            IconButton(
              onPressed: () {
                setState(() {
                  shouldUpdateTasks =
                      true; // Устанавливаем флаг для обновления задач при возвращении
                });
                context.goNamed('settings');
              },
              icon: const Icon(Icons.settings),
            ),
          ],
        ),
        body: SizedBox(
          width: double.infinity,
          child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromARGB(255, 249, 248, 245),
                  Color.fromARGB(255, 249, 240, 213),
                  Colors.amber,
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Отображение количества правильных и неправильных ответов
                CounterOfAnswers(
                  numberOfCorrectAnswer: tasksManager.correctAnswersCount,
                  numberOfIncorrectAnswer: tasksManager.wrongAnswersCount,
                ),
                const SizedBox(height: 20),
                // Отображение примеров, если есть задачи
                if (tasksManager.tasks.isNotEmpty) ...[
                  MultiplicationExample(
                    exampleNumber:
                        1, // Здесь нужно передать текущий номер примера
                    totalExamples: tasksManager.tasks.length,
                    numOne: tasksManager.tasks.first.numOne.toString(),
                    numTwo: tasksManager.tasks.first.numTwo.toString(),
                    userAnswer: _userAnswer,
                    isCorrect: _isCorrect, // Передаем статус ответа
                    isAnswerChecked:
                        _isAnswerChecked, // Передаем флаг проверки ответа
                    correctAnswer: _correctAnswer, // Передаем правильный ответ
                  ),
                  // Виджет клавиатуры для ввода ответа
                  KeyboardWidget(
                    onKeyboardTap: _onKeyboardTap,
                    onSubmit: () => _submitAnswer(context, tasksManager),
                    onBackspace: _backspace,
                    onClear: _clearAnswer,
                  ),
                ] else ...[
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Тренировка завершена!',
                            style: TextStyle(fontSize: 24)),
                        Text(
                            'Правильные ответы: ${tasksManager.correctAnswersCount}'),
                        Text(
                            'Неправильные ответы: ${tasksManager.wrongAnswersCount}'),
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              shouldUpdateTasks =
                                  true; // Устанавливаем флаг для обновления задач
                            });
                            _updateTasks(); // Обновляем задачи при нажатии кнопки "Начать заново"
                          },
                          child: const Text('Начать заново'),
                        ),
                      ],
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
