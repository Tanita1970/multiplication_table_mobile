import 'package:flutter/material.dart';

class MultiplicationExample extends StatelessWidget {
  final int exampleNumber;
  final int totalExamples;
  final String numOne;
  final String numTwo;

  MultiplicationExample({
    required this.exampleNumber,
    required this.totalExamples,
    required this.numOne,
    required this.numTwo,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Пример $exampleNumber из $totalExamples',
          style: const TextStyle(
            fontSize: 14,
            color: Colors.black,
            fontWeight: FontWeight.w300,
          ),
        ),
        GridPaperWidget(numOne: numOne, numTwo: numTwo),
      ],
    );
  }
}

class GridPaperWidget extends StatelessWidget {
  final String numOne;
  final String numTwo;

  GridPaperWidget({required this.numOne, required this.numTwo});

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
                        margin: EdgeInsets.all(1.0),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.amber),
                          // color: const Color.fromARGB(255, 212, 211, 211)),
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
    if (row == 1) {
      if (col == 2) {
        content = numOne;
      } else if (col == 3) {
        content = '*';
      } else if (col == 4) {
        content = numTwo;
      } else if (col == 5) {
        content = '=';
      } else if (col == 6) {
        content = '?';
      }
    }
    return Text(
      content,
      style: TextStyle(fontSize: fontSize),
    );
  }
}
