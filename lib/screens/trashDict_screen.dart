import 'package:flutter/material.dart';
import 'package:trashscan/widgets/custom_app_bar.dart';
import 'package:trashscan/widgets/bottom_nav_bar.dart';

class TrashdictScreen extends StatelessWidget {
  const TrashdictScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(),
        body: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Type of",
                style: TextStyle(fontSize: 25),
              ),
              Text(
                "Waste",
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
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
                    'assets/icons/plastic_icon.png',
                    width: 30,
                    height: 30,
                  ),
                  title: Text('Plastic',
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
                    'assets/icons/paper.png',
                    width: 30,
                    height: 30,
                  ),
                  title: Text('Paper',
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.w500)),
                  trailing: Image.asset(
                    'assets/icons/paper.png',
                    width: 3,
                    height: 3,
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
                    'assets/icons/battery_0_bar_icon.png',
                    width: 30,
                    height: 30,
                  ),
                  title: Text('E-Waste',
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
                    'assets/icons/glass_icon.png',
                    width: 30,
                    height: 30,
                  ),
                  title: Text('Glass',
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
                    'assets/icons/organic_icon.png',
                    width: 30,
                    height: 30,
                  ),
                  title: Text('Organic',
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
                    'assets/icons/hazardous_icon.png',
                    width: 30,
                    height: 30,
                  ),
                  title: Text('Hazardous Waste',
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
            ],
          ),
        ),
        bottomNavigationBar: BottomNavBar(selectedIndex: 2));
  }
}
