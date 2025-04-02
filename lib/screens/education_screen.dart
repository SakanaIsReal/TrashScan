import 'package:flutter/material.dart';
import 'package:trashscan/widgets/custom_back_button.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/bottom_nav_bar.dart';
import '../models/trash_information_model.dart';

class EducationScreen extends StatefulWidget {
  final int id;

  const EducationScreen({
    super.key,
    required this.id,
  });

  @override
  _EducationScreenState createState() => _EducationScreenState();
}

class _EducationScreenState extends State<EducationScreen> {
  @override
  Widget build(BuildContext context) {
    final trashCategory = TrashInformationModel.getCategoryById(widget.id);

    if (trashCategory == null) {
      return Scaffold(
        appBar: CustomAppBar(),
        body: const Center(child: Text('Category not found')),
        bottomNavigationBar: BottomNavBar(selectedIndex: 2),
      );
    }

    return Scaffold(
      appBar: CustomAppBar(),
      body: SingleChildScrollView(
        // Moved SingleChildScrollView to be the root scrolling widget
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment
                  .start, // Changed to start for better alignment
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(
                          trashCategory.icon,
                          color: Colors.black,
                          size: 30,
                        ),
                        const SizedBox(width: 10),
                        Text(
                          trashCategory.name,
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                    CustomBackButton(),
                  ],
                ),
                const SizedBox(height: 20),
                Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(30.0),
                    child: Image.asset(
                      trashCategory.imagePath,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                trashCategory.longDescription,
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavBar(
        selectedIndex: 2,
      ),
    );
  }
}
