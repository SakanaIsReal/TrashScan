import 'package:flutter/material.dart';
import '../widgets/pcs_total_badge.dart';

class DiarySummary extends StatefulWidget {
  const DiarySummary({super.key});

  @override
  State<DiarySummary> createState() => _DiarySummaryState();
}

class _DiarySummaryState extends State<DiarySummary> {
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
            children: [
              // Generate trash
              _buildSummaryRow('Plastic', 57, 16),
              _buildSummaryRow('Metal', 9, 16),
              _buildSummaryRow('Glass', 6, 16),
              _buildSummaryRow('Paper', 13, 16),
              _buildSummaryRow('Organic Waste', 47, 16),
              _buildSummaryRow('Textiles', 2, 16),
              _buildSummaryRow('E-waste', 1, 16),
              _buildSummaryRow('Hazardous Waste', 3, 16),
              _buildSummaryRow('Miscellaneous', 23, 16),
            ],
          )
        ],
      ),
    );
  }

  /// Helper function to create a nav item
  Widget _buildSummaryRow(String name, int count, double fontSize) {
    String paddedNumber = count.toString();

    return Stack(
      children: [
        Text(
          '. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .',
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
                )),
            Container(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.only(left: 4.0),
                  child: Text(
                    '$paddedNumber pcs.',
                    style: TextStyle(
                        fontSize: fontSize, fontWeight: FontWeight.bold),
                  ),
                ))
          ],
        ),
      ],
    );
  }
}
