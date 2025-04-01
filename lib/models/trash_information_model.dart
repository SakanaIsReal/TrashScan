import 'package:flutter/material.dart';

class TrashInformationModel {
  int id;
  String name;
  List<String> tags;
  RichText description;
  String imagePath;
  int total;
  Color color;

  TrashInformationModel({
    required this.id,
    required this.name,
    required this.tags,
    required this.description,
    required this.imagePath,
    required this.total,
    required this.color
  });

  static List<TrashInformationModel> getCategories() {
    List<TrashInformationModel> categories = [];

    categories.add(TrashInformationModel(
      id: 1,
      name: 'Plastics',
      tags: ['Recyclable', 'PET', 'HDPE'],
      description: RichText(
        text: TextSpan(
          text: 'Plastics can be recycled into new products. ',
          style: TextStyle(color: Colors.black),
          children: [
            TextSpan(
              text: 'Learn more',
              style: TextStyle(color: Colors.blue),
            ),
          ],
        ),
      ),
      imagePath: 'assets/images/plastics.jpg',
      total: 120,
      color: Color(0xff76CAFF)
    ));

    categories.add(TrashInformationModel(
      id: 2,
      name: 'Paper',
      tags: ['Recyclable', 'Cardboard', 'Newspaper'],
      description: RichText(
        text: TextSpan(
          text: 'Paper products can be recycled 5-7 times. ',
          style: TextStyle(color: Colors.black),
          children: [
            TextSpan(
              text: 'Learn more',
              style: TextStyle(color: Colors.blue),
            ),
          ],
        ),
      ),
      imagePath: 'assets/images/paper.png',
      total: 200,
      color: Color(0xff3CB75D)
    ));

    categories.add(TrashInformationModel(
      id: 3,
      name: 'E-waste',
      tags: ['Hazardous', 'Electronics', 'Recyclable'],
      description: RichText(
        text: TextSpan(
          text: 'E-waste requires special recycling. ',
          style: TextStyle(color: Colors.black),
          children: [
            TextSpan(
              text: 'Learn more',
              style: TextStyle(color: Colors.blue),
            ),
          ],
        ),
      ),
      imagePath: 'assets/images/ewaste.png',
      total: 25,
      color: Color(0xffFFC65C)
    ));

    categories.add(TrashInformationModel(
      id: 4,
      name: 'Glass',
      tags: ['Recyclable', 'Bottles', 'Jars'],
      description: RichText(
        text: TextSpan(
          text: 'Glass can be recycled endlessly. ',
          style: TextStyle(color: Colors.black),
          children: [
            TextSpan(
              text: 'Learn more',
              style: TextStyle(color: Colors.blue),
            ),
          ],
        ),
      ),
      imagePath: 'assets/images/glass.png',
      total: 65,
      color: Color(0xff949494)
    ));

    categories.add(TrashInformationModel(
      id: 5,
      name: 'Organic Waste',
      tags: ['Compostable', 'Food', 'Yard'],
      description: RichText(
        text: TextSpan(
          text: 'Organic waste can be composted. ',
          style: TextStyle(color: Colors.black),
          children: [
            TextSpan(
              text: 'Learn more',
              style: TextStyle(color: Colors.blue),
            ),
          ],
        ),
      ),
      imagePath: 'assets/images/organic.png',
      total: 150,
      color: Color(0xffF3833D)
    ));

    categories.add(TrashInformationModel(
      id: 6,
      name: 'Hazardous Waste',
      tags: ['Dangerous', 'Chemicals', 'Batteries'],
      description: RichText(
        text: TextSpan(
          text: 'Handle hazardous waste with care. ',
          style: TextStyle(color: Colors.black),
          children: [
            TextSpan(
              text: 'Learn more',
              style: TextStyle(color: Colors.blue),
            ),
          ],
        ),
      ),
      imagePath: 'assets/images/hazardous.png',
      total: 15,
      color: Color(0xffFF4F4F)
    ));

    return categories;
  }

  static TrashInformationModel? getCategoryById(int id) {
    try {
      return getCategories().firstWhere((category) => category.id == id);
    } catch (e) {
      return null; // Return null if no category matches the id
    }
  }
}
