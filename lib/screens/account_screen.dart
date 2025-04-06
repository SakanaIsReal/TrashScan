import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/bottom_nav_bar.dart';
import '../models/advancement_model.dart'; // Import your model
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import '../functions/user_data.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});
  
  @override 
  _AccountScreenState createState() => _AccountScreenState();
  
}

class _AccountScreenState extends State<AccountScreen> {
  // Get the current ongoing advancement (first incomplete one)
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
      orElse: () => allAdvancements.last, // Fallback to last if all completed
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
      body: Padding(
        padding: const EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
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
                        color: Theme.of(context).primaryColor),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 8.0, bottom: 8, left: 16, right: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Edit",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                          ),
                          SizedBox(
                            width: 6,
                          ),
                          Icon(
                            Icons.edit,
                            color: Colors.white,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Container(
              width: 180,
              height: 180,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.white,
                  width: 6.0,
                ),
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
                      : const AssetImage(
                              'assets/profile/profile_placeholder.png')
                          as ImageProvider,
                ),
              ),
            ),
            SizedBox(
              height: 16,
            ),
            Text(
              _username.isNotEmpty ? _username : "Unnamed",
              style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
            ),
            // SizedBox(height: 8,),
            Container(
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
                  color: Color(0xffFF9452)),
              child: Padding(
                  padding: const EdgeInsets.only(
                      top: 8.0, bottom: 8, left: 18, right: 18),
                  child: Text(
                    "Created 22/03/25",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  )),
            ),
            SizedBox(
              height: 20,
            ),
            Expanded(
              child: Column(
                children: [
                  // First row with 2 containers (2:3 ratio)
                  Expanded(
                    flex: 2, // 40% of available height
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.only(
                                right: 10), // Spacing between containers
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
                              color: Colors.white,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "161",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 40,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(top: 6, bottom: 6),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Pcs.',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            height: 1.3),
                                      ),
                                      Text(
                                        'Total',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            height: 1),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.only(
                                left: 10), // Spacing between containers
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
                              color: Colors.white,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "25",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 40,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(top: 6, bottom: 6),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'day',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            height: 1.3),
                                      ),
                                      Text(
                                        'Streak',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            height: 1),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 20), // Spacing between rows

                  // Second single container (3:5 ratio)
                  // Advancement Progress
                  Expanded(
                    flex: 3,
                    child: GestureDetector(
                      onTap: () => context.push('/advancement'),
                      child: Container(
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
                          color: advancement?.color ?? Colors.white,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Row(
                                  children: [
                                    Container(
                                      width: 90,
                                      height: 90,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(16),
                                        color: (Colors.white),
                                      ),
                                      child: Center(
                                        child: advancement != null
                                            ? SvgPicture.asset(
                                                advancement.svgPath,
                                                width: 50,
                                                height: 50,
                                              )
                                            : Icon(Icons.help_outline,
                                                size: 40, color: Colors.grey),
                                      ),
                                    ),
                                    const SizedBox(width: 16),
                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            advancement?.title ??
                                                'No current goal',
                                            style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                            ),
                                          ),
                                          const SizedBox(height: 8),
                                          Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(6),
                                              border: Border.all(
                                                color: Colors.white,
                                                width:
                                                    2.0, // Adjust border thickness as needed
                                              ),
                                            ),
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.circular(
                                                  4), // Slightly smaller than container
                                              child: LinearProgressIndicator(
                                                value: progressPercentage,
                                                backgroundColor:
                                                    Colors.grey[200],
                                                color: advancement?.color ??
                                                    Colors.grey,
                                                minHeight: 12,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            advancement != null
                                                ? '${advancement.progress}/${advancement.targetScan} scans'
                                                : 'Set a new goal',
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBar(
        selectedIndex: -1, // Choose the Correct Index
      ),
    );
  }
}
