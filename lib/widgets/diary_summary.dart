import 'package:flutter/material.dart';
import '../widgets/pcs_total_badge.dart';

class DiarySummary extends StatelessWidget {
  final double fontSize;
  final List<SummaryItem> summaryItems;
  final String divider;

  const DiarySummary({
    super.key,
    this.fontSize = 16.0,
    this.divider = '. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .',
    required this.summaryItems,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Summary',
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              ),
              PcsTotalBadge(count: '001', color: Theme.of(context).primaryColor)
            ],
          ),
          Column(
            children: summaryItems.map((item) => _buildSummaryRow(item.name, item.count)).toList(),
          )
        ],
      ),
    );
  }

  Widget _buildSummaryRow(String name, int count) {
    return Stack(
      children: [
        Text(
          divider,
          style: TextStyle(fontSize: fontSize),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              decoration: BoxDecoration(color: Colors.white),
              child: Padding(
                padding: const EdgeInsets.only(right: 4.0),
                child: Text(
                  name,
                  style: TextStyle(fontSize: fontSize),
                ),
              ),
            ),
            Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.only(left: 4.0),
                child: Text(
                  '$count pcs.',
                  style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class SummaryItem {
  final String name;
  final int count;

  SummaryItem(this.name, this.count);
}
