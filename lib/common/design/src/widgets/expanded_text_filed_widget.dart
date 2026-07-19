
// import 'package:flutter/material.dart';
//
// import '../../design.dart';
// import 'my_custom_widget/rotating_widget.dart';
//
// class ExpandedTextFiledWidget extends StatefulWidget {
//   const ExpandedTextFiledWidget({super.key,this.validator, required this.controller,required this.hintText});
//
//   final TextEditingController controller;
//   final String? hintText;
//   final String? Function(String? text)? validator;
//   @override
//   State<ExpandedTextFiledWidget> createState() =>
//       _ExpandedTextFiledWidgetState();
// }
//
// class _ExpandedTextFiledWidgetState extends State<ExpandedTextFiledWidget>
//     with TickerProviderStateMixin {
//   int maxLines = 3;
//   double totalDelta = 0;
//   bool isDragging = false;
//
//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: [
//         AnimatedSize(
//           duration: const Duration(milliseconds: 250),
//           curve: Curves.easeInOut,
//           alignment: Alignment.topCenter,
//           child: AbsorbPointer(
//             absorbing: isDragging,
//             child: MyAppTextField(
//               controller: widget.controller,
//               minLines: maxLines,
//               maxLines: maxLines,
//               keyboardType: TextInputType.name,
//               validator: widget.validator,
//               hintText: widget.hintText,
//             ),
//           ),
//         ),
//
//         PositionedDirectional(
//           end: 16,
//           bottom: 16,
//           child: GestureDetector(
//             onVerticalDragStart: (_) {
//               setState(() => isDragging = true);
//             },
//             onVerticalDragUpdate: (details) {
//               totalDelta += details.delta.dy;
//
//               if (totalDelta.abs() >= 30) {
//                 setState(() {
//                   maxLines += totalDelta.sign.toInt();
//                   maxLines = maxLines.clamp(3, 10);
//                 });
//                 totalDelta = 0;
//               }
//             },
//             onVerticalDragEnd: (_) {
//               setState(() => isDragging = false);
//             },
//             child: Padding(
//               padding: const EdgeInsets.only(left: 4, bottom: 4),
//               child: FlippableImage(
//                 child: SvgAsset(
//                   Assets.images.svg.expandedTextFiledIcon,
//                   height: 24,
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
