import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/bottom_nav_bar.dart';
import '../models/advancement_model.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import '../functions/user_data.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  String _username = '';
  File? _profileImageFile;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final savedData = await UserStorage.loadUserData();
    if (savedData != null) {
      setState(() {
        _username = savedData.username;
        if (savedData.profileImagePath != null) {
          final file = File(savedData.profileImagePath!);
          if (file.existsSync()) {
            _profileImageFile = file;
          }
        }
      });
    }
  }

  AdvancementModel? get currentAdvancement {
    final allAdvancements = AdvancementModel.getAdvancements();
    return allAdvancements.firstWhere(
      (adv) => adv.progress < adv.targetScan,
      orElse: () => allAdvancements.last,
    );
  }

  @override
  Widget build(BuildContext context) {
    final advancement = currentAdvancement;
    final progressPercentage = advancement != null
        ? (advancement.progress / advancement.targetScan).clamp(0.0, 1.0)
        : 0.0;

    return Scaffold(
      appBar: CustomAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: () => context.push('/account_edit'),
                  child: Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: Offset(0, 0),
                        )
                      ],
                      borderRadius: BorderRadius.circular(20),
                      color: Theme.of(context).primaryColor,
                    ),
                    child: Padding(
                      padding:
                          const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          Text("Edit",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16)),
                          SizedBox(width: 6),
                          Icon(Icons.edit, color: Colors.white),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Container(
                width: 180,
                height: 180,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 6.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      spreadRadius: 4,
                      blurRadius: 5,
                      offset: Offset(0, 0),
                    )
                  ],
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: _profileImageFile != null
                        ? FileImage(_profileImageFile!)
                        : const AssetImage('assets/images/profile_placeholder.png')
                            as ImageProvider,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                _username.isNotEmpty ? _username : "Unnamed",
                style:
                    const TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Container(
                decoration: BoxDecoration(
                    color: const Color(0xffFF9452),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: Offset(0, 0),
                      )
                    ]),
                child: const Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 18.0, vertical: 8.0),
                  child: Text(
                    "Created 22/03/25",
                    style:
                        TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  _buildStatBox("161", "Pcs.", "Total"),
                  const SizedBox(width: 20),
                  _buildStatBox("25", "Day", "Streak"),
                ],
              ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () => context.push('/advancement'),
                child: _buildAdvancementBox(advancement, progressPercentage),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const BottomNavBar(selectedIndex: -1),
    );
  }

  Widget _buildStatBox(String number, String labelTop, String labelBottom) {
    return Expanded(
      child: Container(
        height: 100,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 0),
            )
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              number,
              style:
                  const TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
            ),
            const SizedBox(width: 5),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  labelTop,
                  style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      height: 1.3),
                ),
                Text(
                  labelBottom,
                  style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      height: 1),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildAdvancementBox(
      AdvancementModel? advancement, double progressPercentage) {
    return Container(
      height: 120,
      decoration: BoxDecoration(
        color: advancement?.color ?? Colors.grey,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 0),
          )
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Container(
              width: 90,
              height: 90,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Colors.white,
              ),
              child: Center(
                child: advancement != null
                    ? SvgPicture.asset(
                        advancement.svgPath,
                        width: 50,
                        height: 50,
                      )
                    : const Icon(Icons.help_outline,
                        size: 40, color: Colors.grey),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    advancement?.title ?? 'No current goal',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 8),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(6),
                    child: LinearProgressIndicator(
                      value: progressPercentage,
                      backgroundColor: Colors.grey[200],
                      color: Colors.white,
                      minHeight: 12,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    advancement != null
                        ? '${advancement.progress}/${advancement.targetScan} scans'
                        : 'Set a new goal',
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}