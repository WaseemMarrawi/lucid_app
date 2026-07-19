import 'package:flutter/material.dart';
import '../../../../extensions/src/context_extensions.dart';
import '../../../../helper/src/locale_keys.dart';
import '../../theme/const.dart';



class MyCustomDropDownWidget<T> extends StatelessWidget {
  final  T? value;
  final void Function(T? t)  fun;
  final String Function(T value) getString;
  final List<T> list;
  final String hint;
  final Widget? prefixIcon;

  const MyCustomDropDownWidget({super.key, this.value, required this.fun, required this.hint, required this.getString, required this.list,
  this.prefixIcon

  });



  @override
  Widget build(BuildContext context) {
    final baseDecoration = const InputDecoration().applyDefaults(
      Theme.of(context).inputDecorationTheme,
    );
    return DropdownButtonFormField<T>(
        value: value,
        onChanged: fun,
        items: list
            .map<DropdownMenuItem<T>>((value) {
          return DropdownMenuItem<T>(
            value: value,
            child: Text(
               getString(value),
                style: context.headlineSmall(
                  fontSize: 15,
                  fontWeight: FontWeight.w400
                ),
              ),
          );
        }).toList(),
        hint: Text(
            hint,
          style: context.labelMedium(
              color: context.textFieldHintColor,
              fontSize: 14,
              fontWeight: FontWeight.w400
          ),

          ),
        isExpanded: true,
        iconSize: 30,
        iconDisabledColor: context.primarySwatch,
        iconEnabledColor: context.primarySwatch,
        borderRadius: BorderRadius.circular(20),
        enableFeedback: true,

        validator: (value) => value == null
            ? LocaleKeys.validationRequiredfield.tr()
            : null,
        // decoration: inputDecorationBordered
        decoration: baseDecoration.
        copyWith(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(28),
            borderSide:  BorderSide(color: context.primarySwatch),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(28),
            borderSide: BorderSide(color: context.primarySwatch),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(28),
            borderSide: BorderSide(width: 2, color: context.primarySwatch),
          ),
          disabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: context.primarySwatch),
            borderRadius: BorderRadius.circular(28),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: context.errorColor),
            borderRadius: BorderRadius.circular(28),
          ),
          errorStyle:  context.labelMedium(
              fontSize: 10,
              fontWeight: FontWeight.w500,
              color: context.errorColor
          ),
          prefixIcon: prefixIcon,
          contentPadding: const EdgeInsets.symmetric(vertical:  PPadding.mainPadding * 1,horizontal:PPadding.mainPadding * 2 ),
          fillColor:  Colors.white,
          filled: true,

          labelStyle: context.labelMedium(
            color: context.primarySwatch,
            fontSize: 14,
          ),

        ),

      style: context.labelMedium(
          color: context.themeExt.palette.black,
          fontSize: 14,
          fontWeight: FontWeight.w400
      ),
    );
  }
}