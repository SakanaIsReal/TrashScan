import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/bottom_nav_bar.dart';
import '../widgets/diary_summary.dart';
import '../widgets/trash_calendar.dart';

class DiaryScreen extends StatefulWidget {
  const DiaryScreen({super.key});

  @override
  _DiaryScreenState createState() => _DiaryScreenState();
}

class _DiaryScreenState extends State<DiaryScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
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
                    padding: const EdgeInsets.only(
                        top: 14.0, bottom: 14, left: 24, right: 24),
                    child: Column(
                      children: [
                        DiarySummary(
                          fontSize: 16.0, // Custom font size
                          summaryItems: [
                            SummaryItem('Plastic', 57),
                            SummaryItem('Metal', 9),
                            SummaryItem('Glass', 6),
                            SummaryItem('Paper', 13),
                            SummaryItem('Organic Waste', 47),
                            SummaryItem('Textiles', 2),
                            SummaryItem('E-waste', 1),
                            SummaryItem('Hazardous Waste', 3),
                            SummaryItem('Miscellaneous', 23),
                          ],
                        ),
                        SizedBox(height: 10,),
                        SvgPicture.asset('assets/icons/motivated.svg')
                      ],
                    ),
                  )),
            )
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBar(
        selectedIndex: 1
      ),
    );
  }
}
