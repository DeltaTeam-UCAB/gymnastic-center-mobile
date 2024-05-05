import 'package:flutter/material.dart';

class BottomNavigationCenterIcon extends StatelessWidget {
  const BottomNavigationCenterIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      heightFactor: 0.1,
      child: Container(
        width: 70, 
        height: 70,
        decoration: const BoxDecoration(
          color: Colors.deepPurple,
          shape: BoxShape.circle,
        ),
        child: ClipOval(
          child: Image.asset(
            'assets/icon/icon_app.png',
            width: 20,
            height: 20,
            fit: BoxFit
                .fill,
          ),
        ),
      ),
    );
  }
}