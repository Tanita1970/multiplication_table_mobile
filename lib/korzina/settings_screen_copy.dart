import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  final TextEditingController firstNumberMinController =
      TextEditingController(text: '2');
  final TextEditingController firstNumberMaxController =
      TextEditingController(text: '9');
  final TextEditingController secondNumberMinController =
      TextEditingController(text: '2');
  final TextEditingController secondNumberMaxController =
      TextEditingController(text: '9');
  final TextEditingController timeController =
      TextEditingController(text: '30');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Настройка тренажёра'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.orange[100],
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Настройка диапазона изменения чисел',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 16),
                  NumberRangeInput(
                    label: '1-е число:',
                    minController: firstNumberMinController,
                    maxController: firstNumberMaxController,
                  ),
                  SizedBox(height: 16),
                  NumberRangeInput(
                    label: '2-е число:',
                    minController: secondNumberMinController,
                    maxController: secondNumberMaxController,
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),
            Container(
              decoration: BoxDecoration(
                color: Colors.orange[100],
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Настройка ограничения времени опроса',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 16),
                  Row(
                    children: [
                      Text('Введите время опроса, сек:'),
                      SizedBox(width: 16),
                      Expanded(
                        child: TextField(
                          controller: timeController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Внимание! Кнопка ниже устанавливает параметры чисел и времени по умолчанию. По умолчанию время опроса равно 30 сек, а оба числа изменяются в пределах от 2 до 9 включительно.',
              style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                firstNumberMinController.text = '2';
                firstNumberMaxController.text = '9';
                secondNumberMinController.text = '2';
                secondNumberMaxController.text = '9';
                timeController.text = '30';
              },
              child: Text('Установить числа и время по умолчанию'),
            ),
          ],
        ),
      ),
    );
  }
}

class NumberRangeInput extends StatelessWidget {
  final String label;
  final TextEditingController minController;
  final TextEditingController maxController;

  NumberRangeInput(
      {required this.label,
      required this.minController,
      required this.maxController});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label),
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: minController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'от',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            SizedBox(width: 8),
            Text('до'),
            SizedBox(width: 8),
            Expanded(
              child: TextField(
                controller: maxController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'до',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
