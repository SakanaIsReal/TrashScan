import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:trashscan/widgets/custom_back_button.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/bottom_nav_bar.dart';
import '../models/advancement_model.dart';
import '../functions/diary_storage.dart'; 

class AdvancementScreen extends StatefulWidget {
  const AdvancementScreen({super.key});

  @override
  _AdvancementScreenState createState() => _AdvancementScreenState();
}

class _AdvancementScreenState extends State<AdvancementScreen> {
  List<AdvancementModel> advancements = [];

  @override
  void initState() {
    super.initState();
    _loadAdvancements();
  }

  Future<void> _loadAdvancements() async {
    final totalPoints = await DiaryStorage.getTotalPoints();
    final adv = AdvancementModel.getAdvancementsWithProgress(totalPoints);

    setState(() {
      advancements = adv;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Padding(
        padding: const EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
        child: Column(
          children: [
            Row(
              children: [
                const Icon(Icons.emoji_events, size: 40),
                const SizedBox(width: 4),
                const Text(
                  'Achievements',
                  style: TextStyle(fontSize: 33, fontWeight: FontWeight.bold),
                ),
                const Spacer(),
                CustomBackButton(),
              ],
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: advancements.length,
                itemBuilder: (context, index) {
                  final adv = advancements[index];
                  final isCompleted = adv.progress >= adv.targetScan;

                  return Container(
                    height: 140,
                    margin: const EdgeInsets.only(bottom: 20),
                    decoration: BoxDecoration(
                      color: adv.color,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          spreadRadius: 2,
                          blurRadius: 5,
                        )
                      ],
                    ),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16),
                          child: Container(
                            height: 100,
                            width: 100,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  spreadRadius: 2,
                                  blurRadius: 5,
                                )
                              ],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(14.0),
                              child: SvgPicture.asset(adv.svgPath),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                adv.title,
                                style: TextStyle(
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  shadows: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.1),
                                      blurRadius: 5,
                                    )
                                  ],
                                ),
                              ),
                              const SizedBox(height: 6),
                              Container(
                                height: 40,
                                width: 140,
                                decoration: BoxDecoration(
                                  color: isCompleted ? adv.color : Colors.white,
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(color: Colors.white, width: 3),
                                ),
                                child: Center(
                                  child: Text(
                                    isCompleted
                                        ? "DONE"
                                        : "${adv.progress}/${adv.targetScan}",
                                    style: TextStyle(
                                      color: isCompleted ? Colors.white : Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: isCompleted ? 22 : 26,
                                      fontStyle:
                                          isCompleted ? FontStyle.italic : FontStyle.normal,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBar(selectedIndex: 4),
    );
  }
}