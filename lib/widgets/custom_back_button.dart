import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart'; // Import go_router

class CustomBackButton extends StatelessWidget {
  const CustomBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(40),
          color: Colors.white,
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
          icon: const Icon(
            Icons.arrow_back,
            size: 26,
            color: Colors.black,
          ),
          onPressed: () {
            if (GoRouter.of(context).canPop()) {
              context.pop(); // Use go_router's pop method
            } else {
              debugPrint("No route to pop");
            }
          },
        ),
      ),
    );
  }
}
