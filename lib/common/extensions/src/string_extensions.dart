import 'package:flutter/material.dart';

extension StringExtentions on String? {
  toColor() {
    if (this == null || this!.isEmpty) {
      return Colors.black;
    }
    var hexStringColor = this;
    final buffer = StringBuffer();

    if (hexStringColor!.length == 6 || hexStringColor.length == 7) {
      buffer.write('ff');
      buffer.write(hexStringColor.replaceFirst("#", ""));
      return Color(int.parse(buffer.toString(), radix: 16));
    }
  }
}

extension PhoneFormatterExtension on String {
  String formatPhone() {
    if (isEmpty) return this;

    // إزالة المسافات والشرطات
    String phone = replaceAll(" ", "").replaceAll("-", "");

    if (phone.length <= 4) return phone;

    String start = phone.substring(0, 4);
    String number = phone.substring(4);

    List<String> parts = [];

    for (int i = 0; i < number.length; i += 3) {
      int end = (i + 3 < number.length) ? i + 3 : number.length;
      parts.add(number.substring(i, end));
    }

    return parts.isEmpty ? start : "$start ${parts.join(' ')}";
  }
}