import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/bottom_nav_bar.dart';
import '../widgets/diary_summary.dart';
import '../widgets/trash_calendar.dart';
import '../functions/diary_storage.dart';
import 'package:collection/collection.dart';
import '../models/trash_information_model.dart';

class DiaryScreen extends StatefulWidget {
  const DiaryScreen({super.key});

  @override
  _DiaryScreenState createState() => _DiaryScreenState();
}

class _DiaryScreenState extends State<DiaryScreen> {
  late Future<List<SummaryItem>> _summaryItemsFuture;

  @override
  void initState() {
    super.initState();
    _summaryItemsFuture = _loadSummaryItems();
  }

  Future<List<SummaryItem>> _loadSummaryItems() async {
    final diary = await DiaryStorage.loadTodayDiary();
    final categories = TrashInformationModel.getCategories();

    return categories.map((cat) {
      final count = diary[cat.id.toString()] ?? 0;
      return SummaryItem(cat.name, count);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: FutureBuilder<List<SummaryItem>>(
        future: _summaryItemsFuture,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          return SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 26.0, right: 26, top: 4),
                  child: TrashCalendar(),
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(22),
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
                      padding: const EdgeInsets.all(24.0),
                      child: DiarySummary(
                        fontSize: 16.0,
                        specificDate: null, 
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: BottomNavBar(selectedIndex: 1),
    );
  }
}
