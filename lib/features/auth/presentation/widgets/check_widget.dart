import 'package:flutter/material.dart';

import '../../../../common/extensions/src/context_extensions.dart';

class CheckWidget extends StatelessWidget {
  final ValueNotifier<String?> selectedGenderNotifier;

  final bool isEnable;
  final String title;
  final String value;

  const CheckWidget({
    super.key,
    required this.selectedGenderNotifier,
    required this.title,
    required this.value,
    this.isEnable=true,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap:isEnable? () {
          selectedGenderNotifier.value = value;
        }:null,
        child: ValueListenableBuilder(
          valueListenable: selectedGenderNotifier,
          builder: (context, valueNoti, child) {
            return Container(
              padding: EdgeInsetsDirectional.only(top: 16, bottom: 16, start: 18),
              decoration: BoxDecoration(
                border: Border.all(color:valueNoti==value?  context.primarySwatch:  context.textFieldBorder),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: [
                  CustomRadioDot<String?>(
                    value: value,
                    groupValueNotifier: selectedGenderNotifier,
                  ),
                  SizedBox(width: 10),
                  Text(title, style: context.headlineSmall(fontSize: 14)),
                ],
              ),
            );
          }
        ),
      ),
    );
  }
}

class CustomRadioDot<T> extends StatelessWidget {
  final T value;
  final ValueNotifier<T> groupValueNotifier;
  final Color dotColor;
  final double size;

  const CustomRadioDot({
    required this.value,
    required this.groupValueNotifier,
    this.dotColor = Colors.blue,
    this.size = 20,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<T>(
      valueListenable: groupValueNotifier,
      builder: (context, selectedValue, _) {
        final bool isSelected = selectedValue == value;

        return Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: Colors.black, // دائمًا أسود
              width: 2,
            ),
          ),
          child: isSelected
              ? Center(
                  child: Container(
                    width: size / 2,
                    height: size / 2,
                    decoration: BoxDecoration(
                      color: dotColor,
                      shape: BoxShape.circle,
                    ),
                  ),
                )
              : null,
        );
      },
    );
  }
}
