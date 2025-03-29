import 'package:flutter/material.dart';
import 'bottom_nav_bar.dart';

enum InfoSheetType { loading, information, error }

class InfoSheet extends StatelessWidget {
  final InfoSheetType type;
  final String? message;

  const InfoSheet({super.key, required this.type, this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 1, // Adjust as needed
      // padding: const EdgeInsets.symmetric(horizontal: 36.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded( // Ensures content takes up available space, pushing BottomNavBar down
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 36.0),
              child: SingleChildScrollView(
                child: 
                  _buildContent(),
                
              ),
            ),
          ),
          const SizedBox(height: 10),
          BottomNavBar(selectedIndex: -1),
        ],
      ),
    );
  }

  Widget _buildContent() {
    switch (type) {
      case InfoSheetType.loading:
        return Center( // Centers content in available space
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const CircularProgressIndicator(),
              const SizedBox(width: 12),
              const Text("Now Loading . . .", style: TextStyle(fontSize: 22)),
            ],
          ),
        );
      case InfoSheetType.information:
        return Center(
          child: Text(
            message ?? "Here is some information.",
            style: const TextStyle(fontSize: 22, color: Colors.black),
            textAlign: TextAlign.center,
          ),
        );
      case InfoSheetType.error:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Sorry But...", style: TextStyle(fontSize: 22)),
            const SizedBox(height: 4),
            const Text(
              "Unrecognized Item",
              style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Image.asset('assets/images/trash_not_found.png'),
            const SizedBox(height: 8),
            RichText(
  text: TextSpan(
    style: TextStyle(color: Colors.black, fontSize: 16),
    children: [
      TextSpan(
        text: "The item you scanned could not be recognized.\n\n",
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      TextSpan(
        text: "Try the following steps:\n\n",
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      WidgetSpan(
        child: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildBulletPoint("Check Lighting & Angle: Ensure the item is well-lit and clearly visible in the camera."),
              _buildBulletPoint("Try Again: Adjust the position and rescan."),
              _buildBulletPoint("Manually Select: If scanning fails, you can manually search for the item in the list."),
              _buildBulletPoint("Report Issue: If the item is missing from our database, consider reporting it so we can improve recognition."),
            ],
          ),
        ),
      ),
    ],
  ),
)
          ],
        );
    }
  }
}
Widget _buildBulletPoint(String text) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 1.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("• ", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        Expanded(child: Text(text)),
      ],
    ),
  );
}