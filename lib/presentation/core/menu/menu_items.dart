import 'package:flutter/material.dart';

class MenuItem {
  final String title;
  final String route;
  final IconData icon;

  const MenuItem({
    required this.title,
    required this.route,
    required this.icon,
  });
}

const appMenuItems = <MenuItem>[
  MenuItem(
    title: 'Account',
    route: '/account/details',
    icon: Icons.account_circle_rounded,
  ),
  MenuItem(
    title: 'Notifications',
    route: '/notifications',
    icon: Icons.notifications_rounded,
  ),
  MenuItem(
    title: 'Privacy',
    route: '/privacy',
    icon: Icons.lock_rounded,
  ),
  MenuItem(
    title: 'FAQ',
    route: '/faq',
    icon: Icons.question_mark_rounded,
  ),
  MenuItem(
    title: 'Language',
    route: '/language',
    icon: Icons.language_rounded,
  ),
  MenuItem(
    title: 'Rate Us',
    route: '/rate-us',
    icon: Icons.star_rounded,
  ),
  MenuItem(
    title: 'Theme',
    route: '/configuration/theme',
    icon: Icons.phone_android_rounded,
  ),
  MenuItem(
    title: 'About',
    route: '/about',
    icon: Icons.info_rounded,
  ),
];
