// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:gymnastic_center/presentation/screens/account/account_details_screen.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Column(
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Text('Profile'),

                // EDIT ICON - SETUP
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AccountDetailsScreen()),
                    );
                  },
                  child: Icon(Icons.create_sharp),
                ),
              ]),
            ],
          ),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(0),
            ),
          ),
        ),
        body: Column(
          children: [
            IntrinsicHeight(
              child: Container(
                decoration: const BoxDecoration(
                    color: Colors.deepPurple,
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(60),
                    )),
                padding: EdgeInsets.all(16.0),
                child: const Column(
                  // USER DATA - UPDATE
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          // USER PHOTO
                          backgroundImage: NetworkImage(
                              "https://secrecyjewels.es/blog/wp-content/uploads/2022/10/esencia-de-una-persona.jpg"),
                          backgroundColor: Colors.deepPurple,
                          radius: 50,
                        ),
                        SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Brooklyn Simmons', // USER FULL NAME
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                            Row(
                              children: [
                                Column(
                                  children: [
                                    Text(
                                      '1,420', // USER FOLLOWERS
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 24,
                                      ),
                                    ),
                                    Text(
                                      'followers',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.normal,
                                        fontSize: 18,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(width: 50),
                                Column(
                                  children: [
                                    Text(
                                      '730', // USER FOLLOWING
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 24,
                                      ),
                                    ),
                                    Text(
                                      'following',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.normal,
                                        fontSize: 18,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Icon(
                                  Icons.sentiment_satisfied_sharp,
                                  size: 20,
                                  color: Colors.white,
                                ),
                                SizedBox(width: 100), // IMPROVE
                                Text(
                                  '90 Hours', // USER HOURS
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Container(
                padding: const EdgeInsets.all(16.0),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Statistics',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                      ),
                    ),
                    Row(
                      // ADD BUTTON GESTURE
                      children: [
                        Text(
                          'See all',
                          style: TextStyle(fontSize: 14, color: Colors.black38),
                        ),
                        Icon(
                          size: 14,
                          Icons.arrow_forward_ios_rounded,
                          color: Colors.black38,
                        )
                      ],
                    )
                  ],
                )),
            Container(
                padding: const EdgeInsets.all(16.0),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'My Training',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                      ),
                    ),
                    Row(
                      // ADD BUTTON GESTURE
                      children: [
                        Text(
                          'See all',
                          style: TextStyle(fontSize: 14, color: Colors.black38),
                        ),
                        Icon(
                          size: 14,
                          Icons.arrow_forward_ios_rounded,
                          color: Colors.black38,
                        )
                      ],
                    )
                  ],
                )),
            Container(
                padding: const EdgeInsets.all(16.0),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'My Yoga Photos',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                      ),
                    ),
                    Row(
                      // ADD BUTTON GESTURE
                      children: [
                        Text(
                          'See all',
                          style: TextStyle(fontSize: 14, color: Colors.black38),
                        ),
                        Icon(
                          size: 14,
                          Icons.arrow_forward_ios_rounded,
                          color: Colors.black38,
                        )
                      ],
                    )
                  ],
                )),
          ],
        ));
  }
}