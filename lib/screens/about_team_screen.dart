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
          imagePath: 'assets/images/profile_saka.png',
          githubUrl: 'https://github.com/SakanaIsReal',
          linkedinUrl: 'https://www.linkedin.com/in/krittanon-chongklahan-67b5b9350/'),
      TeamMember(
          name: 'Jutichot',
          surname: 'Phengpan',
          role: 'Ux/UI Designner',
          imagePath: 'assets/images/profile_kan.png',
          githubUrl: 'https://github.com/Nicegreanz',
          linkedinUrl: 'https://www.linkedin.com/in/jutichot-phengpan-508a62358/'),
      TeamMember(
          name: 'Jirayu',
          surname: 'Saisawat',
          role: 'AI Developer',
          imagePath: 'assets/images/profile_inter.png',
          githubUrl: 'https://github.com/InterSecure-TheFoundation',
          linkedinUrl: 'https://www.linkedin.com/in/jirayu-s-911715353/'),
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
