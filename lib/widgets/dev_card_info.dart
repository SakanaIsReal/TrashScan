import 'package:flutter/material.dart';
import 'package:trashscan/screens/about_team_screen.dart';
import 'package:url_launcher/url_launcher.dart';

class DevCardInfo extends StatelessWidget {
  final TeamMember member;

  const DevCardInfo({super.key, required this.member});

  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri)) {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Text(
        //   member.role,
        //   style: TextStyle(
        //     fontSize: 14,
        //     color: Colors.grey[700],
        //   ),
        // ),
        const SizedBox(height: 5),
        Row(
          children: [
            GestureDetector(
              onTap: () => _launchURL(member.githubUrl),
              child: IconButton(
                icon: Image.asset("assets/icons/github.png"),
                iconSize: 24,
                onPressed: () {
                  _launchURL(member.githubUrl);
                },
              ),
            ),
            GestureDetector(
              onTap: () => _launchURL(member.linkedinUrl),
              child: IconButton(
                icon: Image.asset('assets/icons/linkedin.png'),
                iconSize: 24,
                onPressed: () {
                  _launchURL(member.linkedinUrl);
                },
              ),
            )
          ],
        ),
      ],
    );
  }
}
