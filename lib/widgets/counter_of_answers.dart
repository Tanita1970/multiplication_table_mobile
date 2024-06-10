import 'package:flutter/material.dart';

class CounterOfAnswers extends StatelessWidget {
  final int numberOfCorrectAnswer;
  final int numberOfIncorrectAnswer;

  const CounterOfAnswers({
    super.key,
    required this.numberOfCorrectAnswer,
    required this.numberOfIncorrectAnswer,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AnswerColumn(
            labelTexts: const ['Количество', 'правильных', 'ответов'],
            number: numberOfCorrectAnswer,
            numberColor: Colors.green,
          ),
          const SizedBox(width: 30),
          AnswerColumn(
            labelTexts: const ['Количество', 'не правильных', 'ответов'],
            number: numberOfIncorrectAnswer,
            numberColor: Colors.red,
          ),
        ],
      ),
    );
  }
}

class AnswerColumn extends StatelessWidget {
  final List<String> labelTexts;
  final int number;
  final Color numberColor;

  const AnswerColumn({
    super.key,
    required this.labelTexts,
    required this.number,
    required this.numberColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for (var text in labelTexts)
          Text(
            text,
            style: const TextStyle(
              height: 1.0,
              fontWeight: FontWeight.w300,
            ),
          ),
        Text(
          '$number',
          style: TextStyle(
            color: numberColor,
            fontSize: 24,
          ),
        ),
      ],
    );
  }
}
