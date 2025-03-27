import 'package:flutter/material.dart';

class SummaryPopup extends StatelessWidget {
  final Widget calendarWidget;
  final Widget summaryWidget;

  const SummaryPopup({
    super.key,
    required this.calendarWidget,
    required this.summaryWidget,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                calendarWidget, // Your calendar widget
                const SizedBox(height: 10),
                summaryWidget, // Your summary widget
              ],
            ),
          ),
          Positioned(
            top: -10,
            right: -10,
            child: IconButton(
              icon: const Icon(Icons.close),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
        ],
      ),
    );
  }
}

void showSummaryPopup(BuildContext context, Widget calendar, Widget summary) {
  showDialog(
    context: context,
    builder: (context) => SummaryPopup(
      calendarWidget: calendar,
      summaryWidget: summary,
    ),
  );
}
