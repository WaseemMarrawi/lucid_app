//
// import 'package:evowash_user_flutter_app/common/extensions/extensions.dart';
// import 'package:flutter/material.dart';
//
//
//
// class PhoneText extends StatelessWidget {
//   final String text;
//   final TextStyle? style;
//
//   const PhoneText({super.key, required this.text, this.style});
//
//   @override
//   Widget build(BuildContext context) {
//     return Directionality(
//       textDirection: TextDirection.ltr,
//       child: Text(
//         formatPhone(text),
//         style: style ?? context.displaySmall(fontSize: 14),
//
//         overflow: TextOverflow.ellipsis,
//         maxLines: 1,
//       ),
//     );
//   }
//   String formatPhone(String phone) {
//     // إزالة أي مسافات أو شرطات
//     phone = phone.replaceAll(" ", "").replaceAll("-", "");
//
//     String start = phone.substring(0, phone.length >= 4 ? 4 : phone.length);
//     String number = phone.length > 4 ? phone.substring(4) : "";
//
//     // تقسيم الرقم المتبقي إلى مجموعات من 3
//     List<String> parts = [];
//     for (int i = 0; i < number.length; i += 3) {
//       int end = (i + 3 < number.length) ? i + 3 : number.length;
//       parts.add(number.substring(i, end));
//     }
//
//     // دمج الكود + باقي الرقم
//     return parts.isEmpty ? start : "$start ${parts.join(' ')}";
//   }
//
//
//
// }