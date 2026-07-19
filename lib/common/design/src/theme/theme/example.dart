////////////////////////////////////////////////////////
// Color primary = context.primaryColor;
//
// // لون أساسي بدرجة 300 من primarySwatch
// Color primary300 = context.themeExt.palette.primarySwatch[300]!;
//
// // لون ثانوي
// Color secondary = context.secondaryColor;
//
// // لون خلفية
// Color background = context.backgroundColor;
//
// // لون على الأساسي (onPrimary)
// Color onPrimary = context.onPrimaryColor;
//
// // لون تنبيهات (نجاح، تحذير، معلومات)
// Color success = context.successColor;
// Color warning = context.warningColor;
// Color info = context.infoColor;
//
// // لون ترويسة أسود خاص
// Color black = context.blackColor;
//
// // لون حواف الحقول النصية
// Color inputBorder = context.textFieldBorderColor;



///////////////////////////////////////////////////////////Text Style
//// نص كبير مع اللون الافتراضي (primary)
// TextStyle? title1 = context.displayLarge();
//
// // نص متوسط مع تخصيص اللون والحجم
// TextStyle? title2 = context.headlineMedium(
//   color: Colors.red,
//   fontSize: 24,
//   fontWeight: FontWeight.bold,
// );
//
// // نص صغير مع لون افتراضي (لون النص الأساسي)
// TextStyle? body = context.bodyMedium();
//
// // نص مع لون أبيض
// TextStyle? whiteTitle = context.titleLarge();
//
// // نص مع تغيير سمك الخط فقط
// TextStyle? labelBold = context.labelSmall(fontWeight: FontWeight.w700);



///////////////////////////////////////////////////InputDecorationTheme

//// Theme الخاص بحقول النص
// InputDecorationTheme inputTheme = context.inputDecorationTheme;
//
// // مثال لاستخدامها
// TextField(
//   decoration: InputDecoration(
//     hintText: 'ادخل نص',
//     // يمكنك تخصيص مظهر الحقل باستخدام inputTheme مباشرة
//   ),
// );




/////////////////////////////////////////////////////General
//// ThemeData كامل
// ThemeData theme = context.theme;
//
// // TextTheme كامل
// TextTheme textTheme = context.textTheme;
//
// // خلفية Scaffold
// Color scaffoldBg = context.scaffoldBackgroundColor;
//
// // الوصول لaccentColor من colorScheme (عادة ثانوي)
// Color accent = context.accentColor;
//
// // معرفة الوضع الليلي
// bool isDark = context.isDarkMode;
//
// // تغيير الثيم
// context.toggleTheme();


///////////////////////////////////////////////example

//Widget build(BuildContext context) {
//   return Scaffold(
//     backgroundColor: context.scaffoldBackgroundColor,
//     appBar: AppBar(
//       backgroundColor: context.primaryColor,
//       title: Text('مثال استخدام الثيم', style: context.titleLarge()),
//     ),
//     body: Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Text('لون أساسي', style: context.displayLarge()),
//           SizedBox(height: 12),
//           Container(
//             width: 100,
//             height: 50,
//             color: context.themeExt.palette.primarySwatch[300],
//             alignment: Alignment.center,
//             child: Text('Primary 300', style: context.bodyMedium(color: Colors.white)),
//           ),
//           SizedBox(height: 12),
//           ElevatedButton(
//             style: ElevatedButton.styleFrom(
//               backgroundColor: context.secondaryColor,
//               foregroundColor: context.onSecondaryColor,
//             ),
//             onPressed: () {},
//             child: Text('زر ثانوي', style: context.labelLarge()),
//           ),
//         ],
//       ),
//     ),
//   );
// }