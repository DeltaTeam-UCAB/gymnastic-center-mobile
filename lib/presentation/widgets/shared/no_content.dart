import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NoContent extends StatelessWidget {
  final String image;
  final double heighFactor;
  final double height;
  final double width;
  final String text;

  const NoContent({
    super.key,
    this.heighFactor = 1.75,
    this.height = 250,
    this.width = 250,
    required this.image,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
        heightFactor: heighFactor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
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
                  width: width,
                  height: height,
                )
              ],
            ),
            Text(
              text,
              style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
            )
          ],
        ));
  }
}
