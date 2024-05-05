import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gymnastic_center/presentation/screens/welcome_screen_pages/welcome_screen_community_page.dart';
import 'package:gymnastic_center/presentation/screens/welcome_screen_pages/welcome_screen_daily_yoga_page.dart';
import 'package:gymnastic_center/presentation/screens/welcome_screen_pages/welcome_screen_yoga_classes_page.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  WelcomeScreenState createState() => WelcomeScreenState();
}

class WelcomeScreenState extends State<WelcomeScreen> {
  int pageCount = 0;
  int selectedIndex = 0;
  PageController pageController = PageController(initialPage: 0);
  List<Widget> pages = [];

  void initializePages() {
    pages = [];
  }

  @override
  void initState() {
    initializePages();
    pageController = PageController(initialPage: 0);
    pageCount = pages.length;

    super.initState();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.78,
            child: PageView.builder(
                controller: pageController,
                itemCount: pageCount,
                onPageChanged: (index) {
                  setState(() {
                    selectedIndex = index;
                  });
                },
                itemBuilder: (_, pageIndex) {
                  return pages[pageIndex];
                }),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.14,
            child:
                Column(mainAxisAlignment: MainAxisAlignment.start, children: [
              Directionality(
                  textDirection: TextDirection.rtl,
                  child: FilledButton.icon(
                    onPressed: () {
                      animateToNextPage();
                    },
                    style: ElevatedButton.styleFrom(
                      maximumSize: const Size(107, 54),
                      padding: const EdgeInsets.fromLTRB(16, 14, 11, 14),
                      backgroundColor: Colors.white,
                      elevation: 20,
                      shadowColor: const Color.fromARGB(128, 0, 0, 0),
                    ),
                    label: const Expanded(
                        child: Text(
                      'Next',
                      style: TextStyle(fontSize: 16, color: Color(0xff222222)),
                    )),
                    icon: Container(
                        margin: const EdgeInsets.fromLTRB(12, 0, 0, 0),
                        child: SvgPicture.asset(
                          'assets/left-arrow-gradient-circle.svg',
                          width: 27,
                          height: 27,
                        )),
                  )),
            ]),
          ),
          const Divider(
            color: Color.fromRGBO(0, 0, 0, 0.07),
            thickness: 0,
            height: 1,
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.08 - 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                    onPressed: () {},
                    child: const Text(
                      'Skip',
                      style: TextStyle(color: Color(0xff677294), fontSize: 16),
                    )),
                ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: pageCount,
                  padding: const EdgeInsets.fromLTRB(0, 0, 15, 0),
                  itemBuilder: (_, index) {
                    return Center(
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 100),
                        decoration: BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10)),
                            color: (selectedIndex == index
                                ? const Color(0xff222222)
                                : const Color(0xff677294))),
                        margin: const EdgeInsets.all(5),
                        width: 5,
                        height: 5,
                      ),
                    );
                  },
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  void animateToNextPage() {
    pageController.nextPage(
        duration: const Duration(milliseconds: 200), curve: Curves.easeInOut);
  }
}
