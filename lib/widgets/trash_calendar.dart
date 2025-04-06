import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'mini_calendar.dart';
import 'diary_summary.dart';
import 'popup_summary.dart';
import '../functions/diary_storage.dart';

class TrashCalendar extends StatefulWidget {
  @override
  _TrashCalendarState createState() => _TrashCalendarState();
}

class _TrashCalendarState extends State<TrashCalendar> {
  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();

  final Map<DateTime, Color> _highlightedDays = {};

  @override
  void initState() {
    super.initState();
    _loadHighlightedDays(); // โหลดสีวันเมื่อเริ่มต้น
  }

  void _loadHighlightedDays() async {
    final allData = await DiaryStorage.loadFullDiary();
    Map<DateTime, Color> highlighted = {};

    allData.forEach((dateStr, trashMap) {
      final date = DateTime.parse(dateStr);
      final total = trashMap.values.fold<int>(0, (sum, val) => sum + val);

      if (total == 0) {
        highlighted[date] = Colors.grey;
      } else if (total > 3) {
        highlighted[date] = Colors.green;
      } else {
        highlighted[date] = Colors.amber;
      }
    });

    setState(() {
      _highlightedDays.clear();
      _highlightedDays.addAll(highlighted);
    });
  }

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
          showSummaryPopup(
            context,
            MiniCalendar(date: _selectedDay),
            DiarySummary(
              divider: '. . . . . . . . . . . . . . . . . . . . . . . . . .',
              specificDate: _selectedDay,
            ),
          );
        });
      },
      calendarStyle: CalendarStyle(
        todayDecoration: BoxDecoration(
          color: const Color.fromARGB(255, 50, 50, 50), // Color for today
          shape: BoxShape.circle,
        ),
        selectedDecoration: BoxDecoration(
          color:
              const Color.fromARGB(255, 86, 86, 87), // Color for selected day
          shape: BoxShape.circle,
        ),
        outsideDaysVisible: false, // Hide days outside of the current month
      ),
      headerStyle: HeaderStyle(
        titleTextStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
        formatButtonVisible: false,
        titleCentered: true,
        leftChevronIcon: Icon(
          Icons.arrow_circle_left,
          color: Colors.black,
          size: 28,
        ),
        rightChevronIcon: Icon(
          Icons.arrow_circle_right,
          color: Colors.black,
          size: 28,
        ),
      ),
      calendarBuilders: CalendarBuilders(
        defaultBuilder: (context, day, focusedDay) {
          final highlightColor =
              _highlightedDays[DateTime(day.year, day.month, day.day)];

          return Container(
            margin: EdgeInsets.all(5),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: highlightColor ?? Colors.grey[300], // ใช้สีจาก highlight
              shape: BoxShape.circle,
            ),
            child: Text(
              '${day.day}',
              style: TextStyle(
                color: highlightColor != null
                    ? Colors.white
                    : Colors.black, // เปลี่ยนสีตัวหนังสือให้ contrast
                fontWeight: FontWeight.bold,
              ),
            ),
          );
        },
      ),
    );
  }
}
