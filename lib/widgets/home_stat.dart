import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeStat extends StatelessWidget {
  const HomeStat({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [

        /// Positioned Background SVGs (if needed)
        Positioned.fill(
          top: 10,
          child: SvgPicture.asset(
            'assets/icons/bot_background.svg',
            fit: BoxFit.fill, 
          ),
        ),

        /// Background Container with Curved Design
        Positioned.fill(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: SvgPicture.asset(
              'assets/icons/top_background.svg',
              fit: BoxFit.fill, 
            ),
          ),
        ),



        /// Foreground Content
        Padding(
          padding: const EdgeInsets.only(bottom: 50),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              
              
              /// App Title & Profile Icon

              /// Stats Container
              Container(
                padding: const EdgeInsets.all(16),
                
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [

                    SizedBox(width: 5,),

                    /// Date Section
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 8,
                            spreadRadius: 1,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            _buildDateBadge(),
                            const SizedBox(height: 5),
                            const Text(
                              "27", // Example day
                              style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),

                    /// Divider
                    Container(width: 2, height: 100, decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),color: Colors.grey),),
                    
                    /// Stats Section
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Collected Total', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),),
                        _buildStatRow(Color(0xffFFFFFF),"Today", "2"),
                        _buildStatRow(Color(0xffA5FF6D),"Week", "15"),
                        _buildStatRow(Color(0xff63DE84),"Month", "36"),
                      ],
                    ),
                    SizedBox(width: 5,),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  /// Widget for the "Monday" badge
  Widget _buildDateBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.green[700],
        borderRadius: BorderRadius.circular(8),
      ),
      child: const Text(
        "Monday",
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
    );
  }

  /// Widget for the stats row (e.g., "Today - 2")
  Widget _buildStatRow(Color color, String label, String value) {
    return Row(
      children: [
        Container(width: 3, height: 20, color: color),
        SizedBox(width: 12,),
        Text(
          value,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        const SizedBox(width: 10),
        Text(label, style: const TextStyle(fontSize: 14, color: Colors.white)),
      ],
    );
  }
}
