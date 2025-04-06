import 'package:flutter/material.dart';
import 'package:trashscan/screens/about_team_screen.dart';
import 'dev_card_info.dart';

class DevCard extends StatelessWidget {
  final TeamMember member;

  const DevCard({super.key, required this.member});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 4, top: 4),
      elevation: 0,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.zero,
        side: BorderSide.none,
      ),
      child: Padding(
        padding: const EdgeInsets.all(6.0),
        child: Row(
          children: [
            Container(
              width: 140,
              height: 140,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20), // Round corners
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 4,
                    offset: const Offset(0, 0), // Shadow offset
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20), // Match container radius
                child: Image.asset(
                  member.imagePath,
                  fit: BoxFit.cover, // Changed to cover to fill the square
                ),
              ),
            ),
            const SizedBox(width: 20.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(member.name,
                    style:
                        TextStyle(fontSize: 27, fontWeight: FontWeight.bold)),
                Text(
                  member.surname,
                  style: TextStyle(fontSize: 27, fontWeight: FontWeight.bold),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFF4F5C32),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    member.role,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                DevCardInfo(
                  member: member,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}