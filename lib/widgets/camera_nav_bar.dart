import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'info_sheet.dart';

class CameraNavBar extends StatefulWidget {
  const CameraNavBar({super.key});

  @override
  State<CameraNavBar> createState() => _CameraNavBarState();
}

class _CameraNavBarState extends State<CameraNavBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      height: 58,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 58,
            height: 58,
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
            child: IconButton(
              icon: Icon(
                Icons.camera_alt,
                size: 36,
                color: Colors.black,
              ),
              onPressed: () {
                print("Icon Button Clicked");
                showModalBottomSheet(
                  constraints: BoxConstraints(maxHeight: 1400),
                  showDragHandle: true,
                  backgroundColor: Colors.white,
                  context: context,
                  builder: (BuildContext context) {
                    return InfoSheet(type: InfoSheetType.information, trash_id: 1);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
