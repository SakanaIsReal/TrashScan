import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../models/advancement_model.dart';
import '../functions/diary_storage.dart';
import '../functions/user_data.dart';

class WelcomeMessage extends StatefulWidget {
  final String fallbackUsername;

  const WelcomeMessage({super.key, required this.fallbackUsername});

  @override
  State<WelcomeMessage> createState() => _WelcomeMessageState();
}

class _WelcomeMessageState extends State<WelcomeMessage> {
  String _username = '';
  AdvancementModel? _highestAchievement;
  int _totalPoints = 0;

  @override
  void initState() {
    super.initState();
    _loadUserInfoAndAdvancement();
  }

  Future<void> _loadUserInfoAndAdvancement() async {
    final user = await UserStorage.loadUserData();
    final totalPoints = await DiaryStorage.getTotalPoints();
    final advancements = AdvancementModel.getAdvancementsWithProgress(totalPoints);

    AdvancementModel? highestDone = advancements
        .where((a) => totalPoints >= a.targetScan)
        .fold<AdvancementModel?>(null, (prev, curr) {
      if (prev == null || curr.targetScan > prev.targetScan) return curr;
      return prev;
    });

    setState(() {
      _username = user?.username ?? widget.fallbackUsername;
      _highestAchievement = highestDone;
      _totalPoints = totalPoints;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 55),
        Container(
          width: 300,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Welcome back,",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                  color: Colors.black54,
                  height: 0.1,
                ),
              ),
              Text(
                _username,
                style: const TextStyle(fontSize: 68, fontWeight: FontWeight.bold, height: 1.3),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  if (_highestAchievement != null)
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                      decoration: BoxDecoration(
                        color: _highestAchievement!.color,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            _highestAchievement!.title,
                            style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                          const SizedBox(width: 5),
                          SvgPicture.asset(
                            _highestAchievement!.svgPath,
                            width: 18,
                            height: 18,
                            colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 25),
        Stack(
          children: [
            SvgPicture.asset('assets/icons/welcome.svg'),
            Positioned(
              right: 12,
              bottom: 0,
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xff4F5C32),
                  borderRadius: BorderRadius.circular(20),
                ),
                width: 160,
                height: 50,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '$_totalPoints',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 5),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          'Pcs.',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            height: 1.3,
                          ),
                        ),
                        Text(
                          'Scanned',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            height: 1,
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ],
    );
  }
}