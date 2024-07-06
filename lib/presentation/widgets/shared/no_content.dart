import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NoContent extends StatelessWidget {
  final String image;

  const NoContent({
    super.key,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
        heightFactor: 1.75,
        child: Column(
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                const CircleAvatar(
                  radius: 90,
                  backgroundColor: Colors.deepPurpleAccent,
                ),
                SvgPicture.asset(
                  image,
                  height: 250,
                )
              ],
            ),
            const Text(
              'Ups!! No content yet...',
              style: TextStyle(fontSize: 17),
            )
          ],
        ));
  }
}
