import 'dart:io';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../functions/user_data.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      toolbarHeight: 75,
      backgroundColor: const Color(0xff4F5C32),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () => context.push('/'),
            child: Row(
              children: const [
                Icon(Icons.delete, size: 40, color: Colors.white),
                SizedBox(width: 10),
                Text(
                  "TrashScan",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ],
            ),
          ),

        
          GestureDetector(
            onTap: () => context.push('/account'),
            child: FutureBuilder<UserData?>(
              future: UserStorage.loadUserData(),
              builder: (context, snapshot) {
                final userData = snapshot.data;

                if (userData != null && userData.profileImagePath != null && File(userData.profileImagePath!).existsSync()) {
                  return CircleAvatar(
                    radius: 22,
                    backgroundImage: FileImage(File(userData.profileImagePath!)),
                  );
                }

                return const CircleAvatar(
                  radius: 22,
                  backgroundColor: Colors.white,
                  child: Icon(Icons.person, color: Colors.black),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(75);
}
