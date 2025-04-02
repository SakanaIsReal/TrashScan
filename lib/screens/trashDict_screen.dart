import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:trashscan/widgets/custom_app_bar.dart';
import 'package:trashscan/widgets/bottom_nav_bar.dart';
import '../models/trash_information_model.dart';

class TrashdictScreen extends StatelessWidget {
  const TrashdictScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final categories = TrashInformationModel.getCategories();

    return Scaffold(
      appBar: CustomAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Type of",
              style: TextStyle(fontSize: 20, height: 0),
            ),
            Text(
              "Waste",
              style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold, height: 0),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  final category = categories[index];
                  return Container(
                    margin: const EdgeInsets.only(bottom: 16),
                    padding: EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(50),
                      border: Border.all(
                        color: const Color.fromARGB(255, 204, 204, 204),
                        width: 1.0,
                      ),
                    ),
                    child: ListTile(
                      leading: Icon(
                        category.icon,
                        color: category.color,
                        size: 26,
                      ),
                      title: Text(
                        category.name,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                        ),
                      ),
                      trailing: Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.grey,
                        size: 20,
                      ),
                      onTap: () {
                        context.pushNamed(
                          'education',
                          pathParameters: {'id': category.id.toString()},
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBar(selectedIndex: 2),
    );
  }
}
