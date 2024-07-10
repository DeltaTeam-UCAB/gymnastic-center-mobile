import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AdminBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  const AdminBottomNavigationBar({super.key, required this.currentIndex});

  void onItemTapped( BuildContext context, int index) {
    context.go('/admin/$index');
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      onTap: (value) => onItemTapped(context, value),
      currentIndex: currentIndex,
      selectedIconTheme: const IconThemeData(
        color: Color.fromARGB(255, 93, 43, 187)
      ),
      fixedColor: const Color.fromARGB(255, 93, 43, 187),
      showSelectedLabels: true,
      elevation: 0,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.edit_note_outlined),
          label: 'Blogs',
        ),

        BottomNavigationBarItem(
          icon: Icon(Icons.video_file), 
          label: 'Courses'
        ),

        BottomNavigationBarItem(
          icon: Icon(Icons.accessibility_new_outlined), 
          label: 'Trainers'
        ),
      ],
    );
  }
}
