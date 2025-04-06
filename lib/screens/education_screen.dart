import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
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
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          trashCategory.icon,
                          color: Colors.black,
                          size: 54,
                        ),
                        const SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Introducing...",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: Colors.black,
                                height: 0,
                              ),
                            ),
                            Text(
                              trashCategory.name,
                              style: TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                height: 0,
                              ),
                            ),
                          ],
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
                const SizedBox(height: 36),
                GestureDetector(
                  onTap: () {
                    context.push('/map', extra: widget.id);
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 6,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Center(
                      child: Text(
                        'Find nearby bin',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                )
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
