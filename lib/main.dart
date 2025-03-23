import 'package:flutter/material.dart';
import 'app/router.dart'; // Import the router

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: appRouter, // Use the defined router from router.dart
    );
  }
}