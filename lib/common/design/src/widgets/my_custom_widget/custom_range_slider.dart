import 'package:flutter/material.dart';

import '../../../../extensions/src/context_extensions.dart';

class CustomRangeSlider extends StatefulWidget {
  final TextEditingController minValue;
  final TextEditingController maxValue;

  const CustomRangeSlider({
    super.key,
    required this.minValue,
    required this.maxValue,
  });

  @override
  State<CustomRangeSlider> createState() => _CustomRangeSliderState();
}

class _CustomRangeSliderState extends State<CustomRangeSlider> {
  RangeValues _values = const RangeValues(50000, 1000000); // البداية

  @override
  void initState() {
    super.initState();
    widget.minValue.text = _values.start.toInt().toString();
    widget.maxValue.text = _values.end.toInt().toString();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // النصوص فوق
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                _values.start.toInt().toString(), // القيمة الصغرى
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                _values.end.toInt().toString(), // القيمة العليا
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        // السلايدر نفسه
        SliderTheme(
          data: SliderTheme.of(context).copyWith(
            trackHeight: 8,
            activeTrackColor: context.primarySwatch,
            inactiveTrackColor: const Color.fromRGBO(192, 219, 251, 1),
            thumbShape: const RoundSliderThumbShape(
              enabledThumbRadius: 10,
              pressedElevation: 2,
            ),
            overlayShape: const RoundSliderOverlayShape(
              overlayRadius: 16,
            ),
            thumbColor: context.primarySwatch,
            overlayColor: const Color.fromRGBO(205, 224, 255, 1),
          ),
          child: RangeSlider(
            values: _values,
            min: 50000,       // الحد الأدنى
            max: 10000000,    // الحد الأقصى
            divisions: 995,   // عدد الخطوات (اختياري: يخلي السحب على مراحل)
            onChanged: (RangeValues newValues) {
              setState(() {
                _values = newValues;
                widget.minValue.text = newValues.start.toInt().toString();
                widget.maxValue.text = newValues.end.toInt().toString();
              });
            },
          ),
        ),
      ],
    );
  }
}
