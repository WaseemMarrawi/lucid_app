// import 'dart:developer';
//
// import 'package:flutter/material.dart';
//
// import '../../../extensions/extensions.dart';
// import '../../design.dart';
//
// showTimePickerBottomSheet({
//   required BuildContext context,
//   required TimeOfDay selectedTime,
//   required ValueChanged<TimeOfDay> onChangeTime,
// }) {
//   showModalBottomSheet(
//     context: context,
//     isScrollControlled: true,
//     builder: (context) => TimePickerBottomSheet(
//       time: selectedTime,
//       onChangeTime: onChangeTime,
//     ),
//   );
// }
//
// class TimePickerBottomSheet extends StatefulWidget {
//   const TimePickerBottomSheet({
//     super.key,
//     required this.time,
//     required this.onChangeTime,
//   });
//   final TimeOfDay time;
//   final ValueChanged<TimeOfDay> onChangeTime;
//
//   @override
//   State<TimePickerBottomSheet> createState() => _TimePickerBottomSheetState();
// }
//
// class _TimePickerBottomSheetState extends State<TimePickerBottomSheet> {
//   late final ValueNotifier<int> time;
//   @override
//   void initState() {
//     time = ValueNotifier(widget.time.hour * 60 + widget.time.minute);
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Space.vM2,
//           Center(
//             child: Container(
//               width: context.width * .125,
//               height: 3,
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(25),
//                 color: Colors.grey,
//               ),
//             ),
//           ),
//           Space.vM2,
//           ValueListenableBuilder<int>(
//             valueListenable: time,
//             builder: (context, value, _) {
//               log(value.toString());
//               return Container(
//                 padding: const EdgeInsets.all(16),
//                 decoration: BoxDecoration(
//                   color: Colors.transparent,
//                   borderRadius: BorderRadius.circular(16),
//                 ),
//                 child: Stack(
//                   children: [
//                     Positioned(
//                       top: context.height * .2 - 25,
//                       child: Container(
//                         width: context.width * .8,
//                         height: 50,
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(25),
//                           color: context.primarySwatch,
//                         ),
//                       ),
//                     ),
//                     SizedBox(
//                       width: context.width * .8,
//                       height: context.height * .4,
//                       child: ListWheelScrollView.useDelegate(
//                         itemExtent: 50,
//                         perspective: 0.001,
//                         diameterRatio: 2,
//                         physics: const FixedExtentScrollPhysics(),
//                         onSelectedItemChanged: (value) {
//                           time.value = value;
//                         },
//                         childDelegate: ListWheelChildBuilderDelegate(
//                           builder: (context, index) {
//                             final isAm = ((((index) ~/ 60)) ~/ 12) == 0;
//                             final hour = ((((index) ~/ 60)) % 12)
//                                 .toString()
//                                 .padLeft(2, '0');
//                             final minute =
//                                 ((index) % 60).toString().padLeft(2, "0");
//                             return Center(
//                               child: Center(
//                                 child: AnimatedDefaultTextStyle(
//                                   duration: const Duration(milliseconds: 0),
//                                   style:
//                                       context.labelMedium(
//                                     fontSize: 24,
//                                     color: value == index
//                                         ? context.scaffoldBackgroundColor
//                                         : Colors.grey.shade700,
//                                     height: 2.5,
//                                   ),
//                                   child: Directionality(
//                                     textDirection: TextDirection.ltr,
//                                     child: Row(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.spaceEvenly,
//                                       children: [
//                                         Text(
//                                           "$hour : $minute",
//                                           locale: const Locale("en"),
//                                           textDirection: TextDirection.ltr,
//                                         ),
//                                         Text(
//                                           isAm ? "AM" : "PM",
//                                           locale: const Locale("en"),
//                                           textDirection: TextDirection.ltr,
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             );
//                           },
//                           childCount: 60 * 24,
//                         ),
//                         controller: FixedExtentScrollController(
//                           initialItem: value,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               );
//             },
//           ),
//           const CustomButton.primary(
//             textTitle: "إختيار",
//           ),
//           Space.vM2,
//         ],
//       ),
//     );
//   }
// }
