// lib/screens/settings_screen/timer_settings.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:multiplication_table_mobile/providers/settings_provider.dart';

class TimerSettings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final settingsProvider = Provider.of<SettingsProvider>(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 10),
        const Text(
          'Режим с таймером: решите как можно больше примеров за заданное время.',
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.w300),
        ),
        const SizedBox(height: 10),
        _buildSlider(
          context,
          'Минуты',
          settingsProvider.minutes,
          0,
          9,
          settingsProvider.setMinutes,
        ),
        _buildSlider(
          context,
          'Секунды',
          settingsProvider.seconds,
          0,
          60,
          settingsProvider.setSeconds,
          divisions: 6,
          labels: List.generate(7, (index) => (index * 10).toString()),
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
