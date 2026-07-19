import 'package:flutter/material.dart';
import '../../../../extensions/extensions.dart';

import 'animated_custom_dropdown/custom_dropdown.dart';

class CustomDropdownWithSearch<T> extends StatefulWidget {
  const CustomDropdownWithSearch({
    super.key,
    required this.getData,
    required this.itemToString,
    required this.onChange,
    required this.hintText,
    required this.items,
    this.initialItem,
    required this.isLoading,
    required this.isFailed,
    this.validator,
    this.selectedItemNotifier,
    this.isAutoUpdate= true,
  });
  final ValueChanged<String> getData;
  final ValueChanged<T> onChange;
  final String Function(T item) itemToString;
  final T? initialItem;
  final String hintText;
  final List<T> items;
  final bool isLoading;
  final bool isFailed;
  final String? Function(T? value)? validator;
  final ValueNotifier<T?>? selectedItemNotifier;
  final bool isAutoUpdate;

  @override
  State<CustomDropdownWithSearch<T>> createState() =>
      _CustomDropdownWithSearchState<T>();
}

class _CustomDropdownWithSearchState<T>
    extends State<CustomDropdownWithSearch<T>> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: CustomDropdown<T>(
        futureRequest: widget.getData,
        validator: widget.validator,
        items: widget.items,
        selectedItemNotifier: widget.selectedItemNotifier,
        isAutoUpdate: widget.isAutoUpdate,
        hintText: widget.hintText,
        listItemBuilder: (context, item) {
          return Text(
            widget.itemToString(item),
            style: context.headlineLarge(
              fontWeight: FontWeight.w400,
              fontSize: 14,
            ),
          );
        },
        headerBuilder: (context, selectedItem) {
          return Text(
            widget.itemToString(selectedItem),
            style: context.headlineLarge(
              fontWeight: FontWeight.w400,
              fontSize: 14,
            ),
          );
        },
        onChanged: widget.onChange,
        initialItem: widget.initialItem,
        isLoading: widget.isLoading,
        isFailed: widget.isFailed,
      ),
    );
  }
}
