import 'package:flutter/material.dart';

class NewTag extends StatelessWidget {
  final DateTime? courseDate;
  final double width;
  final double height;
  const NewTag({
    super.key,
    required this.courseDate,
    this.width = 60,
    this.height = 25,
  });

  @override
  Widget build(BuildContext context) {
    DateTime today = DateTime.now();
    if (courseDate != null) {
      if (today.difference(courseDate!) > const Duration(days: 15)) {
        return Container();
      }
    }

    return Padding(
      padding: const EdgeInsets.all(12),
      child: SizedBox(
        height: height,
        width: width,
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: const Color.fromRGBO(115, 81, 230, 1),
              borderRadius: BorderRadius.circular(20)),
          child: const Text(
            'New',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
