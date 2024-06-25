// lib/screens/settings_screen/digit_range_settings.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:multiplication_table_mobile/providers/settings_provider.dart';

class DigitRangeSettings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final settingsProvider = Provider.of<SettingsProvider>(context);

    return Stack(
      children: [
        Container(
          margin: const EdgeInsets.only(top: 12),
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.all(
              Radius.circular(10),
            ),
            border: Border.all(width: 0.8, color: Colors.green),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildNumberRangeSlider(
                context,
                'Первая цифра',
                settingsProvider.firstNumberRange,
                Colors.green,
                settingsProvider.setFirstNumberRange,
              ),
              const SizedBox(height: 10),
              _buildNumberRangeSlider(
                context,
                'Вторая цифра',
                settingsProvider.secondNumberRange,
                Colors.green,
                settingsProvider.setSecondNumberRange,
              ),
            ],
          ),
        ),
        Positioned(
          left: 10,
          top: 0,
          child: Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: const Text(
              'Диапазон изменения цифр',
              style: TextStyle(fontSize: 16, color: Colors.green),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildNumberRangeSlider(
    BuildContext context,
    String label,
    RangeValues values,
    Color color,
    ValueChanged<RangeValues> onChanged,
  ) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text.rich(
            TextSpan(
              text: '$label: от ',
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w300),
              children: <TextSpan>[
                TextSpan(
                  text: '${values.start.toInt()}',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const TextSpan(
                  text: ' до ',
                ),
                TextSpan(
                  text: '${values.end.toInt()}',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          SliderTheme(
            data: SliderTheme.of(context).copyWith(
              showValueIndicator: ShowValueIndicator.always,
              thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 10.0),
              overlayShape: const RoundSliderOverlayShape(overlayRadius: 16.0),
              valueIndicatorShape: const PaddleSliderValueIndicatorShape(),
              valueIndicatorColor: color.withOpacity(0.3),
              activeTrackColor: color.withOpacity(0.7),
              inactiveTrackColor: color.withOpacity(0.3),
              valueIndicatorTextStyle:
                  const TextStyle(fontSize: 20, color: Colors.green),
              trackHeight: 10.0,
            ),
            child: RangeSlider(
              values: values,
              min: 0,
              max: 9,
              divisions: 9,
              labels: RangeLabels(
                values.start.round().toString(),
                values.end.round().toString(),
              ),
              onChanged: onChanged,
              activeColor: color,
              inactiveColor: color.withOpacity(0.3),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(
                10,
                (index) => Text(
                  '$index',
                  style: TextStyle(color: color),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
