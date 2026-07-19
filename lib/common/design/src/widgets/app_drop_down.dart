import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:restaurants_menu/common/extensions/extensions.dart';
import 'package:restaurants_menu/common/helper/helper.dart';

class DropDownButtonWidget<T> extends StatefulWidget {
  const DropDownButtonWidget({
    super.key,
    required this.items,
    required this.valueListenable,
    required this.onChanged,
    this.validator,
    this.label,
    this.hint,
    this.radius,
    this.padding,
    this.prefixIcon,
    this.suffixIcon,
    this.textSize,
    this.dropdownMaxHeight,
    this.enable,
    this.isExpanded = true,
  });

  final List<T> items;
  final ValueNotifier<T?> valueListenable;
  final Function(T? value) onChanged;
  final String? Function(T?)? validator;
  final String? label;
  final String? hint;
  final double? radius;
  final EdgeInsetsGeometry? padding;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final double? textSize;
  final double? dropdownMaxHeight;
  final bool isExpanded;
  final bool? enable;

  @override
  State<DropDownButtonWidget<T>> createState() =>
      _DropDownButtonWidgetState<T>();
}

class _DropDownButtonWidgetState<T> extends State<DropDownButtonWidget<T>> {
  @override
  Widget build(BuildContext context) {
    final baseDecoration = const InputDecoration().applyDefaults(
      Theme.of(context).inputDecorationTheme,
    );
    final radius = widget.radius ?? 12;

    return DropdownButtonFormField2<T>(
      isExpanded: widget.isExpanded,
      enableFeedback: widget.enable ?? true,

      valueListenable: widget.valueListenable,

      validator:
          widget.validator ??
          (val) {
            if (val == null || val == '') {
              return LocaleKeys.validationRequiredfield.tr();
            }
            return null;
          },

      onChanged: (val) {
        widget.valueListenable.value = val;
        widget.onChanged(val);
      },

      items: widget.items
          .map(
            (item) => DropdownItem<T>(
              value: item,
              child: Text(
                item.toString(),
                style: TextStyle(fontSize: widget.textSize ?? 14),
              ),
            ),
          )
          .toList(),

      decoration: baseDecoration.copyWith(
        filled: true,
        labelStyle: context.bodySmall(fontSize: 16, color: context.textFieldHintColor,),

        suffixIconConstraints: const BoxConstraints(minWidth: 45),
      ),

      hint: widget.hint != null
          ? Text(
              widget.hint!,
              style: TextStyle(
                fontSize: widget.textSize ?? 16,
                color: Colors.grey,
              ),
            )
          : null,

      iconStyleData: const IconStyleData(
        icon: Icon(Icons.arrow_drop_down_sharp),
      ),

      dropdownStyleData: DropdownStyleData(
        maxHeight: widget.dropdownMaxHeight ?? 250,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius),

          border: Border.all(color: context.primarySwatch),
        ),
      ),

      menuItemStyleData: const MenuItemStyleData(
        useDecorationHorizontalPadding: true,
      ),
    );
  }
}
