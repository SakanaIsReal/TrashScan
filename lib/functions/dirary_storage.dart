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
}
