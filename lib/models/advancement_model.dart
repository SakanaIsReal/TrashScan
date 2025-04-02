import 'package:flutter/material.dart';

class AdvancementModel {
  final int id;
  final String title;
  final int targetScan;
  final RichText description;
  final String svgPath;
  final int progress;
  final Color color;

  AdvancementModel({
    required this.id,
    required this.title,
    required this.targetScan,
    required this.description,
    required this.svgPath,
    required this.progress,
    required this.color,
  });

  // Static method to get all advancements
  static List<AdvancementModel> getAdvancements() {
    return [
      AdvancementModel(
        id: 1,
        title: "Litterbug",
        targetScan: 5,
        description: RichText(
          text: TextSpan(
            text: "Just getting started—time to clean up your act!",
            style: TextStyle(color: Colors.black),
          ),
        ),
        svgPath: "assets/icons/litterbug.svg",
        progress: 3,
        color: Color(0xFF707070),
      ),
      AdvancementModel(
        id: 2,
        title: "Recycler",
        targetScan: 20,
        description: RichText(
          text: TextSpan(
            text: "Learning the basics of waste sorting. Keep going!",
            style: TextStyle(color: Colors.black),
          ),
        ),
        svgPath: "assets/icons/recycling_rookie.svg",
        progress: 0,
        color: Color(0xFF38B3FF),
      ),
      AdvancementModel(
        id: 3,
        title: "Trash Trooper",
        targetScan: 50,
        description: RichText(
          text: TextSpan(
            text: "Taking action! Sorting waste like a pro.",
            style: TextStyle(color: Colors.black),
          ),
        ),
        svgPath: "assets/icons/trash_trooper.svg",
        progress: 0,
        color: Color(0xFFFF9452),
      ),
      AdvancementModel(
        id: 4,
        title: "Waste Warrior",
        targetScan: 100,
        description: RichText(
          text: TextSpan(
            text: "Fighting for a cleaner world—one bin at a time.",
            style: TextStyle(color: Colors.black),
          ),
        ),
        svgPath: "assets/icons/waste_warrior.svg",
        progress: 0,
        color: Color(0xFFA2B164),
      ),
      AdvancementModel(
        id: 5,
        title: "Eco Guardian",
        targetScan: 250,
        description: RichText(
          text: TextSpan(
            text: "A protector of nature, making a real impact!",
            style: TextStyle(color: Colors.black),
          ),
        ),
        svgPath: "assets/icons/eco_guardian.svg",
        progress: 0,
        color: Color(0xFF007C7C),
      ),
    ];
  }

  // Get advancement by ID
  static AdvancementModel? getAdvancementById(int id) {
    try {
      return getAdvancements().firstWhere((advancement) => advancement.id == id);
    } catch (e) {
      return null;
    }
  }

  // Get filtered advancements (e.g., by progress)
  static List<AdvancementModel> getFilteredAdvancements({int? minProgress}) {
    return getAdvancements().where((advancement) {
      return minProgress == null || advancement.progress >= minProgress;
    }).toList();
  }
}