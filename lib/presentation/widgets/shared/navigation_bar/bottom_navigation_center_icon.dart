import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BottomNavigationCenterIcon extends StatelessWidget {
  const BottomNavigationCenterIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox.fromSize(
        size: const Size(70, 70),
        child: FloatingActionButton(
          backgroundColor: Colors.deepPurple,
          onPressed: () => context.push('/suscribed-courses'),
          shape: const CircleBorder(),
          child: Image.asset('assets/icon/ray.png', width: 40, height: 40),
        ),
      ),
    );
  }
}
