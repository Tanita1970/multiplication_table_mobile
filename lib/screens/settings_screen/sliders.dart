import 'package:flutter/material.dart';

Widget buildSlider(BuildContext context, String label, double value, double min,
    double max, ValueChanged<double> onChanged,
    {int divisions = 0, List<String>? labels}) {
  return Container(
    padding: const EdgeInsets.all(10),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text.rich(
          TextSpan(
            text: '$label: ',
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w300),
            children: <TextSpan>[
              TextSpan(
                text: '${value.toInt()}',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
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
                          style: const TextStyle(color: Colors.blue),
                        ))
                    .toList()
                : List.generate(
                    (max - min).toInt() + 1,
                    (index) => Text(
                      '$index',
                      style: const TextStyle(color: Colors.blue),
                    ),
                  ),
          ),
        ),
      ],
    ),
  );
}

Widget buildNumberRangeSlider(BuildContext context, String label,
    RangeValues values, Color color, ValueChanged<RangeValues> onChanged) {
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
