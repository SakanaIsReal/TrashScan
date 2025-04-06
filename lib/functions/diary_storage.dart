import 'dart:convert';
import 'dart:io';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';

class DiaryStorage {
  static Future<File> _getDiaryFile() async {
    final directory = await getApplicationDocumentsDirectory();
    return File('${directory.path}/diary_point.json');
  }

  static String _getTodayKey() {
    final now = DateTime.now();
    return DateFormat('yyyy-MM-dd').format(now);
  }

  static Future<Map<String, Map<String, int>>> loadFullDiary() async {
    try {
      final file = await _getDiaryFile();
      if (!await file.exists()) return {};
      final jsonStr = await file.readAsString();
      final raw = json.decode(jsonStr);

      return (raw as Map<String, dynamic>).map(
        (dateKey, innerMap) => MapEntry(
          dateKey,
          Map<String, int>.from(innerMap),
        ),
      );
    } catch (e) {
      return {};
    }
  }

  static Future<Map<String, int>> loadTodayDiary() async {
    final all = await loadFullDiary();
    final today = _getTodayKey();
    return all[today] ?? {};
  }

  static Future<void> saveFullDiary(Map<String, Map<String, int>> data) async {
    final file = await _getDiaryFile();
    await file.writeAsString(json.encode(data));
  }

  static Future<int> addPointForTrashId(String trashId) async {
    final today = _getTodayKey();
    final allData = await loadFullDiary();

    final todayData = allData[today] ?? {};
    final currentPoints = todayData[trashId] ?? 0;
    final updatedPoints = currentPoints + 1;

    todayData[trashId] = updatedPoints;
    allData[today] = todayData;

    await saveFullDiary(allData);
    return updatedPoints;
  }

  static Future<Map<String, int>> loadDiaryForDate(DateTime date) async {
    final key = DateFormat('yyyy-MM-dd').format(date);
    final all = await loadFullDiary();
    return all[key] ?? {};
  }

  static Future<int> getTotalPoints() async {
    final allData = await loadFullDiary();
    int total = 0;

    for (var dayEntry in allData.values) {
      total += dayEntry.values.fold(0, (sum, points) => sum + points);
    }

    return total;
  }

  static Future<int> getStreakCount() async {
    final fullDiary = await loadFullDiary();
    final today = DateTime.now();
    int streak = 0;

    for (int i = 0; i < 365; i++) {
      final date = today.subtract(Duration(days: i));
      final key = DateFormat('yyyy-MM-dd').format(date);
      final dayData = fullDiary[key];

      if (dayData == null ||
          dayData.values.fold(0, (sum, val) => sum + val) == 0) {
        break;
      }

      streak++;
    }

    return streak;
  }

  static Future<Map<String, int>> getStatsForTodayWeekMonth() async {
    final full = await loadFullDiary();
    final now = DateTime.now();
    final todayKey = DateFormat('yyyy-MM-dd').format(now);

    // วันนี้
    int todayTotal = (full[todayKey]?.values ?? []).fold(0, (a, b) => a + b);

    // สัปดาห์นี้ (เริ่มวันจันทร์)
    DateTime startOfWeek = now.subtract(Duration(days: now.weekday - 1));
    int weekTotal = 0;
    for (int i = 0; i < 7; i++) {
      final key =
          DateFormat('yyyy-MM-dd').format(startOfWeek.add(Duration(days: i)));
      weekTotal += (full[key]?.values ?? []).fold(0, (a, b) => a + b);
    }

    // เดือนนี้
    String monthPrefix = DateFormat('yyyy-MM').format(now);
    int monthTotal = 0;
    full.forEach((dateStr, dayData) {
      if (dateStr.startsWith(monthPrefix)) {
        monthTotal += (dayData.values).fold(0, (a, b) => a + b);
      }
    });

    return {
      'today': todayTotal,
      'week': weekTotal,
      'month': monthTotal,
    };
  }

  static Future<void> insertMockData() async {
    final file = await _getDiaryFile();

    final mockData = {
      '2025-04-01': {
        '7': 3,
        '2': 1,
        '3': 2,
      },
      '2025-04-02': {
        '4': 1,
      },
      '2025-04-03': {},
      '2025-04-04': {
        '2': 2,
        '3': 2,
      },
      '2025-04-05': {
        '7': 1,
      },
      '2025-04-06': {
        '7': 1,
      },
      '2025-04-07': {
        '6': 2,
        '7': 3,
      },
      '2025-04-08': {
        '2': 1,
        '3': 4,
        '4': 2,
      },
      '2025-04-09': {
        '7': 2,
        '3': 2,
        '5': 1,
      },
      '2025-04-10': {
        '4': 1,
        '6': 2,
        '7': 1,
        '2': 15,
      },
    };

    await file.writeAsString(json.encode(mockData));
  }
}
