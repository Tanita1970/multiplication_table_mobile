import 'package:flutter/material.dart';

Widget buildFullTableSettings() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: const [
      SizedBox(height: 10),
      Text(
        'Режим полной таблицы: решите все примеры таблицы умножения.',
        style: TextStyle(fontSize: 15, fontWeight: FontWeight.w300),
      ),
    ],
  );
}
