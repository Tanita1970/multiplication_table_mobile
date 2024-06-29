import 'package:flutter/material.dart';

class MultiplicationExample extends StatelessWidget {
  final int exampleNumber;
  final int totalExamples;
  final String numOne;
  final String numTwo;
  final String userAnswer;
  final bool isCorrect; // Добавляем флаг правильного ответа
  final bool isAnswerChecked; // Добавляем флаг проверки ответа
  final String correctAnswer; // Добавляем правильный ответ

  const MultiplicationExample({
    super.key,
    required this.exampleNumber,
    required this.totalExamples,
    required this.numOne,
    required this.numTwo,
    required this.userAnswer,
    required this.isCorrect,
    required this.isAnswerChecked,
    required this.correctAnswer,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Всего осталось решить примеров: $totalExamples',
          style: const TextStyle(
            fontSize: 14,
            color: Colors.black,
            fontWeight: FontWeight.w300,
          ),
        ),
        GridPaperWidget(
          numOne: numOne,
          numTwo: numTwo,
          userAnswer: userAnswer,
          isCorrect: isCorrect,
          isAnswerChecked: isAnswerChecked,
          correctAnswer: correctAnswer,
        ),
      ],
    );
  }
}

class GridPaperWidget extends StatelessWidget {
  final String numOne;
  final String numTwo;
  final String userAnswer;
  final bool isCorrect;
  final bool isAnswerChecked;
  final String correctAnswer;

  const GridPaperWidget({
    super.key,
    required this.numOne,
    required this.numTwo,
    required this.userAnswer,
    required this.isCorrect,
    required this.isAnswerChecked,
    required this.correctAnswer,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final cellSize =
        screenWidth / 10; // Размер клетки будет 1/10 от ширины экрана
    final fontSize =
        cellSize * 0.7; // Размер шрифта будет 60% от размера клетки

    return SizedBox(
      width: double.infinity,
      height: cellSize * 3, // Высота виджета, чтобы поместить 3 строки клеток
      child: Column(
        children: [
          for (int row = 0; row < 3; row++)
            Expanded(
              child: Row(
                children: [
                  for (int col = 0; col < 10; col++)
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.all(1.0),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.amber),
                        ),
                        child: Center(
                          child: _buildCellContent(row, col, fontSize),
                        ),
                      ),
                    ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildCellContent(int row, int col, double fontSize) {
    String content = '';
    Color textColor = Colors.black; // Цвет текста по умолчанию

    // Отображение правильного и неправильного ответа
    if (row == 1) {
      if (col == 2) {
        content = numOne;
      } else if (col == 3) {
        content = '*';
      } else if (col == 4) {
        content = numTwo;
      } else if (col == 5) {
        content = '=';
      } else if (col > 5 && col - 6 < userAnswer.length) {
        content = userAnswer[col - 6];
        if (isAnswerChecked) {
          textColor = isCorrect ? Colors.green : Colors.red;
        }
      } else if (col > 5 && col - 6 == userAnswer.length && isAnswerChecked) {
        content = isCorrect ? '✓' : '✗';
        textColor = isCorrect ? Colors.green : Colors.red;
      }
    }
    // Отображение правильного ответа над неправильным
    else if (row == 0 &&
        col > 5 &&
        col - 6 < correctAnswer.length &&
        !isCorrect &&
        isAnswerChecked) {
      content = correctAnswer[col - 6];
      textColor = Colors.green;
    }

    return Text(
      content,
      style: TextStyle(fontSize: fontSize, color: textColor),
    );
  }
}
