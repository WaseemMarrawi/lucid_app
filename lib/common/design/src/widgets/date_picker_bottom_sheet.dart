import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../extensions/extensions.dart';
import '../../../helper/src/locale_keys.dart';
import '../../design.dart';

Future<void> showDatePickerBottomSheet({
  required BuildContext context,
  // required DateTime firstDate,
  // required DateTime lastDate,
  // required DateTime selectedDate,
  required ValueChanged<DateTime> onChangeDate,
})
{
  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (context) {
      return CustomDatePicker(
        firstDate: DateTime.now(),
        lastDate: DateTime(DateTime.now().year, 12, 31), // نهاية السنة
        onChangeDate: (DateTime value) {
          print("Selected: $value");
        },
        selectedDate: DateTime.now(),
      );
    },
  );
}

class CustomDatePicker extends StatefulWidget {
  const CustomDatePicker({
    super.key,
    required this.firstDate,
    required this.lastDate,
    required this.onChangeDate,
    required this.selectedDate,
  });

  final DateTime firstDate;
  final DateTime lastDate;
  final DateTime selectedDate;
  final ValueChanged<DateTime> onChangeDate;

  static void showDatePicker(
      BuildContext context, TextEditingController controller,DateTime dateTime)
  {
    showCupertinoModalPopup(
      context: context,
      builder: (context) => Container(
        height: context.height*.3,
        color: context.theme.colorScheme.surfaceContainer,
        child: Column(
          children: [
            const Spacer(flex: 2),
            SizedBox(
              height: context.height*.2,
              child: CupertinoDatePicker(
                minimumDate: DateTime.now(),
                initialDateTime: DateTime.now(),
                mode: CupertinoDatePickerMode.date,
                onDateTimeChanged: (val) {
                  dateTime=val;
                  controller.text = DateFormat('yyyy/MM/dd').format(val);
                  // widget.onDateTimeChanged?.call(val);
                },


              ),
            ),
            const Spacer(),
            // Close the modal
            CupertinoButton(
                child:  Text('OK',style: context.displaySmall(fontSize: 16),),
                onPressed: () {
                  // if (_controller.text.isEmpty) {
                  //   if (widget.initialValue != null) {
                  //     _controller.text = DateFormat('yyyy/MM/dd').parse(widget.initialValue!).toString();
                  //   } else if (widget.minimumDate != null) {
                  //     _controller.text = DateFormat('yyyy/MM/dd').format(widget.minimumDate!);
                  //   } else if (widget.initialDateTime != null) {
                  //     _controller.text = DateFormat('yyyy/MM/dd').format(widget.initialDateTime!);
                  //   }
                  // }
                  Navigator.pop(context);
                }),
            const Spacer(),
          ],
        ),
      ),
    );
  }

  @override
  State<CustomDatePicker> createState() => _CustomDatePickerState();
}

class _CustomDatePickerState extends State<CustomDatePicker> {
  late DateTime _selectedDay;
  late DateTime _focusedDay;

  @override
  void initState() {
    _selectedDay = widget.selectedDate;
    _focusedDay = widget.selectedDate;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(PPadding.mainPadding),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Center(
            child: Container(
              width: context.width * .125,
              height: 3,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: Colors.grey,
              ),
            ),
          ),
          Space.vM2,
          TableCalendar(
            locale: context.locale.languageCode,
            firstDay: widget.firstDate,
            lastDay: widget.lastDate,
            focusedDay: _focusedDay,
            selectedDayPredicate: (day) {
              return isSameDay(_selectedDay, day);
            },
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
              });
            },
            calendarStyle: CalendarStyle(
              todayDecoration: BoxDecoration(
                color: context.primarySwatch.withOpacity(.7),
                shape: BoxShape.circle,
              ),
              selectedDecoration: BoxDecoration(
                color: context.primarySwatch,
                shape: BoxShape.circle,
              ),
              defaultTextStyle: const TextStyle(color: Colors.black),
              weekendTextStyle: const TextStyle(color: Colors.black),
            ),
            headerStyle: HeaderStyle(
              titleCentered: true,
              formatButtonVisible: false,
              titleTextStyle: context.titleLarge()!,
              leftChevronIcon:
                  const Icon(Icons.chevron_left, color: Colors.black),
              rightChevronIcon:
                  const Icon(Icons.chevron_right, color: Colors.black),
            ),
            daysOfWeekStyle: const DaysOfWeekStyle(
              weekdayStyle: TextStyle(color: Colors.black),
              weekendStyle: TextStyle(color: Colors.black),
            ),
          ),
          const SizedBox(height: 16),
          CustomButton.primary(
            onPressed: () {
              widget.onChangeDate(_selectedDay);
              context.pop(context);
            },
            textTitle: 'اختيار',
          ),
        ],
      ),
    );
  }
}
