import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:trashscan/widgets/custom_back_button.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/bottom_nav_bar.dart';
import '../models/advancement_model.dart'; // Import your model

class AdvancementScreen extends StatefulWidget {
  const AdvancementScreen({super.key});

  @override
  _AdvancementScreenState createState() => _AdvancementScreenState();
}

class _AdvancementScreenState extends State<AdvancementScreen> {
  @override
  Widget build(BuildContext context) {
    final advancements = AdvancementModel.getAdvancements();

    return Scaffold(
      appBar: CustomAppBar(),
      body: Padding(
        padding: const EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0, ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Icon(
                  Icons.emoji_events,
                  size: 40,
                ),
                const SizedBox(width: 4),
                const Text(
                  'Achievements',
                  style: TextStyle(
                    fontSize: 33,
                    fontWeight: FontWeight.bold,
                  ),
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
                  final advancement = advancements[index];
                  final isCompleted = advancement.progress >= advancement.targetScan;
                  
                  return Container(
                    height: 140,
                    margin: const EdgeInsets.only(bottom: 20),
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: const Offset(0, 0),
                        )
                      ],
                      borderRadius: BorderRadius.circular(20),
                      color: advancement.color,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16),
                          child: Container(
                            height: 100,
                            width: 100,
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  spreadRadius: 2,
                                  blurRadius: 5,
                                  offset: const Offset(0, 0),
                                )
                              ],
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.white,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(14.0),
                              child: SvgPicture.asset(advancement.svgPath),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                advancement.title,
                                style: TextStyle(
                                  shadows: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  spreadRadius: 2,
                                  blurRadius: 5,
                                  offset: const Offset(0, 0),
                                )
                              ],
                                  fontWeight: FontWeight.bold,
                                  fontSize: 28,
                                  color: Colors.white
                                ),
                              ),
                              const SizedBox(height: 6),
                              Container(
                                height: 40,
                                width: 140,
                                decoration: BoxDecoration(
                                  color: isCompleted ? advancement.color : Colors.white,
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                    color: Colors.white,
                                    width: 3.0,
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    isCompleted 
                                      ? "DONE" 
                                      : "${advancement.progress}/${advancement.targetScan}",
                                    style: TextStyle(
                                      color: isCompleted ? Colors.white : Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: isCompleted ? 22 : 26,
                                      fontStyle: isCompleted ? FontStyle.italic : FontStyle.normal,
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
      bottomNavigationBar: BottomNavBar(
        selectedIndex: 4,
      ),
    );
  }
}