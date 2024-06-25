// lib/screens/settings_screen/full_table_settings.dart
import 'package:flutter/material.dart';

class FullTableSettings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
}
