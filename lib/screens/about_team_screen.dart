import 'package:flutter/material.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/bottom_nav_bar.dart';
import 'package:trashscan/widgets/custom_back_button.dart';
import 'package:trashscan/widgets/dev_card.dart';

class TeamMember {
  final String name;
  final String surname;
  final String role;
  final String imagePath;
  final String githubUrl;
  final String linkedinUrl;

  TeamMember({
    required this.name,
    required this.surname,
    required this.role,
    required this.imagePath,
    required this.githubUrl,
    required this.linkedinUrl,
  });
}

class AboutTeamScreen extends StatelessWidget {
  const AboutTeamScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<TeamMember> teamMember = [
      TeamMember(
          name: 'Krittanon',
          surname: 'Chonklahan',
          role: 'Ux/UI Designner',
          imagePath: 'assets/icons/FrontSuki.png',
          githubUrl: 'https://github.com/SakanaIsReal',
          linkedinUrl: ''),
      TeamMember(
          name: 'Jutichot',
          surname: 'Phengpan',
          role: 'Ux/UI Designner',
          imagePath: 'assets/icons/FrontKanz.png',
          githubUrl: 'https://github.com/Nicegreanz',
          linkedinUrl: ''),
      TeamMember(
          name: 'Jirayu',
          surname: 'smart',
          role: 'AI Developer',
          imagePath: 'assets/icons/inter_chicken.png',
          githubUrl: 'https://github.com/InterSecure-TheFoundation',
          linkedinUrl: ''),
    ];

    return Scaffold(
        appBar: CustomAppBar(),
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      'Meet our team',
                      style: TextStyle(
                        fontSize: 33,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                    const Spacer(),
                    CustomBackButton(),
                  ],
                ),
                // const SizedBox(height: 2),
                Column(
                  children: teamMember.map((member) {
                    return DevCard(member: member);
                  }).toList(),
                )
              ],
            ),
          ),
        ),
        bottomNavigationBar: BottomNavBar(
          selectedIndex: 5,
        ));
  }
}
