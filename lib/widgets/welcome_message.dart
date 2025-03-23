import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class WelcomeMessage extends StatelessWidget {
  final String username;

  const WelcomeMessage({super.key, required this.username});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          SizedBox(height: 55,),
          Container(
            width: 300,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
              "Welcome back,", 
              style: TextStyle(
                fontSize: 22, 
                fontWeight: FontWeight.w600,
                color: Colors.black54,
                height: 0.1
              )
            ),
            Text(username, style: const TextStyle(fontSize: 68, fontWeight: FontWeight.bold, height: 1.3)),
            // const SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.orangeAccent,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text("Trash Trooper", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
                      SizedBox(width: 5),
                      Icon(Icons.local_shipping, color: Colors.white, size: 18),
                    ],
                  ),
                ),
              ],
            ),
              ],
            ),
          ),
          SizedBox(height: 25,),
          Stack(
            children: [
              SvgPicture.asset('assets/icons/welcome.svg'),
              Positioned(
                right: 12,
                bottom: 0,
                child: Container(
                  decoration: BoxDecoration(
                    color: Color(0xff4F5C32),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  width: 160,
                  height: 50,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('001',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 36,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                      SizedBox(width: 5,),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Pcs.',
                            style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            height: 1.3

                          ),
                        ),
                          Text(
                            'Scanned',
                            style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            height: 1
                          ),)
                        ],
                      )
                    ],
                  ),
                ),
              )
            ]
          )
        ],
      ),
    );
  }
}
