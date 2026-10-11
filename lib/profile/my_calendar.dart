import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';

class MyCalendar extends StatefulWidget {
  const MyCalendar({super.key, required this.onDateSelected});
  final Function(DateTime) onDateSelected;

  @override
  State<MyCalendar> createState() => _MyCalendarState();
}

class _MyCalendarState extends State<MyCalendar> {
  DateTime selectedDay = DateTime.now();
  DateTime focusedDay = DateTime.now();
  DateTime? selected;


  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xffFB9400).withOpacity(0.1),
      child: TableCalendar(
        locale: 'ru_RU',

        firstDay: DateTime(2020),
        lastDay: DateTime(2030),
        focusedDay: focusedDay,
        startingDayOfWeek: StartingDayOfWeek.saturday,

        selectedDayPredicate: (day) {
          return isSameDay(selectedDay, day);
        },

        onDaySelected: (selected, focused) {
          setState(() {
            selectedDay = selected;
            focusedDay = focused;
          });
          widget.onDateSelected(selected);
        },

        onPageChanged: (focused) {
          focusedDay = focused;
        },

        headerStyle: const HeaderStyle(
          formatButtonVisible: false,
          titleCentered: true,
          leftChevronIcon: Icon(
            Icons.chevron_left,
            color: Color(0xFFFD9301),
          ),
          rightChevronIcon: Icon(
            Icons.chevron_right,
            color: Color(0xFFFD9301),
          ),
        ),

        daysOfWeekStyle: DaysOfWeekStyle(
          weekdayStyle: TextStyle(
            color: Color(0xff797B86),
            fontSize: 12.sp,
            fontWeight: FontWeight.w700
          ),
          weekendStyle: TextStyle(
            color: Color(0xff797B86),
            fontSize: 12.sp,
            fontWeight: FontWeight.w700
          ),
        ),

        calendarStyle: CalendarStyle(
          outsideDaysVisible: false,

          selectedDecoration: const BoxDecoration(
            color: Color(0xFFFD9301),
            shape: BoxShape.circle,
          ),

          selectedTextStyle: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),

          todayDecoration: BoxDecoration(
            color: Colors.transparent,
            shape: BoxShape.circle,
          ),

          todayTextStyle: const TextStyle(
            color: Color(0xFFFD9301),
          ),
        ),
      ),
    );
  }
}