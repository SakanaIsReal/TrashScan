import 'package:flutter/material.dart';
import 'bottom_nav_bar.dart';

class InfoSheet extends StatefulWidget {
  const InfoSheet({super.key});

  @override
  State<InfoSheet> createState() => _InfoSheetState();
}

class _InfoSheetState extends State<InfoSheet> {
  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 36.0),
              child: Column(
                children: [
                  Text(
                    "Now Loading . . . ",
                    style: TextStyle(fontSize: 22),
                  ),
                ],
              ),
            ),
            BottomNavBar(
              selectedIndex: -1,
            )
          ],
        ),
      ],
    );
  }
}
