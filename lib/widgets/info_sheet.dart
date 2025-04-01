import 'package:flutter/material.dart';
import 'bottom_nav_bar.dart';
import '../models/trash_information_model.dart';
import '../widgets/pcs_total_badge.dart';

enum InfoSheetType { loading, information, error }

class InfoSheet extends StatelessWidget {
  final InfoSheetType type;
  final int trash_id;

  const InfoSheet({super.key, required this.type, required this.trash_id});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 1, // Adjust as needed
      // padding: const EdgeInsets.symmetric(horizontal: 36.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            // Ensures content takes up available space, pushing BottomNavBar down
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 36.0),
              child: SingleChildScrollView(
                child: Container(child: _buildContent()),
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
        return Center(
          // Centers content in available space
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
        return _infomationDisplay(trash_id);
      case InfoSheetType.error:
        return _errorDisplay();
    }
  }

  Column _infomationDisplay(int id) {
    TrashInformationModel? trashCategory =
        TrashInformationModel.getCategoryById(id);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("This is", style: TextStyle(fontSize: 22)),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              trashCategory!.name,
              style: TextStyle(fontSize: 36, fontWeight: FontWeight.w900),
            ),
            PcsTotalBadge(count: trashCategory.total, color: Colors.black)
          ],
        ),
        _buildTags(trashCategory.tags, trashCategory.color),
        const SizedBox(height: 8),
        ClipRRect(
          borderRadius: BorderRadius.circular(24.0),
          child: Image.asset(trashCategory.imagePath),
        ),
        const SizedBox(height: 8),
        trashCategory.description
      ],
    );
  }

  Column _errorDisplay() {
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
                      _buildBulletPoint(
                          "Check Lighting & Angle: Ensure the item is well-lit and clearly visible in the camera."),
                      _buildBulletPoint(
                          "Try Again: Adjust the position and rescan."),
                      _buildBulletPoint(
                          "Manually Select: If scanning fails, you can manually search for the item in the list."),
                      _buildBulletPoint(
                          "Report Issue: If the item is missing from our database, consider reporting it so we can improve recognition."),
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

SizedBox _buildTags(List<String> tags, Color color) {
  return SizedBox(
    height: 40, // Fixed height to prevent overflow
    child: ListView.separated(
      scrollDirection: Axis.horizontal,
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(), // iOS-style scrolling
      // padding: const EdgeInsets.symmetric(horizontal: 12), // Outer padding
      itemCount: tags.length,
      separatorBuilder: (context, index) => const SizedBox(width: 8),
      itemBuilder: (context, index) => Chip(
        side: BorderSide.none,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        label: Text(
          tags[index],
          style: TextStyle(
            fontSize: 12,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: color,
        padding: const EdgeInsets.symmetric(horizontal: 10), // Inner chip padding
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap, // Compact touch target
      ),
    ),
  );
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
