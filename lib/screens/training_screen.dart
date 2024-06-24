import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../repositories/tasks_manager.dart';
import '../widgets/counter_of_answers.dart';
import '../widgets/keyboard_widget.dart';
import '../widgets/multiplication_example.dart';

class TrainingScreen extends StatefulWidget {
  const TrainingScreen({super.key});

  @override
  _TrainingScreenState createState() => _TrainingScreenState();
}

class _TrainingScreenState extends State<TrainingScreen> {
  String _userAnswer = '';

  void _onKeyboardTap(String value) {
    setState(() {
      _userAnswer += value;
    });
  }

  void _clearAnswer() {
    setState(() {
      _userAnswer = '';
    });
  }

  void _submitAnswer(BuildContext context, TasksManager tasksManager) {
    if (_userAnswer.isNotEmpty) {
      int answer = int.parse(_userAnswer);
      tasksManager.checkAnswer(tasksManager.tasks.first, answer);
      _clearAnswer();
    }
  }

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

    return Scaffold(
      appBar: AppBar(
        title: const Text('Учим таблицу умножения'),
        backgroundColor: Colors.amber,
        actions: [
          IconButton(
            onPressed: () {
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
              CounterOfAnswers(
                numberOfCorrectAnswer: tasksManager.correctAnswersCount,
                numberOfIncorrectAnswer: tasksManager.wrongAnswersCount,
              ),
              const SizedBox(height: 20),
              if (tasksManager.tasks.isNotEmpty) ...[
                MultiplicationExample(
                  exampleNumber:
                      1, // Здесь нужно передать текущий номер примера
                  totalExamples: tasksManager.tasks.length,
                  numOne: tasksManager.tasks.first.numOne.toString(),
                  numTwo: tasksManager.tasks.first.numTwo.toString(),
                  userAnswer: _userAnswer,
                ),
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
                          tasksManager.reset();
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
    );
  }
}
