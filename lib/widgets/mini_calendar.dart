import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MiniCalendar extends StatelessWidget {
  final DateTime date;

  const MiniCalendar({super.key, required this.date});

  @override
  Widget build(BuildContext context) {
    final String weekday = DateFormat('EEEE').format(date); 
    final String day = DateFormat('d').format(date);     

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 8,
            spreadRadius: 1,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _buildDateBadge(weekday),
            const SizedBox(height: 5),
            Text(
              day,
              style: const TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDateBadge(String weekday) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.green[700],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        weekday,
        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
    );
  }
}
