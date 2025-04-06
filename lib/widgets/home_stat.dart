import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../functions/diary_storage.dart';
import 'package:intl/intl.dart';

class HomeStat extends StatefulWidget {
  const HomeStat({super.key});

  @override
  State<HomeStat> createState() => _HomeStatState();
}

class _HomeStatState extends State<HomeStat> {
  int _today = 0;
  int _week = 0;
  int _month = 0;
  late DateTime _now;

  @override
  void initState() {
    super.initState();
    _now = DateTime.now();
    _loadStats();
  }

  Future<void> _loadStats() async {
    final stats = await DiaryStorage.getStatsForTodayWeekMonth();
    setState(() {
      _today = stats['today']!;
      _week = stats['week']!;
      _month = stats['month']!;
    });
  }

  @override
  Widget build(BuildContext context) {
    final String weekday = DateFormat('EEEE').format(_now); // Monday
    final String day = DateFormat('d').format(_now); // 27

    return Stack(
      clipBehavior: Clip.none,
      children: [
        // Backgrounds
        Positioned.fill(
          top: 10,
          child: SvgPicture.asset(
            'assets/icons/bot_background.svg',
            fit: BoxFit.fill,
          ),
        ),
        Positioned.fill(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: SvgPicture.asset(
              'assets/icons/top_background.svg',
              fit: BoxFit.fill,
            ),
          ),
        ),

        // Foreground Content
        Padding(
          padding: const EdgeInsets.only(bottom: 50),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const SizedBox(width: 5),

                    /// Mini Calendar (Date box)
                    Container(
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
                          children: [
                            _buildDateBadge(weekday),
                            const SizedBox(height: 5),
                            Text(
                              day,
                              style: const TextStyle(
                                  fontSize: 36, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),

                    /// Divider
                    Container(
                      width: 2,
                      height: 100,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.grey),
                    ),

                    /// Stats Section
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Collected Total',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                        ),
                        _buildStatRow(Colors.white, "Today", _today.toString()),
                        _buildStatRow(
                            Color(0xffA5FF6D), "Week", _week.toString()),
                        _buildStatRow(
                            Color(0xff63DE84), "Month", _month.toString()),
                      ],
                    ),

                    const SizedBox(width: 5),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  /// Widget for the "Monday" badge
  Widget _buildDateBadge(String weekday) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.green[700],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        weekday,
        style:
            const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
    );
  }

  /// Widget for the stats row (e.g., "Today - 2")
  Widget _buildStatRow(Color color, String label, String value) {
    return Row(
      children: [
        Container(width: 3, height: 20, color: color),
        SizedBox(
          width: 12,
        ),
        Text(
          value,
          style: const TextStyle(
              fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        const SizedBox(width: 10),
        Text(label, style: const TextStyle(fontSize: 14, color: Colors.white)),
      ],
    );
  }
}
