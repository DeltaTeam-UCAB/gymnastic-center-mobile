import 'package:flutter/material.dart';
import 'package:gymnastic_center/presentation/widgets/shared/navigation_bar/bottom_navigation_center_icon.dart';
import 'package:gymnastic_center/presentation/widgets/shared/navigation_bar/bottom_navigation_decoration.dart';

class CustomBottomNavigation extends StatelessWidget {
  final int currentIndex;
  const CustomBottomNavigation({super.key, required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final ThemeData theme = Theme.of(context);
    final backgroundColor =
        theme.brightness == Brightness.light ? Colors.white : Colors.grey[850];

    return SizedBox(
      width: size.width,
      height: 80,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          CustomPaint(
            size: Size(size.width, 80),
            painter: BNBCustomPainter(backgroundColor: backgroundColor!),
          ),
          Positioned(
              bottom: 45,
              left: (size.width - 70) / 2,
              child: const BottomNavigationCenterIcon()),
          BottomNavigationDecoration(size: size, currentIndex: currentIndex)
        ],
      ),
    );
  }
}

class BNBCustomPainter extends CustomPainter {
  final Color backgroundColor;

  BNBCustomPainter({super.repaint, required this.backgroundColor});
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = backgroundColor
      ..style = PaintingStyle.fill;

    Path path = Path();

    path.moveTo(0, 0); // Start
    path.quadraticBezierTo(size.width * 0.20, 0, size.width * 0.35, 0);
    path.quadraticBezierTo(size.width * 0.40, 0, size.width * 0.40, 5);
    path.arcToPoint(Offset(size.width * 0.60, 5),
        radius: const Radius.circular(10.0), clockwise: false);
    path.quadraticBezierTo(size.width * 0.60, 0, size.width * 0.65, 0);
    path.quadraticBezierTo(size.width * 0.80, 0, size.width, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.lineTo(0, 20);

    canvas.drawShadow(path, Colors.black, 5, true);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
