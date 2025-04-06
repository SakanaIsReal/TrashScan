import 'package:flutter/material.dart';
import '../models/trash_information_model.dart';
import '../functions/diary_storage.dart';
import '../widgets/pcs_total_badge.dart';

class DiarySummary extends StatefulWidget {
  final double fontSize;
  final String divider;
  final DateTime? specificDate; // null = ทั้งหมด, ไม่ null = วันนั้น ๆ

  const DiarySummary({
    super.key,
    this.fontSize = 16.0,
    this.divider = '. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .',
    this.specificDate,
  });

  @override
  State<DiarySummary> createState() => _DiarySummaryState();
}

class _DiarySummaryState extends State<DiarySummary> {
  List<SummaryItem> _summaryItems = [];

  @override
  void initState() {
    super.initState();
    _loadSummaryData();
  }

  Future<void> _loadSummaryData() async {
    final diaryData = widget.specificDate != null
        ? await DiaryStorage.loadDiaryForDate(widget.specificDate!)
        : await _mergeAllDiary();

    final categories = TrashInformationModel.getCategories();

    final List<SummaryItem> summary = categories.map((cat) {
      final count = diaryData[cat.id.toString()] ?? 0;
      return SummaryItem(cat.name, count);
    }).toList();

    setState(() {
      _summaryItems = summary;
    });
  }

  Future<Map<String, int>> _mergeAllDiary() async {
    final all = await DiaryStorage.loadFullDiary();
    final Map<String, int> merged = {};

    for (final dailyData in all.values) {
      dailyData.forEach((key, value) {
        merged[key] = (merged[key] ?? 0) + value;
      });
    }

    return merged;
  }

  @override
  Widget build(BuildContext context) {
    final total = _summaryItems.fold<int>(0, (sum, item) => sum + item.count);

    return Container(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Summary',
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              ),
              PcsTotalBadge(count: total, color: Theme.of(context).primaryColor)
            ],
          ),
          Column(
            children: _summaryItems
                .map((item) => _buildSummaryRow(item.name, item.count))
                .toList(),
          )
        ],
      ),
    );
  }

  Widget _buildSummaryRow(String name, int count) {
    return Stack(
      children: [
        Text(
          widget.divider,
          style: TextStyle(fontSize: widget.fontSize),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              decoration: BoxDecoration(color: Colors.white),
              child: Padding(
                padding: const EdgeInsets.only(right: 4.0),
                child: Text(
                  name,
                  style: TextStyle(fontSize: widget.fontSize),
                ),
              ),
            ),
            Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.only(left: 4.0),
                child: Text(
                  '$count pcs.',
                  style: TextStyle(
                      fontSize: widget.fontSize, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class SummaryItem {
  final String name;
  final int count;

  const SummaryItem(this.name, this.count);
}
