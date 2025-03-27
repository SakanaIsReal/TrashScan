// import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:trashscan/screens/diary_screen.dart';
import 'package:trashscan/screens/map_screen.dart';
import 'package:trashscan/screens/scan_screen.dart';
import '../screens/home_screen.dart';
// import '../screens/second_screen.dart';
// import '../screens/profile_screen.dart';

// Define GoRouter instance
final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => HomeScreen(),
    ),
    GoRoute(
      path: '/diary',
      builder: (context, state) => DiaryScreen(),
    ),
    GoRoute(
      path: '/scan',
      builder: (context, state) => ScanScreen(),
    ),
    GoRoute(
      path: '/map',
      builder: (context, state) => MapScreen(),
    ),
  ],
);
