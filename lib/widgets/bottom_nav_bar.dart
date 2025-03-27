import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BottomNavBar extends StatefulWidget {
  final int selectedIndex;

  const BottomNavBar({
    super.key,
    required this.selectedIndex,
  });

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  
  static int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      height: 58,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10,
                    spreadRadius: 1,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildNavItem(context, Icons.home, 0, '/'),
                  _buildNavItem(context, Icons.calendar_today, 1, '/diary'),
                  _buildNavItem(context, Icons.bookmark, 2, '/bookmarks'),
                  _buildNavItem(context, Icons.delete, 3, '/map'),
                  _buildNavItem(context, Icons.settings, 4, '/settings'),
                ],
              ),
            ),
          ),
          const SizedBox(width: 20),
          Container(
            decoration: const BoxDecoration(
              color: Colors.black,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 6,
                  spreadRadius: 1,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: IconButton(
              icon: const Icon(Icons.camera_alt, size: 30, color: Colors.white),
              onPressed: () => context.push('/scan'), // Assign a separate index
            ),
          ),
        ],
      ),
    );
  }

  /// Helper function to create a nav item
  Widget _buildNavItem(BuildContext context, IconData icon, int index, String route) {
    return IconButton(
      icon: Icon(
        icon,
        size: 30,
        color: widget.selectedIndex == index ? const Color(0xff4F5C32) : Colors.grey,
      ),
      onPressed: () {
        if (widget.selectedIndex != index) {
          context.push(route); // Navigate only if not already selected
          _onItemTapped(index); // Update state
        }
      },
    );
  }
}
