import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'About us',
            style: TextStyle(color: Colors.white, fontFamily: 'PT Sans'),
          ),
        ),
        body: const Center(
          child: Column(
            children: [
              SizedBox(
                height: 50,
              ),
              CircleAvatar(
                radius: 100,
                backgroundImage: AssetImage('assets/Delta-team.jfif'),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Delta Team',
                style: TextStyle(fontSize: 35),
              ),
              Padding(
                padding: EdgeInsets.all(25.0),
                child: Text(
                  'Delta Team is a group of students of Informatics Engineering in UCAB (Universidad Católica Andrés Bello), Venezuela. This app was developed as their final project of the subject "Software Development". The system stands out for the use of Clean Architecture, DDD and SOLID principles, which are the main goal of this subject.',
                  overflow: TextOverflow.clip,
                ),
              )
            ],
          ),
        ));
  }
}
