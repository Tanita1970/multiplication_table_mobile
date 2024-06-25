// lib/screens/settings_screen/example_count_settings.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:multiplication_table_mobile/providers/settings_provider.dart';

class ExampleCountSettings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final settingsProvider = Provider.of<SettingsProvider>(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 10),
        const Text(
          'Режим по количеству примеров: решите заданное количество примеров.',
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.w300),
        ),
        const SizedBox(height: 10),
        _buildSlider(
          context,
          'Количество примеров',
          settingsProvider.exampleCount,
          10,
          50,
          settingsProvider.setExampleCount,
          divisions: 8,
          labels: List.generate(9, (index) => '${index * 5 + 10}'),
        ),
      ],
    );
  }

  Widget _buildSlider(
    BuildContext context,
    String label,
    double value,
    double min,
    double max,
    ValueChanged<double> onChanged, {
    int divisions = 0,
    List<String>? labels,
  }) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$label: ${value.toInt()}',
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w300),
          ),
          SliderTheme(
            data: SliderTheme.of(context).copyWith(
              showValueIndicator: ShowValueIndicator.always,
              thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 10.0),
              thumbColor: Colors.blue,
              overlayShape: const RoundSliderOverlayShape(overlayRadius: 16.0),
              overlayColor: Colors.blue.withOpacity(0.3),
              valueIndicatorShape: const PaddleSliderValueIndicatorShape(),
              valueIndicatorColor: Colors.blue.withOpacity(0.3),
              activeTrackColor: Colors.blue,
              inactiveTrackColor: Colors.blue.withOpacity(0.3),
              activeTickMarkColor: Colors.blue,
              inactiveTickMarkColor: Colors.blue.withOpacity(0.7),
              valueIndicatorTextStyle:
                  const TextStyle(fontSize: 20, color: Colors.blue),
              trackHeight: 10.0,
            ),
            child: Slider(
              value: value,
              min: min,
              max: max,
              divisions: divisions == 0 ? null : divisions,
              label: value.toInt().toString(),
              onChanged: onChanged,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: labels != null
                  ? labels
                      .map((label) => Text(
                            label,
                            style: TextStyle(color: Colors.blue),
                          ))
                      .toList()
                  : List.generate(
                      (max - min).toInt() + 1,
                      (index) => Text(
                        '$index',
                        style: TextStyle(color: Colors.blue),
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
