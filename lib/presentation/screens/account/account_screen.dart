import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:gymnastic_center/application/themes/themes_bloc.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = context.watch<ThemesBloc>().isDarkMode;
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Column(
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                const Text('Profile'),

                // EDIT ICON - SETUP
                GestureDetector(
                  onTap: () => context.push('/account/details'),
                  child: const Icon(Icons.create_sharp),
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
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  // USER DATA - UPDATE
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.deepPurple,
                          radius: 50,
                          // USER PHOTO
                          child: CachedNetworkImage(
                            imageUrl:
                                "https://secrecyjewels.es/blog/wp-content/uploads/2022/10/esencia-de-una-persona.jpg",
                          ),
                        ),
                        const SizedBox(width: 10),
                        const Column(
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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Statistics',
                      style: TextStyle(
                        color: isDarkMode ? Colors.white : Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                      ),
                    ),
                    Row(
                      // ADD BUTTON GESTURE
                      children: [
                        Text(
                          'See all',
                          style: TextStyle(
                              fontSize: 14,
                              color: isDarkMode ? Colors.white : Colors.black),
                        ),
                        Icon(
                          size: 14,
                          Icons.arrow_forward_ios_rounded,
                          color: isDarkMode ? Colors.white : Colors.black,
                        )
                      ],
                    )
                  ],
                )),
            Container(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'My Training',
                      style: TextStyle(
                        color: isDarkMode ? Colors.white : Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                      ),
                    ),
                    Row(
                      // ADD BUTTON GESTURE
                      children: [
                        Text(
                          'See all',
                          style: TextStyle(
                              fontSize: 14,
                              color: isDarkMode ? Colors.white : Colors.black),
                        ),
                        Icon(
                          size: 14,
                          Icons.arrow_forward_ios_rounded,
                          color: isDarkMode ? Colors.white : Colors.black,
                        )
                      ],
                    )
                  ],
                )),
            Container(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'My Yoga Photos',
                      style: TextStyle(
                        color: isDarkMode ? Colors.white : Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                      ),
                    ),
                    Row(
                      // ADD BUTTON GESTURE
                      children: [
                        Text(
                          'See all',
                          style: TextStyle(
                              fontSize: 14,
                              color: isDarkMode ? Colors.white : Colors.black),
                        ),
                        Icon(
                          size: 14,
                          Icons.arrow_forward_ios_rounded,
                          color: isDarkMode ? Colors.white : Colors.black,
                        )
                      ],
                    )
                  ],
                )),
          ],
        ));
  }
}
