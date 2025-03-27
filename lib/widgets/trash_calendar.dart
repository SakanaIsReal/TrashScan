import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'mini_calendar.dart';
import 'diary_summary.dart';
import 'popup_summary.dart';

class TrashCalendar extends StatefulWidget {
  @override
  _TrashCalendarState createState() => _TrashCalendarState();
}

class _TrashCalendarState extends State<TrashCalendar> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();

  final Map<DateTime, Color> _highlightedDays = {
    DateTime(2025, 1, 6): Colors.amber,
    DateTime(2025, 1, 7): Colors.amber,
    DateTime(2025, 1, 8): Colors.amber,
    DateTime(2025, 1, 10): Colors.grey,
    DateTime(2025, 1, 12): Colors.amber,
    DateTime(2025, 1, 15): Colors.green,
    DateTime(2025, 1, 24): Colors.amber,
  };

  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      rowHeight: 40,
      daysOfWeekHeight: 36,
      daysOfWeekStyle: DaysOfWeekStyle(
        weekdayStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        weekendStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
      ),
      firstDay: DateTime.utc(2020, 1, 1),
      lastDay: DateTime.utc(2030, 12, 31),
      focusedDay: _focusedDay,
      selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
      onDaySelected: (selectedDay, focusedDay) {
        setState(() {
          _selectedDay = selectedDay;
          _focusedDay = focusedDay;
          showSummaryPopup(context, MiniCalendar(), DiarySummary(divider: '. . . . . . . . . . . . . . . . . . . . . . . . . .',),);
        });
      },
      calendarStyle: CalendarStyle(
        todayDecoration: BoxDecoration(
          color: Colors.green, // Color for today
          shape: BoxShape.circle,
        ),
        selectedDecoration: BoxDecoration(
          color: Colors.amber, // Color for selected day
          shape: BoxShape.circle,
        ),
        outsideDaysVisible: false, // Hide days outside of the current month
      ),
      headerStyle: HeaderStyle(
        titleTextStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
        formatButtonVisible: false,
        titleCentered: true,
        leftChevronIcon: Icon(Icons.arrow_circle_left, color: Colors.black, size: 28,),
        rightChevronIcon: Icon(Icons.arrow_circle_right, color: Colors.black, size: 28,),
      ),
      calendarBuilders: CalendarBuilders(
        defaultBuilder: (context, day, focusedDay) {
          return Container(
            margin: EdgeInsets.all(5),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.grey[300], // Grey background for all days
              shape: BoxShape.circle,
            ),
            child: Text(
              '${day.day}',
              style: TextStyle(color: Colors.black), // Black text for contrast
            ),
          );
        },
      ),
    );
  }
}