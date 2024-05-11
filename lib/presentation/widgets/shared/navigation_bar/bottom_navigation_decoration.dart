import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BottomNavigationDecoration extends StatelessWidget {
  final Size size;
  final int currentIndex;

  void onItemTapped(BuildContext context, int index) {
    context.go('/home/$index');
  }

  const BottomNavigationDecoration(
      {super.key, required this.size, required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return SizedBox(
      width: size.width,
      height: 80,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _CustomeIconButton(
            icon: Icons.home_rounded,
            activeIcon: Icons.home_outlined,
            index: 0,
            colors: colors,
            currentIndex: currentIndex,
            onItemTapped: onItemTapped,
          ),
          _CustomeIconButton(
            icon: Icons.accessible_forward_outlined,
            activeIcon: Icons.accessible_forward_outlined,
            index: 1,
            colors: colors,
            currentIndex: currentIndex,
            onItemTapped: onItemTapped,
          ),
          Container(
            width: size.width * 0.20,
          ),
          _CustomeIconButton(
            icon: Icons.settings_outlined,
            activeIcon: Icons.settings_outlined,
            index: 2,
            colors: colors,
            currentIndex: currentIndex,
            onItemTapped: onItemTapped,
          ),
          _CustomeIconButton(
            icon: Icons.notifications_outlined,
            activeIcon: Icons.notifications_active_outlined,
            index: 3,
            colors: colors,
            currentIndex: currentIndex,
            onItemTapped: onItemTapped,
          ),
        ],
      ),
    );
  }
}

class _CustomeIconButton extends StatelessWidget {
  final IconData icon;
  final IconData activeIcon;
  final int index;
  final int currentIndex;
  final ColorScheme colors;
  final void Function(BuildContext context, int index) onItemTapped;

  const _CustomeIconButton(
      {required this.icon,
      required this.activeIcon,
      required this.index,
      required this.colors,
      required this.currentIndex,
      required this.onItemTapped});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: currentIndex == index ? colors.primary : Colors.transparent,
            width: 2.0,
          ),
        ),
      ),
      child: IconButton(
        icon: Icon(
          currentIndex == index ? activeIcon : icon,
          color: currentIndex == index ? colors.primary : colors.secondary,
          size: 40.0,
        ),
        onPressed: () => onItemTapped(context, index),
        splashColor: Colors.white,
      ),
    );
  }
}
