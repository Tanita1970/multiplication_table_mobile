import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:multiplication_table_mobile/widgets/counter_of_answers.dart';
import 'package:multiplication_table_mobile/widgets/keyboard_widget.dart';
import 'package:multiplication_table_mobile/widgets/multiplication_example.dart';

class TrainingScreen extends StatelessWidget {
  const TrainingScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
              const CounterOfAnswers(
                numberOfCorrectAnswer: 2,
                numberOfIncorrectAnswer: 0,
              ),
              const SizedBox(height: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MultiplicationExample(
                    exampleNumber: 3,
                    totalExamples: 10,
                    numOne: '2',
                    numTwo: '5',
                  ),
                ],
              ),
              const SizedBox(height: 20),
              KeyboardWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
