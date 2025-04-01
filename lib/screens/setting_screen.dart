import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/bottom_nav_bar.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Image.asset(
                  'assets/icons/gear_setting.png',
                  width: 35,
                  height: 35,
                ),
                SizedBox(width: 10),
                Text(
                  "Setting",
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: const Color.fromARGB(255, 0, 0, 0),
                  ),
                ),
              ],
            ),
            SizedBox(height: 30),
            Card(
              color: Colors.white,
              margin: EdgeInsets.only(bottom: 16),
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
              ),
              child: ListTile(
                leading: Image.asset(
                  'assets/icons/account_circle.png',
                  width: 30,
                  height: 30,
                ),
                title: Text('Account',
                    style:
                        TextStyle(fontSize: 25, fontWeight: FontWeight.w500)),
                trailing: Image.asset(
                  'assets/icons/arrow_right.png',
                  width: 30,
                  height: 30,
                ),
                onTap: () {},
              ),
            ),
            Card(
              color: Colors.white,
              margin: EdgeInsets.only(bottom: 16),
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
              ),
              child: ListTile(
                leading: Image.asset(
                  'assets/icons/Notification_icon.png',
                  width: 30,
                  height: 30,
                ),
                title: Text('Notification',
                    style:
                        TextStyle(fontSize: 25, fontWeight: FontWeight.w500)),
                trailing: Image.asset(
                  'assets/icons/arrow_right.png',
                  width: 30,
                  height: 30,
                ),
                onTap: () {
                  context.go("/NotificationSetting");
                },
              ),
            ),
            Card(
              color: Colors.white,
              margin: EdgeInsets.only(bottom: 16),
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
              ),
              child: ListTile(
                leading: Image.asset(
                  'assets/icons/About_Team_icon.png',
                  width: 30,
                  height: 30,
                ),
                title: Text('About Team',
                    style:
                        TextStyle(fontSize: 25, fontWeight: FontWeight.w500)),
                trailing: Image.asset(
                  'assets/icons/arrow_right.png',
                  width: 30,
                  height: 30,
                ),
                onTap: () {
                  context.go('/about');
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
