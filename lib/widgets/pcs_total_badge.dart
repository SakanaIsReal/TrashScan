import 'package:flutter/material.dart';

class PcsTotalBadge extends StatefulWidget {
  final int count;
  final Color color;

  const PcsTotalBadge({super.key, required this.count, required this.color});

  @override
  State<PcsTotalBadge> createState() => _PcsTotalBadgeState();
}

class _PcsTotalBadgeState extends State<PcsTotalBadge> {
  @override
  Widget build(BuildContext context) {
    String paddedCount = widget.count.toString().padLeft(3, '0');
    return Container(
      decoration: BoxDecoration(
        color: widget.color,
        borderRadius: BorderRadius.circular(20),
      ),
      width: 90,
      height: 30,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            paddedCount,
            style: TextStyle(
                color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            width: 5,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 6, bottom: 6),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Pcs.',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 7,
                      fontWeight: FontWeight.bold,
                      height: 1.3),
                ),
                Text(
                  'Total',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 8,
                      fontWeight: FontWeight.bold,
                      height: 1),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
