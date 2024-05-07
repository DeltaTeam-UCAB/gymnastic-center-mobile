import 'package:flutter/material.dart';

class NewTag extends StatelessWidget {
  final DateTime? courseDate;
  const NewTag({
    super.key,
    required this.courseDate,
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
        height: 25,
        width: 60,
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
